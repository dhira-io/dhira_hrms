import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import 'package:dhira_hrms/core/widgets/common_app_bar.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_bloc.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_event.dart';
import 'package:dhira_hrms/features/dashboard/presentation/bloc/bottom_nav_cubit.dart';
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
            buildWhen: (previous, current) =>
                previous.status != current.status ||
                previous.editAssignments.isEmpty != current.editAssignments.isEmpty ||
                previous.errorMessage != current.errorMessage,
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

              return TimesheetContentView(timesheetId: timesheetId);
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            AddTaskBottomSheet.show(context, timesheetId: timesheetId);
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
