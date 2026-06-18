import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_bloc.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_state.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApprovalCardActions extends StatelessWidget {
  final ApprovalRequestEntity data;
  final VoidCallback onEditLeave;
  final VoidCallback onWithdrawLeave;
  final VoidCallback onDeleteTimesheet;
  final VoidCallback onEditTimesheet;
  final Function(String) onAction;
  final VoidCallback onAddComment;

  const ApprovalCardActions({
    super.key,
    required this.data,
    required this.onEditLeave,
    required this.onWithdrawLeave,
    required this.onDeleteTimesheet,
    required this.onEditTimesheet,
    required this.onAction,
    required this.onAddComment,
  });

  @override
  Widget build(BuildContext context) {
    final String normStatus = data.status.toLowerCase();
    final bool isProcessed = [
      ApprovalStatus.approved.toLowerCase(),
      ApprovalStatus.rejected.toLowerCase(),
      ApprovalStatus.cancelled.toLowerCase(),
    ].contains(normStatus);

    if (data.category == ApprovalCategory.raised) {
      return _buildRaisedActions(context, isProcessed);
    }

    return _buildTeamActions(context, isProcessed);
  }

  Widget _buildRaisedActions(BuildContext context, bool isProcessed) {
    final l10n = AppLocalizations.of(context)!;
    bool showEditWithdraw = false;

    if (data.type == ApprovalType.leave && data.fromDate != null) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final start = DateTime(
        data.fromDate!.year,
        data.fromDate!.month,
        data.fromDate!.day,
      );
      showEditWithdraw = !start.isBefore(today) && !isProcessed;
    }

    return BlocSelector<ApprovalsBloc, ApprovalsState, bool>(
      selector: (state) => state.maybeMap(
        success: (s) => s.data.processingIds.contains(data.id),
        orElse: () => false,
      ),
      builder: (context, isItemProcessing) {
        if (isItemProcessing) {
          return       Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0.h),
            child: Center(
              child: SizedBox(
                height: 24.h,
                width: 24.w,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        }

        return Row(
          children: [
            if (data.type == ApprovalType.leave && showEditWithdraw) ...[
              Expanded(
                child: _ActionButton(
                  label: l10n.edit,
                  icon: Icons.edit_outlined,
                  color: AppColors.of(context).primary,
                  onPressed: onEditLeave,
                ),
              ),
                    SizedBox(width: 12.w),
              Expanded(
                child: _ActionButton(
                  label: l10n.withdraw,
                  icon: Icons.undo,
                  color: AppColors.of(context).error,
                  onPressed: onWithdrawLeave,
                ),
              ),
            ] else if (data.type == ApprovalType.timesheet && !isProcessed) ...[
              Expanded(
                child: _ActionButton(
                  label: l10n.delete,
                  icon: Icons.delete_outline,
                  color: AppColors.of(context).error,
                  onPressed: onDeleteTimesheet,
                ),
              ),
                    SizedBox(width: 12.w),
              Expanded(
                child: _ActionButton(
                  label: l10n.edit,
                  icon: Icons.edit_outlined,
                  color: AppColors.of(context).primary,
                  onPressed: onEditTimesheet,
                ),
              ),
            ] else ...[
              const Spacer(),
            ],
          ],
        );
      },
    );
  }

  Widget _buildTeamActions(BuildContext context, bool isProcessed) {
    final l10n = AppLocalizations.of(context)!;
    bool showApprove = true;
    bool showReject = true;
    bool isApproveEnabled = false;
    bool isRejectEnabled = false;

    switch (data.type) {
      case ApprovalType.leave:
        isApproveEnabled = data.availableActions.contains(
          ApprovalActions.approve,
        );
        isRejectEnabled = data.availableActions.contains(
          ApprovalActions.reject,
        );
        break;
      case ApprovalType.attendance:
      case ApprovalType.compOff:
        isApproveEnabled = !isProcessed;
        isRejectEnabled = !isProcessed;
        break;
      case ApprovalType.timesheet:
        showReject = false;
        isApproveEnabled = !isProcessed && data.isMainApprover;
        break;
    }

    return BlocSelector<ApprovalsBloc, ApprovalsState, bool>(
      selector: (state) => state.maybeMap(
        success: (s) => s.data.processingIds.contains(data.id),
        orElse: () => false,
      ),
      builder: (context, isItemProcessing) {
        if (isItemProcessing) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0.h),
            child: Center(
              child: SizedBox(
                height: 24.h,
                width: 24.w,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        }

        return Row(
          children: [
            if (!isProcessed) ...[
              if (showReject)
                Expanded(
                  child: _ActionButton(
                    label: l10n.reject,
                    icon: Icons.cancel_outlined,
                    color: AppColors.of(context).error,
                    onPressed: isRejectEnabled
                        ? () => onAction(ApprovalActions.reject)
                        : null,
                  ),
                ),
              if (showReject && showApprove)       SizedBox(width: 12.w),
              if (showApprove)
                Expanded(
                  child: _ActionButton(
                    label: l10n.approve,
                    icon: Icons.check_circle_outline,
                    color: AppColors.of(context).success,
                    onPressed: isApproveEnabled
                        ? () => onAction(ApprovalActions.approve)
                        : null,
                  ),
                ),
                    SizedBox(width: 12.w),
            ],
            if (isProcessed) const Spacer(),
            _CommentIconButton(onPressed: onAddComment),
          ],
        );
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null;
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: 18,
        color: isDisabled ? color.withValues(alpha: 0.3) : color,
      ),
      label: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: isDisabled ? color.withValues(alpha: 0.3) : color,
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(
          color: isDisabled ? color.withValues(alpha: 0.2) : color,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.r8),
        ),
        padding: const EdgeInsets.symmetric(vertical: AppConstants.p12),
      ),
    );
  }
}

class _CommentIconButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _CommentIconButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.of(context).primaryFixed,
        borderRadius: BorderRadius.circular(AppConstants.r8),
      ),
      child: IconButton(
        icon: Icon(
          Icons.chat_bubble,
          color: AppColors.of(context).primary,
          size: 20,
        ),
        onPressed: onPressed,
      ),
    );
  }
}
