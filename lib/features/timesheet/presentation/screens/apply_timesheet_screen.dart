import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../shared/dialogs/app_dialogs.dart';
import '../bloc/timesheet_bloc.dart';
import '../bloc/timesheet_event.dart';
import '../bloc/timesheet_state.dart';
import '../bloc/timesheet_success_type.dart';
import '../widgets/timesheet_apply_form.dart';
import '../widgets/timesheet_task_section.dart';
import '../widgets/timesheet_stats_bento.dart';
import '../widgets/timesheet_week_selector.dart';
import '../../domain/entities/timesheet_entities.dart';
import '../../../../l10n/app_localizations.dart';

class ApplyTimesheetScreen extends StatefulWidget {
  final String timesheetId;

  const ApplyTimesheetScreen({
    super.key,
    required this.timesheetId,
  });

  @override
  State<ApplyTimesheetScreen> createState() => _ApplyTimesheetScreenState();
}

class _ApplyTimesheetScreenState extends State<ApplyTimesheetScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TimesheetBloc>().add(TimesheetEvent.started(timesheetId: widget.timesheetId));
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<TimesheetBloc, TimesheetState>(
      listenWhen: (previous, current) =>
          current.maybeMap(success: (_) => true, error: (_) => true, orElse: () => false),
      listener: (context, state) {
        state.mapOrNull(
          success: (s) {
            final displayMessage = _getSuccessMessage(s.successType, s.message, l10n);
            ToastUtils.showSuccess(displayMessage);

            if (s.successType == TimesheetSuccessType.timesheetSubmitted) {
              context.pop();
            }
          },
          error: (e) {
            final displayMessage = e.message == "No Draft task found for week" ? l10n.noDraftTasksFound : e.message;
            ToastUtils.showError(displayMessage);
          },
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          title: Text(l10n.timesheetEntry, style: AppTextStyle.h3),
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: AppColors.textPrimary, size: AppConstants.iconSmall),
            onPressed: () => context.pop(),
          ),
        ),
        body: BlocBuilder<TimesheetBloc, TimesheetState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                final now = DateTime.now();
                context.read<TimesheetBloc>().add(TimesheetEvent.fetchMonthWiseRequested(month: now.month, year: now.year));
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.all(AppConstants.p20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TimesheetBentoStats(
                      editAssignments: state.editAssignments,
                      selectedDate: state.selectedDate ?? DateTime.now(),
                      weekMeta: state.formattedOverviewWeeks,
                      filled: state.overview?.filled,
                      approved: state.overview?.approved,
                      pending: state.overview?.pendingApproval,
                      rejected: state.overview?.correctionNeeded,
                      upcoming: state.overview?.upcomingToSubmit,
                      isLoading: state.maybeMap(loading: (_) => true, orElse: () => false),
                    ),
                    const SizedBox(height: AppConstants.p24),
                    TimesheetWeekSelector(
                      selectedDate: state.selectedDate ?? DateTime.now(),
                      assignments: state.editAssignments,
                      totalWeeklyHours: state.editAssignments.where((a) {
                        if (a.date == null) return false;
                        final d = DateTime.tryParse(a.date!);
                        if (d == null) return false;
                        final selected = state.selectedDate ?? DateTime.now();
                        final startOfWeek = selected.subtract(Duration(days: selected.weekday - 1));
                        final endOfWeek = startOfWeek.add(const Duration(days: 6));
                        final weekStart = DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day);
                        final weekEnd = DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day, 23, 59, 59);
                        return d.isAfter(weekStart.subtract(const Duration(seconds: 1))) && d.isBefore(weekEnd);
                      }).fold(0.0, (sum, item) => sum + item.spentHours),
                      onDateSelected: (date) {
                        context.read<TimesheetBloc>().add(TimesheetEvent.daySelected(date));
                      },
                      onPreviousWeek: () {
                        final current = state.selectedDate ?? DateTime.now();
                        final prevWeekDate = current.subtract(const Duration(days: 7));
                        final startOfWeek = prevWeekDate.subtract(Duration(days: prevWeekDate.weekday - 1));
                        final endOfWeek = startOfWeek.add(const Duration(days: 6));
                        
                        context.read<TimesheetBloc>().add(TimesheetEvent.daySelected(prevWeekDate));
                        context.read<TimesheetBloc>().add(TimesheetEvent.fromDateChanged(startOfWeek));
                        context.read<TimesheetBloc>().add(TimesheetEvent.toDateChanged(endOfWeek));
                        
                        if (current.month != prevWeekDate.month || current.year != prevWeekDate.year) {
                          context.read<TimesheetBloc>().add(TimesheetEvent.fetchMonthWiseRequested(month: prevWeekDate.month, year: prevWeekDate.year));
                        }
                      },
                      onNextWeek: () {
                        final current = state.selectedDate ?? DateTime.now();
                        final nextWeekDate = current.add(const Duration(days: 7));
                        final startOfWeek = nextWeekDate.subtract(Duration(days: nextWeekDate.weekday - 1));
                        final endOfWeek = startOfWeek.add(const Duration(days: 6));

                        context.read<TimesheetBloc>().add(TimesheetEvent.daySelected(nextWeekDate));
                        context.read<TimesheetBloc>().add(TimesheetEvent.fromDateChanged(startOfWeek));
                        context.read<TimesheetBloc>().add(TimesheetEvent.toDateChanged(endOfWeek));
                        
                        if (current.month != nextWeekDate.month || current.year != nextWeekDate.year) {
                          context.read<TimesheetBloc>().add(TimesheetEvent.fetchMonthWiseRequested(month: nextWeekDate.month, year: nextWeekDate.year));
                        }
                      },
                    ),
                    const SizedBox(height: AppConstants.p24),
                    TimesheetTaskSection(
                      assignments: state.assignmentsForSelectedDay,
                      selectedDate: state.selectedDate,
                      onEdit: (task, index) {
                        context.read<TimesheetBloc>().add(TimesheetEvent.editTaskRequested(
                          task: task, 
                          index: state.editAssignments.indexOf(task)
                        ));
                      },
                      onDelete: (task) async {
                        final confirmed = await AppDialogs.showConfirmation(
                          context: context,
                          title: l10n.deleteTask,
                          message: l10n.deleteTaskConfirmation(task.description ?? task.project),
                          confirmLabel: l10n.delete,
                          isDestructive: true,
                        );
                        
                        if (confirmed && context.mounted) {
                          if (task.name != null) {
                            context.read<TimesheetBloc>().add(TimesheetEvent.deleteEntryRequested(
                                  name: task.name!,
                                  parent: task.parent ?? "",
                                  date: task.date ?? "",
                                ));
                          } else {
                            final updated = List<ProjectAssignmentEntity>.from(state.editAssignments)..remove(task);
                            context.read<TimesheetBloc>().add(TimesheetEvent.assignmentsChanged(updated));
                          }
                        }
                      },
                    ),
                    const SizedBox(height: AppConstants.p24),
                    TimesheetApplyForm(
                      timesheetId: widget.timesheetId,
                      editingTask: state.editingTask,
                      editingIndex: state.editingIndex,
                      onEditComplete: () => context.read<TimesheetBloc>().add(const TimesheetEvent.editTaskCleared()),
                      activeIdOverride: state.currentWeekActiveId,
                    ),
                    const SizedBox(height: AppConstants.p32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: state.isActionLoading
                            ? null
                            : () => context.read<TimesheetBloc>().add(const TimesheetEvent.submitWeeklyRequested()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(vertical: AppConstants.p16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r12)),
                          elevation: 0,
                        ),
                        child: state.isActionLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                              )
                            : Text(l10n.submitWeeklyTimesheet, style: AppTextStyle.button),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  String _getSuccessMessage(TimesheetSuccessType? type, String defaultMsg, AppLocalizations l10n) {
    if (type == null) return defaultMsg;
    return switch (type) {
      TimesheetSuccessType.taskAdded => l10n.taskAddedToDay,
      TimesheetSuccessType.timesheetSubmitted => l10n.timesheetSubmittedSuccessfully,
      TimesheetSuccessType.taskUpdated => l10n.taskUpdatedSuccessfully,
      TimesheetSuccessType.taskDeleted => l10n.taskDeletedSuccessfully,
    };
  }
}
