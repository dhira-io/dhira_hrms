import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/project_assignment_entity.dart';
import '../../domain/entities/timesheet_entities.dart';
import '../widgets/timesheet_theme.dart';

import '../../../../core/utils/toast_utils.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../bloc/timesheet_bloc.dart';
import '../bloc/timesheet_event.dart';
import '../bloc/timesheet_state.dart';
import '../widgets/timesheet_apply_form.dart';
import '../widgets/timesheet_stats_bento.dart';
import '../widgets/timesheet_week_selector.dart';
import '../widgets/timesheet_task_section.dart';
import '../widgets/timesheet_submit_bar.dart';

class ApplyTimesheetScreen extends StatefulWidget {
  final String timesheetId;
  const ApplyTimesheetScreen({super.key, required this.timesheetId});

  @override
  State<ApplyTimesheetScreen> createState() => _ApplyTimesheetScreenState();
}

class _ApplyTimesheetScreenState extends State<ApplyTimesheetScreen> {
  ProjectAssignmentEntity? _editingTask;
  int? _editingIndex;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final bloc = context.read<TimesheetBloc>();
      
      if (widget.timesheetId == "current") {
        bloc.add(const TimesheetEvent.started());
      } else if (widget.timesheetId == "0") {
        bloc.add(const TimesheetEvent.assignmentsChanged([]));
        final now = DateTime.now();
        final from = now.subtract(Duration(days: now.weekday - 1));
        final to = from.add(const Duration(days: 6));
        bloc.add(TimesheetEvent.fromDateChanged(from));
        bloc.add(TimesheetEvent.toDateChanged(to));
        bloc.add(TimesheetEvent.daySelected(now));
      } else {
        // Since legacy single-fetch is removed, we default to loading the month-wise view
        bloc.add(const TimesheetEvent.started());
      }
      bloc.add(const TimesheetEvent.userInitRequested());
    });
  }

  void _submitWeekly(BuildContext context, TimesheetState state, String? currentWeekActiveId) {
    final user = state.user;
    final from = state.editFromDate;
    final to = state.editToDate;
    final assignments = state.editAssignments;

    if (from == null || to == null) return;

    // Filter assignments to only include those in the current week range
    final filteredAssignments = assignments.where((a) {
      if (a.date == null) return false;
      final d = DateTime.tryParse(a.date!);
      if (d == null) return false;
      final dateOnly = DateTime(d.year, d.month, d.day);
      final fromOnly = DateTime(from.year, from.month, from.day);
      final toOnly = DateTime(to.year, to.month, to.day);
      return (dateOnly.isAtSameMomentAs(fromOnly) || dateOnly.isAfter(fromOnly)) &&
             (dateOnly.isAtSameMomentAs(toOnly) || dateOnly.isBefore(toOnly));
    }).toList();

    // Specifically check for any tasks that are in "Draft" status
    final hasDraftTasks = filteredAssignments.any((a) => a.status?.toLowerCase() == "draft");

    if (!hasDraftTasks) {
      ToastUtils.showError("No Draft task found for week");
      return;
    }

    // Use the resolved currentWeekActiveId
    final effectiveId = currentWeekActiveId ?? (
      (widget.timesheetId != "0" && widget.timesheetId != "current")
        ? widget.timesheetId
        : null
    );

    if (effectiveId == null) {
      // No existing record — create with Pending status
      context.read<TimesheetBloc>().add(TimesheetEvent.submitRequested(
        employee: user?.empId ?? "",
        department: user?.department ?? "",
        approver: user?.approver ?? "",
        fromDate: from.format(),
        toDate: to.format(),
        assignments: filteredAssignments,
        docStatus: 1, // Pending
      ));
    } else {
      // Existing record — update with Pending status
      context.read<TimesheetBloc>().add(TimesheetEvent.updateRequested(
        name: effectiveId,
        employee: user?.empId ?? "",
        department: user?.department ?? "",
        approver: user?.approver ?? "",
        fromDate: from.format(),
        toDate: to.format(),
        approved: 1, // Pending
        hoursTotal: filteredAssignments.fold(0.0, (sum, item) => sum + item.spentHours),
        assignments: filteredAssignments,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TimesheetBloc>.value(
      value: Get.find<TimesheetBloc>(),
        child: BlocListener<TimesheetBloc, TimesheetState>(
          listenWhen: (previous, current) {
            return current.maybeMap(
              success: (_) => true,
              error: (_) => true,
              orElse: () => false,
            );
          },
          listener: (context, state) {
            state.maybeWhen(
              success: (message, _, __, ___, ____, _____, ______, _______, ________, _________, __________, ___________) {
                ToastUtils.showSuccess(message);
                // Only pop if it was a final submission (not a draft add)
                if (message.toLowerCase().contains("submitted")) {
                  context.pop();
                }
              },
              error: (message, _, __, ___, ____, _____, ______, _______, ________, _________, __________, ___________) {
                ToastUtils.showError(message);
              },
              orElse: () {},
            );
          },
        child: BlocBuilder<TimesheetBloc, TimesheetState>(
          builder: (context, state) {
            final selectedDate = state.selectedDate ?? DateTime.now();
            final assignmentsForDay = state.editAssignments.where((a) {
              if (a.date == null) return false;
              final d = DateTime.tryParse(a.date!);
              return d?.year == selectedDate.year &&
                  d?.month == selectedDate.month &&
                  d?.day == selectedDate.day;
            }).toList();

            final totalSpent = state.editAssignments.fold(0.0, (sum, a) => sum + a.spentHours);

            // Helper to format week lists from metadata
            String formatWeeks(dynamic data) {
              if (data == null) return "";
              if (data is List) {
                if (data.isEmpty) return "";
                final labels = data.map((item) {
                  if (item is Map && item.containsKey('label')) {
                    return item['label'].toString();
                  }
                  return "Week $item";
                }).toList();
                return labels.join(", ");
              }
              return "";
            }

            final weekMeta = state.overview?.weekMeta ?? {};

            // Dynamically find the active timesheet ID for the CURRENT selected week
            String? findActiveIdForWeek() {
              if (state.editAssignments.isEmpty) return null;
              final startOfWeek = selectedDate.subtract(Duration(days: selectedDate.weekday - 1));
              final endOfWeek = startOfWeek.add(const Duration(days: 6));
              
              final weekOnlyStart = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
              final weekOnlyEnd = DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day, 23, 59, 59);

              for (var a in state.editAssignments) {
                if (a.date == null || a.parent == null) continue;
                final d = DateTime.tryParse(a.date!);
                if (d != null && d.isAfter(weekOnlyStart.subtract(const Duration(seconds: 1))) && d.isBefore(weekOnlyEnd)) {
                  return a.parent;
                }
              }
              return null;
            }

            final currentWeekActiveId = findActiveIdForWeek();

            // Calculate the 5 month options (past 3, current, next 1)
            final now = DateTime.now();
            final availableMonths = List.generate(5, (index) {
              return DateTime(now.year, now.month - 3 + index, 1);
            });

            return Scaffold(
              backgroundColor: TimesheetColors.background,
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: TimesheetColors.primary),
                  onPressed: () => context.pop(),
                ),
                title: Text(
                  "Timesheet Entry",
                  style: TimesheetStyles.h3.copyWith(color: TimesheetColors.primary, fontWeight: FontWeight.bold),
                ),
                centerTitle: false,
                backgroundColor: Colors.white.withValues(alpha: 0.8),
                surfaceTintColor: Colors.transparent,
              ),
              body: Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(16, 24, 16, 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Month Selection Dropdown
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                          margin: const EdgeInsets.only(bottom: 20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: TimesheetColors.border.withValues(alpha: 0.5)),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<DateTime>(
                              value: availableMonths.firstWhere(
                                (m) => m.month == selectedDate.month && m.year == selectedDate.year,
                                orElse: () => availableMonths[3], // Fallback to current month
                              ),
                              icon: const Icon(Icons.keyboard_arrow_down, color: TimesheetColors.primary),
                              items: availableMonths.map((date) {
                                return DropdownMenuItem<DateTime>(
                                  value: date,
                                  child: Row(
                                    children: [
                                      const Icon(Icons.calendar_today_outlined, size: 16, color: TimesheetColors.primary),
                                      const SizedBox(width: 12),
                                      Text(
                                        "${DateTimeUtils.formatToMonthName(date)} ${date.year}",
                                        style: TimesheetStyles.statsLabel.copyWith(
                                          color: Colors.black87,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (DateTime? newValue) {
                                if (newValue != null) {
                                  final bloc = context.read<TimesheetBloc>();
                                  bloc.add(TimesheetEvent.daySelected(newValue));
                                  bloc.add(TimesheetEvent.fromDateChanged(newValue.subtract(Duration(days: newValue.weekday - 1))));
                                  bloc.add(TimesheetEvent.toDateChanged(newValue.add(Duration(days: 7 - newValue.weekday))));
                                  bloc.add(TimesheetEvent.fetchMonthWiseRequested(month: newValue.month, year: newValue.year));
                                }
                              },
                            ),
                          ),
                        ),
                        TimesheetBentoStats(
                          filled: state.overview?.filled ?? 0,
                          approved: state.overview?.approved ?? 0,
                          pending: state.overview?.pendingApproval ?? 0,
                          rejected: state.overview?.correctionNeeded ?? 0,
                          upcoming: state.overview?.upcomingToSubmit ?? 0,
                          filledWeeks: formatWeeks(weekMeta['filled']),
                          approvedWeeks: formatWeeks(weekMeta['approved']),
                          pendingWeeks: formatWeeks(weekMeta['pending_approval']),
                          rejectedWeeks: formatWeeks(weekMeta['correction_needed']),
                          upcomingWeeks: formatWeeks(weekMeta['upcoming_to_submit']),
                        ),
                        const SizedBox(height: 24),
                        TimesheetWeekSelector(
                          selectedDate: selectedDate,
                          onDateSelected: (date) => context.read<TimesheetBloc>().add(TimesheetEvent.daySelected(date)),
                          onPreviousWeek: () {
                            final newDate = selectedDate.subtract(const Duration(days: 7));
                            final bloc = context.read<TimesheetBloc>();
                            bloc.add(TimesheetEvent.daySelected(newDate));
                            bloc.add(TimesheetEvent.fromDateChanged(newDate.subtract(Duration(days: newDate.weekday - 1))));
                            bloc.add(TimesheetEvent.toDateChanged(newDate.add(Duration(days: 7 - newDate.weekday))));
                            
                            if (newDate.month != selectedDate.month || newDate.year != selectedDate.year) {
                              bloc.add(TimesheetEvent.fetchMonthWiseRequested(month: newDate.month, year: newDate.year));
                            }
                          },
                          onNextWeek: () {
                            final newDate = selectedDate.add(const Duration(days: 7));
                            final bloc = context.read<TimesheetBloc>();
                            bloc.add(TimesheetEvent.daySelected(newDate));
                            bloc.add(TimesheetEvent.fromDateChanged(newDate.subtract(Duration(days: newDate.weekday - 1))));
                            bloc.add(TimesheetEvent.toDateChanged(newDate.add(Duration(days: 7 - newDate.weekday))));

                            if (newDate.month != selectedDate.month || newDate.year != selectedDate.year) {
                              bloc.add(TimesheetEvent.fetchMonthWiseRequested(month: newDate.month, year: newDate.year));
                            }
                          },
                        ),
                        const SizedBox(height: 24),
                        TimesheetTaskSection(
                          tasks: assignmentsForDay,
                          onEdit: (idx) {
                            final task = assignmentsForDay[idx];
                            // Find absolute index in full list
                            final absIdx = state.editAssignments.indexOf(task);
                            setState(() {
                              _editingTask = task;
                              _editingIndex = absIdx;
                            });
                            // Scroll to form
                          },
                          onDelete: (idx) async {
                            final task = assignmentsForDay[idx];
                            final confirmed = await showDialog<bool>(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                title: const Text("Delete Task"),
                                content: Text("Are you sure you want to delete \"${task.description?.isNotEmpty == true ? task.description : task.project}\"?"),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(ctx, false),
                                    child: const Text("Cancel"),
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(backgroundColor: TimesheetColors.error),
                                    onPressed: () => Navigator.pop(ctx, true),
                                    child: const Text("Delete", style: TextStyle(color: Colors.white)),
                                  ),
                                ],
                              ),
                            );
                            if (confirmed == true && context.mounted) {
                              if (task.name != null && task.parent != null) {
                                // Sync deletion to server using dedicated API
                                context.read<TimesheetBloc>().add(TimesheetEvent.deleteEntryRequested(
                                  name: task.name!,
                                  parent: task.parent!,
                                  date: task.date ?? "",
                                ));
                                // Note: Bloc will handle state update upon success
                              } else {
                                // Local only deletion (for new tasks not yet synced)
                                final updated = List<ProjectAssignmentEntity>.from(state.editAssignments)..remove(task);
                                context.read<TimesheetBloc>().add(TimesheetEvent.assignmentsChanged(updated));
                              }
                            }
                          },
                        ),
                        const SizedBox(height: 24),
                        TimesheetApplyForm(
                          timesheetId: widget.timesheetId,
                          editingTask: _editingTask,
                          editingIndex: _editingIndex,
                          activeIdOverride: currentWeekActiveId,
                          onEditComplete: () => setState(() {
                            _editingTask = null;
                            _editingIndex = null;
                          }),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: TimesheetSubmitBar(
                      onCancel: () => context.pop(),
                      onSubmit: () => _submitWeekly(context, state, currentWeekActiveId),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}


