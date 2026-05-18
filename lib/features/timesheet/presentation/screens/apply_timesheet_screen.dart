import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_bloc.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_event.dart';
import 'package:dhira_hrms/features/dashboard/presentation/bloc/bottom_nav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/date_time_utils.dart';
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
import '../../../../core/widgets/common_app_bar.dart';
import 'package:get/get.dart';

class ApplyTimesheetScreen extends StatefulWidget {
  final String timesheetId;

  const ApplyTimesheetScreen({super.key, required this.timesheetId});

  @override
  State<ApplyTimesheetScreen> createState() => _ApplyTimesheetScreenState();
}

class _ApplyTimesheetScreenState extends State<ApplyTimesheetScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final today = DateTime.now();

      context.read<TimesheetBloc>().add(TimesheetEvent.daySelected(today));

      context.read<TimesheetBloc>().add(
        TimesheetEvent.fetchMonthWiseRequested(
          month: today.month,
          year: today.year,
        ),
      );

      context.read<TimesheetBloc>().add(
        TimesheetEvent.fetchOverviewRequested(
          month: today.month,
          year: today.year,
        ),
      );

      context.read<TimesheetBloc>().add(
        TimesheetEvent.started(timesheetId: widget.timesheetId),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<TimesheetBloc, TimesheetState>(
      listenWhen: (previous, current) => current.maybeMap(
        success: (_) => true,
        error: (_) => true,
        orElse: () => false,
      ),
      listener: (context, state) {
        state.mapOrNull(
          success: (s) {
            final displayMessage = _getSuccessMessage(
              s.successType,
              s.message,
              l10n,
            );
            ToastUtils.showSuccess(displayMessage);

            if (s.successType == TimesheetSuccessType.timesheetSubmitted) {
              // Switch to Approvals tab and show Raised Requests for Timesheet
              Get.find<BottomNavCubit>().changeIndex(
                BottomNavCubit.approvalsIndex,
              );
              Get.find<ApprovalsBloc>().add(
                const ApprovalsEvent.started(
                  initialCategory: ApprovalCategory.raised,
                  initialType: ApprovalType.timesheet,
                ),
              );

              context.pop();
            }
          },
          error: (e) {
            ToastUtils.showError(e.message);
          },
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.of(context).background,
        appBar: CommonAppBar(title: l10n.timesheetEntry),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: BlocBuilder<TimesheetBloc, TimesheetState>(
            builder: (context, state) {
              return RefreshIndicator(
                onRefresh: () async {
                  final selected = state.selectedDate ?? DateTime.now();

                  final startOfWeek = selected.subtract(
                    Duration(days: selected.weekday - 1),
                  );

                  final dominantMonth = DateTimeUtils.getDominantMonthOfWeek(
                    startOfWeek,
                  );

                  final dominantYear = DateTimeUtils.getDominantYearOfWeek(
                    startOfWeek,
                  );

                  context.read<TimesheetBloc>().add(
                    TimesheetEvent.fetchOverviewRequested(
                      month: dominantMonth,
                      year: dominantYear,
                    ),
                  );
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
                        filled: state.overview?.filled ?? 0,
                        approved: state.overview?.approved,
                        pending: state.overview?.pendingApproval,
                        rejected: state.overview?.correctionNeeded,
                        upcoming: state.overview?.upcomingToSubmit,
                        isLoading: state.maybeMap(
                          loading: (_) => true,
                          orElse: () => false,
                        ),
                      ),
                      const SizedBox(height: AppConstants.p24),
                      TimesheetWeekSelector(
                        selectedDate: state.selectedDate ?? DateTime.now(),
                        assignments: state.editAssignments,
                        totalWeeklyHours: state.weeklyTotalHours,
                        taskDays: state.taskDays,
                        holidayDays: state.holidayDays,
                        rangeText: state.currentWeekRangeText,
                        onDateSelected: (date) {
                          context.read<TimesheetBloc>().add(
                            TimesheetEvent.daySelected(date),
                          );
                        },
                        onPreviousWeek: () {
                          final current = state.selectedDate ?? DateTime.now();
                          final prevWeekDate = current.subtract(
                            const Duration(days: 7),
                          );
                          final startOfWeek = prevWeekDate.subtract(
                            Duration(days: prevWeekDate.weekday - 1),
                          );
                          final dominantMonth =
                              DateTimeUtils.getDominantMonthOfWeek(startOfWeek);
                          final dominantYear =
                              DateTimeUtils.getDominantYearOfWeek(startOfWeek);
                          final endOfWeek = startOfWeek.add(
                            const Duration(days: 6),
                          );

                          FocusManager.instance.primaryFocus?.unfocus();
                          context.read<TimesheetBloc>().add(
                            TimesheetEvent.daySelected(prevWeekDate),
                          );
                          context.read<TimesheetBloc>().add(
                            TimesheetEvent.fromDateChanged(startOfWeek),
                          );
                          context.read<TimesheetBloc>().add(
                            TimesheetEvent.toDateChanged(endOfWeek),
                          );

                          context.read<TimesheetBloc>().add(
                            TimesheetEvent.fetchMonthWiseRequested(
                              month: dominantMonth,
                              year: dominantYear,
                            ),
                          );

                          context.read<TimesheetBloc>().add(
                            TimesheetEvent.fetchOverviewRequested(
                              month: dominantMonth,
                              year: dominantYear,
                            ),
                          );
                        },
                        onNextWeek: () {
                          final current = state.selectedDate ?? DateTime.now();
                          final nextWeekDate = current.add(
                            const Duration(days: 7),
                          );
                          final startOfWeek = nextWeekDate.subtract(
                            Duration(days: nextWeekDate.weekday - 1),
                          );
                          final endOfWeek = startOfWeek.add(
                            const Duration(days: 6),
                          );
                          final dominantMonth =
                              DateTimeUtils.getDominantMonthOfWeek(startOfWeek);
                          final dominantYear =
                              DateTimeUtils.getDominantYearOfWeek(startOfWeek);
                          FocusManager.instance.primaryFocus?.unfocus();
                          context.read<TimesheetBloc>().add(
                            TimesheetEvent.daySelected(nextWeekDate),
                          );
                          context.read<TimesheetBloc>().add(
                            TimesheetEvent.fromDateChanged(startOfWeek),
                          );
                          context.read<TimesheetBloc>().add(
                            TimesheetEvent.toDateChanged(endOfWeek),
                          );

                          context.read<TimesheetBloc>().add(
                            TimesheetEvent.fetchMonthWiseRequested(
                              month: dominantMonth,
                              year: dominantYear,
                            ),
                          );

                          context.read<TimesheetBloc>().add(
                            TimesheetEvent.fetchOverviewRequested(
                              month: dominantMonth,
                              year: dominantYear,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: AppConstants.p24),
                      TimesheetTaskSection(
                        assignments: state.assignmentsForSelectedDay,
                        selectedDate: state.selectedDate,
                        onEdit: (task, index) {
                          context.read<TimesheetBloc>().add(
                            TimesheetEvent.editTaskRequested(
                              task: task,
                              index: state.editAssignments.indexOf(task),
                            ),
                          );
                        },
                        onDelete: (task) async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          final confirmed = await AppDialogs.showConfirmation(
                            context: context,
                            title: l10n.deleteTask,
                            message: l10n.deleteTaskConfirmation(
                              task.description ?? task.project,
                            ),
                            confirmLabel: l10n.delete,
                            isDestructive: true,
                          );

                          if (confirmed && context.mounted) {
                            FocusManager.instance.primaryFocus?.unfocus();

                            final tasksForWeek = state.editAssignments
                                .where((e) => e.parent == task.parent)
                                .toList();

                            final isLastTask = tasksForWeek.length == 1;
                            if (isLastTask) {
                              context.read<TimesheetBloc>().add(
                                TimesheetEvent.deleteTimesheetRequested(
                                  timesheetName: task.parent ?? "",
                                ),
                              );

                              return;
                            }

                            if (task.name != null) {
                              context.read<TimesheetBloc>().add(
                                TimesheetEvent.deleteEntryRequested(
                                  name: task.name!,
                                  parent: task.parent ?? "",
                                  date: task.date ?? "",
                                ),
                              );
                            } else {
                              final updated =
                                  List<ProjectAssignmentEntity>.from(
                                    state.editAssignments,
                                  )..remove(task);
                              context.read<TimesheetBloc>().add(
                                TimesheetEvent.assignmentsChanged(updated),
                              );
                            }
                          }
                        },
                      ),
                      const SizedBox(height: AppConstants.p24),
                      TimesheetApplyForm(
                        timesheetId: widget.timesheetId,
                        selectedDate: state.selectedDate ?? DateTime.now(),
                        editingTask: state.editingTask,
                        editingIndex: state.editingIndex,
                        onEditComplete: () => context.read<TimesheetBloc>().add(
                          const TimesheetEvent.editTaskCleared(),
                        ),
                        activeIdOverride: state.currentWeekActiveId,
                      ),
                      const SizedBox(height: AppConstants.p32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: state.isSubmitWeeklyLoading
                              ? null
                              : () {
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  context.read<TimesheetBloc>().add(
                                    const TimesheetEvent.submitWeeklyRequested(),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.of(context).primary,
                            padding: const EdgeInsets.symmetric(
                              vertical: AppConstants.p16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppConstants.r12,
                              ),
                            ),
                            elevation: 0,
                          ),
                          child: state.isSubmitWeeklyLoading
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Text(
                                  l10n.submitWeeklyTimesheet,
                                  style: AppTextStyle.button,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  String _getSuccessMessage(
    TimesheetSuccessType? type,
    String defaultMsg,
    AppLocalizations l10n,
  ) {
    if (type == null) return defaultMsg;
    return switch (type) {
      TimesheetSuccessType.taskAdded => l10n.taskAddedToDay,
      TimesheetSuccessType.timesheetSubmitted =>
        l10n.timesheetSubmittedSuccessfully,
      TimesheetSuccessType.taskUpdated => l10n.taskUpdatedSuccessfully,
      TimesheetSuccessType.taskDeleted => l10n.taskDeletedSuccessfully,
    };
  }
}
