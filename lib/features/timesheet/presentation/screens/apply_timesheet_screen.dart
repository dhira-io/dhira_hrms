import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import 'package:dhira_hrms/core/widgets/common_app_bar.dart';
import 'package:dhira_hrms/core/widgets/common_button.dart';
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
import 'package:dhira_hrms/features/timesheet/presentation/utils/timesheet_error_mapper.dart';
import 'package:dhira_hrms/features/timesheet/presentation/widgets/timesheet_content_view.dart';
import 'package:dhira_hrms/features/timesheet/presentation/widgets/timesheet_error_view.dart';
import 'package:dhira_hrms/features/timesheet/presentation/widgets/timesheet_loading_view.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ApplyTimesheetScreen extends StatefulWidget {
  final String timesheetId;

  const ApplyTimesheetScreen({super.key, required this.timesheetId});

  @override
  State<ApplyTimesheetScreen> createState() => _ApplyTimesheetScreenState();
}

class _ApplyTimesheetScreenState extends State<ApplyTimesheetScreen> {
  late final TimesheetBloc _timesheetBloc;

  @override
  void initState() {
    super.initState();
    _timesheetBloc = context.read<TimesheetBloc>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _timesheetBloc.add(const TimesheetEvent.editTaskCleared());
      }
    });
  }

  @override
  void dispose() {
    // Clear editing tasks state from shared TimesheetBloc to avoid state leaks
    _timesheetBloc.add(const TimesheetEvent.editTaskCleared());
    super.dispose();
  }

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
          ToastUtils.showError(
            state.errorMessage?.toLocalizedError(l10n) ??
                l10n.somethingWentWrong,
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.of(context).background,
        appBar: CommonAppBar(
          title: l10n.timesheetEntry,
          subtitle: l10n.trackWeeklyWorkHours,
        ),
        body: SafeArea(
          child: GestureDetector(
            onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
            child: BlocBuilder<TimesheetBloc, TimesheetState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status ||
                  previous.editAssignments.isEmpty !=
                      current.editAssignments.isEmpty ||
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
                        TimesheetEvent.started(timesheetId: widget.timesheetId),
                      );
                    },
                  );
                }

                return const TimesheetContentView();
              },
            ),
          ),
        ),
        bottomNavigationBar: BlocBuilder<TimesheetBloc, TimesheetState>(
          buildWhen: (previous, current) =>
              previous.hasDraftTasksInSelectedWeek !=
                  current.hasDraftTasksInSelectedWeek ||
              previous.isSubmitWeeklyLoading != current.isSubmitWeeklyLoading,
          builder: (context, state) {
            final hasDraft = state.hasDraftTasksInSelectedWeek;
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: AppColors.of(context).surfaceContainerLowest,
                border: Border(
                  top: BorderSide(color: AppColors.of(context).border),
                ),
              ),
              child: SafeArea(
                child: CommonButton(
                  text: l10n.submitWeeklyTimesheet,
                  width: double.infinity,
                  isLoading: state.isSubmitWeeklyLoading,
                  icon: Icons.check_circle_outlined,
                  onPressed: hasDraft
                      ? () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          context.read<TimesheetBloc>().add(
                            const TimesheetEvent.submitWeeklyRequested(),
                          );
                        }
                      : null,
                ),
              ),
            );
          },
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
