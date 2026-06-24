import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_router.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/presentation/screens/leave_edit_screen.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_state.dart';
import 'package:dhira_hrms/features/approvals/presentation/bottom_sheets/edit_timesheet_bottom_sheet.dart';
import 'package:dhira_hrms/features/approvals/presentation/dialogs/delete_timesheet_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/data/datasources/auth_remote_datasource.dart';
import '../../../leave/domain/entities/leave_entity.dart';
import '../../domain/entities/approval_request_entity.dart';
import '../bloc/approvals_bloc.dart';
import '../bloc/approvals_event.dart';

import '../dialogs/action_confirmation_dialog.dart';
import '../bottom_sheets/request_details_bottom_sheet.dart';
import 'approval_card/team_approval_card_view.dart';
import 'approval_card/raised_approval_card_view.dart';

class ApprovalCard extends StatelessWidget {
  final ApprovalRequestEntity data;
  final bool isSelected;
  final Function(bool)? onSelectionChanged;

  const ApprovalCard({
    super.key,
    required this.data,
    this.isSelected = false,
    this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (_) => BlocProvider.value(
            value: context.read<ApprovalsBloc>(),
            child: FractionallySizedBox(
              heightFactor: 0.9,
              child: RequestDetailsBottomSheet(
                data: data,
                onEditRequest: () {
                  if (data.type == ApprovalType.leave) {
                    _onEditLeave(context);
                  } else if (data.type == ApprovalType.timesheet) {
                    _onEditTimesheet(context);
                  }
                },
              ),
            ),
          ),
        );
      },
      borderRadius: BorderRadius.circular(AppConstants.r16),
      child: Container(
        padding: const EdgeInsets.all(AppConstants.p16),
        margin: const EdgeInsets.only(bottom: AppConstants.p16),
        decoration: BoxDecoration(
          color: AppColors.of(context).surfaceContainerLowest,
          borderRadius: BorderRadius.circular(AppConstants.r16),
          boxShadow: [
            BoxShadow(
              color: AppColors.of(context).black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: BlocSelector<ApprovalsBloc, ApprovalsState, bool>(
          selector: (state) => state?.maybeMap(
            success: (s) => s.data.processingIds.contains(data.id),
            orElse: () => false,
          ) ?? false,
          builder: (context, isProcessing) {
            if (data.category == ApprovalCategory.raised) {
              return RaisedApprovalCardView(
                data: data,
                onEdit: () {
                  if (data.type == ApprovalType.timesheet) {
                    _onEditTimesheet(context);
                  } else {
                    _onEditLeave(context);
                  }
                },
                onDelete: () {
                  if (data.type == ApprovalType.timesheet) {
                    _onDeleteTimesheet(context);
                  } else {
                    _onWithdrawLeave(context);
                  }
                },
                isProcessing: isProcessing,
              );
            } else {
              return TeamApprovalCardView(
                data: data,
                isSelected: isSelected,
                onSelectionChanged: onSelectionChanged,
                onAction: (action) => _showActionConfirmation(context, action),
                isProcessing: isProcessing,
              );
            }
          },
        ),
      ),
    );
  }

  void _onWithdrawLeave(BuildContext context) {
    _showActionConfirmation(context, ApprovalActions.cancel);
  }

  Future<void> _onEditLeave(BuildContext context) async {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final localStorage = Get.find<LocalStorageService>();
      final userId = localStorage.getUserEmail() ?? "";

      final authDataSource = Get.find<AuthRemoteDataSource>();
      final employee = await authDataSource.getEmployeeDetails(userId);

      if (context.mounted) {
        Navigator.pop(context); // Remove loading indicator

        final leaveType = data.displayDetails[RequestDetailKeys.leaveType] ?? "";
        final reason = data.displayDetails['Reason'] ?? "";
        final daysText = data.displayDetails[RequestDetailKeys.days] ?? "0";
        final double days = double.tryParse(daysText.split(' ').first) ?? 0.0;

        String? segment = data.customHalfDetails ?? data.halfDaySegment;
        if (segment != null && segment.isNotEmpty) {
          final s = segment.toLowerCase();
          if (s.contains(HalfDaySegments.first) ||
              s.contains(HalfDaySegments.morning) ||
              s.contains(HalfDaySegments.firstShort)) {
            segment = l10n.firstHalf;
          } else if (s.contains(HalfDaySegments.second) ||
              s.contains(HalfDaySegments.afternoon) ||
              s.contains(HalfDaySegments.secondShort)) {
            segment = l10n.secondHalf;
          }
        }

        final leave = LeaveEntity(
          name: data.id,
          employee: employee.empId,
          employeeName: employee.employeeName ?? AppConstants.noneValue,
          leaveType: leaveType,
          fromDate: data.fromDate?.format() ?? "",
          toDate: data.toDate?.format() ?? "",
          status: data.status,
          description: reason,
          totalLeaveDays: days,
          halfDay: (data.isHalfDay || days == 0.5) ? 1 : 0,
          halfDayDate:
              data.halfDayDate ??
              ((data.isHalfDay || days == 0.5)
                  ? data.fromDate?.format()
                  : null),
          halfDaySegment: segment,
          fileUrl: data.fileUrl,
        );

        context.push(
          AppRouter.applyLeavePath,
          extra: {
            AppRouter.argEmployeeId: employee.empId,
            AppRouter.argLeave: leave,
          },
        );
      }
    } catch (e) {
      if (context.mounted) {
        Navigator.pop(context);
        ToastUtils.showError(l10n.somethingWentWrong);
      }
    }
  }

  void _showActionConfirmation(BuildContext context, String action) {
    final approvalsBloc = context.read<ApprovalsBloc>();
    showDialog(
      context: context,
      builder: (context) => ActionConfirmationDialog(
        action: action,
        data: data,
        onConfirm: () {
          approvalsBloc.add(
            ApprovalsEvent.workflowActionSubmitted(
              requestId: data.id,
              action: action,
              type: data.type,
              category: data.category,
            ),
          );
        },
      ),
    );
  }

  void _onEditTimesheet(BuildContext context) {
    final approvalsBloc = context.read<ApprovalsBloc>();
    approvalsBloc.add(
      ApprovalsEvent.editTimesheetRequested(requestId: data.id),
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) => BlocProvider.value(
        value: approvalsBloc,
        child: const EditTimesheetBottomSheet(),
      ),
    );
  }

  void _onDeleteTimesheet(BuildContext context) {
    final approvalsBloc = context.read<ApprovalsBloc>();
    showDialog(
      context: context,
      builder: (context) => DeleteTimesheetDialog(
        requestId: data.id,
        onDelete: () {
          approvalsBloc.add(
            ApprovalsEvent.deleteTimesheetRequested(requestId: data.id),
          );
        },
      ),
    );
  }
}
