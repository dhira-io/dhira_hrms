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

  void _submitWeekly(BuildContext context, TimesheetState state) {
    final user = state.user;
    final from = state.editFromDate;
    final to = state.editToDate;
    final assignments = state.editAssignments;

    if (from == null || to == null) return;
    if (assignments.isEmpty) {
      ToastUtils.showError("Please add at least one task before submitting.");
      return;
    }

    // Same ID resolution logic as "Add To Day"
    final effectiveId = state.activeTimesheetId ?? (
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
        assignments: assignments,
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
        hoursTotal: assignments.fold(0.0, (sum, item) => sum + item.spentHours),
        assignments: assignments,
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
              success: (message, _, __, ___, ____, _____, ______, _______, ________, _________, __________) {
                ToastUtils.showSuccess(message);
                // Only pop if it was a final submission (not a draft add)
                if (message.toLowerCase().contains("submitted")) {
                  context.pop();
                }
              },
              error: (message, _, __, ___, ____, _____, ______, _______, ________, _________, __________) {
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
                        TimesheetBentoStats(
                          filled: 0.0,
                          approved: 0.0,
                          pending: 0.0,
                          rejected: 0.0,
                          upcoming: 0.0,
                        ),
                        const SizedBox(height: 24),
                        TimesheetWeekSelector(
                          selectedDate: selectedDate,
                          onDateSelected: (date) => context.read<TimesheetBloc>().add(TimesheetEvent.daySelected(date)),
                          onPreviousWeek: () {
                            final newDate = selectedDate.subtract(const Duration(days: 7));
                            context.read<TimesheetBloc>().add(TimesheetEvent.daySelected(newDate));
                            context.read<TimesheetBloc>().add(TimesheetEvent.fromDateChanged(newDate.subtract(Duration(days: newDate.weekday - 1))));
                            context.read<TimesheetBloc>().add(TimesheetEvent.toDateChanged(newDate.add(Duration(days: 7 - newDate.weekday))));
                          },
                          onNextWeek: () {
                            final newDate = selectedDate.add(const Duration(days: 7));
                            context.read<TimesheetBloc>().add(TimesheetEvent.daySelected(newDate));
                            context.read<TimesheetBloc>().add(TimesheetEvent.fromDateChanged(newDate.subtract(Duration(days: newDate.weekday - 1))));
                            context.read<TimesheetBloc>().add(TimesheetEvent.toDateChanged(newDate.add(Duration(days: 7 - newDate.weekday))));
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
                      onSubmit: () => _submitWeekly(context, state),
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


