import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import 'package:dhira_hrms/core/widgets/common_app_bar.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_bloc.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_event.dart';
import 'package:dhira_hrms/features/dashboard/presentation/bloc/bottom_nav_cubit.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_assignment_entity.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_bloc.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_event.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_state.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_status.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_success_type.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bottomsheet/add_task_bottom_sheet.dart';
import 'package:dhira_hrms/features/timesheet/presentation/widgets/timesheet_content_view.dart';
import 'package:dhira_hrms/features/timesheet/presentation/widgets/timesheet_error_view.dart';
import 'package:dhira_hrms/features/timesheet/presentation/widgets/timesheet_loading_view.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/shared/dialogs/app_dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ApplyTimesheetScreen extends StatelessWidget {
  final String timesheetId;

  const ApplyTimesheetScreen({super.key, required this.timesheetId});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocListener<TimesheetBloc, TimesheetState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          (current.status == TimesheetStateStatus.success ||
              current.status == TimesheetStateStatus.error),
      listener: (context, state) {
        if (state.status == TimesheetStateStatus.success) {
          final displayMessage = _getSuccessMessage(
            state.successType,
            state.successMessage ?? "",
            l10n,
          );
          ToastUtils.showSuccess(displayMessage);

          if (state.successType == TimesheetSuccessType.timesheetSubmitted) {
            // Switch to Approvals tab and show Raised Requests for Timesheet
            context.read<BottomNavCubit>().changeIndex(
              BottomNavCubit.approvalsIndex,
            );
            context.read<ApprovalsBloc>().add(
              const ApprovalsEvent.started(
                initialCategory: ApprovalCategory.raised,
                initialType: ApprovalType.timesheet,
              ),
            );

            context.pop();
          }
        } else if (state.status == TimesheetStateStatus.error) {
          ToastUtils.showError(_getErrorMessage(state.errorMessage, l10n));
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.of(context).background,
        appBar: CommonAppBar(title: l10n.timesheetEntry),
        body: GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: BlocBuilder<TimesheetBloc, TimesheetState>(
            builder: (context, state) {
              if ((state.status == TimesheetStateStatus.initial ||
                      state.status == TimesheetStateStatus.loading) &&
                  state.editAssignments.isEmpty) {
                return const TimesheetLoadingView();
              }

              if (state.status == TimesheetStateStatus.error &&
                  state.editAssignments.isEmpty) {
                return TimesheetErrorView(
                  message: state.errorMessage ?? l10n.somethingWentWrong,
                  onRetry: () {
                    context.read<TimesheetBloc>().add(
                      TimesheetEvent.started(timesheetId: timesheetId),
                    );
                  },
                );
              }

              return TimesheetContentView(
                state: state,
                onEdit: (task, index) {
                  final bloc = context.read<TimesheetBloc>();
                  bloc.add(
                    TimesheetEvent.editTaskRequested(
                      task: task,
                      index: bloc.state.editAssignments.indexOf(task),
                    ),
                  );
                  _showAddTaskBottomSheet(
                    context,
                    editingTask: task,
                    editingIndex: bloc.state.editAssignments.indexOf(task),
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

                    final bloc = context.read<TimesheetBloc>();
                    final tasksForWeek = bloc.state.editAssignments
                        .where((e) => e.parent == task.parent)
                        .toList();

                    final isLastTask = tasksForWeek.length == 1;
                    if (isLastTask) {
                      bloc.add(
                        TimesheetEvent.deleteTimesheetRequested(
                          timesheetName: task.parent ?? "",
                        ),
                      );
                      return;
                    }

                    if (task.name != null) {
                      bloc.add(
                        TimesheetEvent.deleteEntryRequested(
                          name: task.name!,
                          parent: task.parent ?? "",
                          date: task.date ?? "",
                        ),
                      );
                    } else {
                      final updated = List<ProjectAssignmentEntity>.from(
                        bloc.state.editAssignments,
                      )..remove(task);
                      bloc.add(TimesheetEvent.assignmentsChanged(updated));
                    }
                  }
                },
                onSubmitWeekly: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  context.read<TimesheetBloc>().add(
                    const TimesheetEvent.submitWeeklyRequested(),
                  );
                },
                onRefresh: () async {
                  final timesheetBloc = context.read<TimesheetBloc>();
                  final selected =
                      timesheetBloc.state.selectedDate ?? DateTime.now();

                  final startOfWeek = selected.subtract(
                    Duration(days: selected.weekday - 1),
                  );

                  final dominantMonth = DateTimeUtils.getDominantMonthOfWeek(
                    startOfWeek,
                  );

                  final dominantYear = DateTimeUtils.getDominantYearOfWeek(
                    startOfWeek,
                  );

                  timesheetBloc.add(
                    TimesheetEvent.fetchOverviewRequested(
                      month: dominantMonth,
                      year: dominantYear,
                    ),
                  );
                },
              );
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _showAddTaskBottomSheet(context);
          },
          backgroundColor: AppColors.of(context).primary,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Icon(
            Icons.add_task,
            color: AppColors.of(context).white,
            size: 24,
          ),
        ),
      ),
    );
  }

  void _showAddTaskBottomSheet(
    BuildContext context, {
    ProjectAssignmentEntity? editingTask,
    int? editingIndex,
  }) {
    final timesheetBloc = context.read<TimesheetBloc>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.of(context).transparent,
      builder: (bottomSheetContext) {
        return BlocProvider.value(
          value: timesheetBloc,
          child: AddTaskBottomSheet(
            timesheetId: timesheetId,
            editingTask: editingTask,
            editingIndex: editingIndex,
            onEditComplete: () =>
                timesheetBloc.add(const TimesheetEvent.editTaskCleared()),
            activeIdOverride: timesheetBloc.state.currentWeekActiveId,
          ),
        );
      },
    ).then((_) {
      timesheetBloc.add(const TimesheetEvent.editTaskCleared());
    });
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

  String _getErrorMessage(String? key, AppLocalizations l10n) {
    if (key == null) return l10n.somethingWentWrong;
    return switch (key) {
      "selectProjectValidation" => l10n.selectProjectValidation,
      "taskValidation" => l10n.taskValidation,
      "expectedHoursValidation" => l10n.expectedHoursValidation,
      "actualHoursValidation" => l10n.actualHoursValidation,
      "descriptionValidation" => l10n.descriptionValidation,
      "noChangesDone" => l10n.noChangesDone,
      _ => key,
    };
  }
}
