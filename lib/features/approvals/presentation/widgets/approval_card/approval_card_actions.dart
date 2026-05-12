import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/approvals_bloc.dart';

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
      ApprovalStatus.cancelled.toLowerCase()
    ].contains(normStatus);

    final processingRequestId = context.select<ApprovalsBloc, String?>(
      (bloc) => bloc.state.maybeMap(
        success: (s) => s.data.processingRequestId,
        orElse: () => null,
      ),
    );
    final processingAction = context.select<ApprovalsBloc, String?>(
      (bloc) => bloc.state.maybeMap(
        success: (s) => s.data.processingAction,
        orElse: () => null,
      ),
    );

    final isThisRequestProcessing = processingRequestId == data.id;

    if (data.category == ApprovalCategory.raised) {
      return _buildRaisedActions(
        context,
        isProcessed,
        isThisRequestProcessing,
        processingAction,
      );
    }

    return _buildTeamActions(
      context,
      isProcessed,
      isThisRequestProcessing,
      processingAction,
    );
  }

  Widget _buildRaisedActions(
    BuildContext context,
    bool isProcessed,
    bool isThisRequestProcessing,
    String? processingAction,
  ) {
    final l10n = AppLocalizations.of(context)!;
    bool showEditWithdraw = false;

    if (data.type == ApprovalType.leave && data.fromDate != null) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final start = DateTime(data.fromDate!.year, data.fromDate!.month, data.fromDate!.day);
      showEditWithdraw = !start.isBefore(today) && !isProcessed;
    }

    return Row(
      children: [
        if (data.type == ApprovalType.leave && showEditWithdraw) ...[
          Expanded(
            child: _ActionButton(
              label: l10n.edit,
              icon: Icons.edit_outlined,
              color: AppColors.primary,
              onPressed: isThisRequestProcessing ? null : onEditLeave,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _ActionButton(
              label: l10n.withdraw,
              icon: Icons.undo,
              color: AppColors.error,
              onPressed: isThisRequestProcessing ? null : onWithdrawLeave,
              isLoading: isThisRequestProcessing && processingAction == ApprovalActions.cancel,
            ),
          ),
        ] else if (data.type == ApprovalType.timesheet && !isProcessed) ...[
          Expanded(
            child: _ActionButton(
              label: l10n.delete,
              icon: Icons.delete_outline,
              color: AppColors.error,
              onPressed: isThisRequestProcessing ? null : onDeleteTimesheet,
              isLoading: isThisRequestProcessing && processingAction == 'delete',
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: _ActionButton(
              label: l10n.edit,
              icon: Icons.edit_outlined,
              color: AppColors.primary,
              onPressed: isThisRequestProcessing ? null : onEditTimesheet,
            ),
          ),
        ] else ...[
          const Spacer(),
        ],
      ],
    );
  }

  Widget _buildTeamActions(
    BuildContext context,
    bool isProcessed,
    bool isThisRequestProcessing,
    String? processingAction,
  ) {
    final l10n = AppLocalizations.of(context)!;
    bool showApprove = true;
    bool showReject = true;
    bool isApproveEnabled = false;
    bool isRejectEnabled = false;

    switch (data.type) {
      case ApprovalType.leave:
        isApproveEnabled = data.availableActions.contains(ApprovalActions.approve);
        isRejectEnabled = data.availableActions.contains(ApprovalActions.reject);
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

    return Row(
      children: [
        if (!isProcessed) ...[
          if (showReject)
            Expanded(
              child: _ActionButton(
                label: l10n.reject,
                icon: Icons.cancel_outlined,
                color: AppColors.error,
                onPressed: isRejectEnabled && !isThisRequestProcessing ? () => onAction(ApprovalActions.reject) : null,
                isLoading: isThisRequestProcessing && processingAction == ApprovalActions.reject,
              ),
            ),
          if (showReject && showApprove) const SizedBox(width: 12),
          if (showApprove)
            Expanded(
              child: _ActionButton(
                label: l10n.approve,
                icon: Icons.check_circle_outline,
                color: AppColors.success,
                onPressed: isApproveEnabled && !isThisRequestProcessing ? () => onAction(ApprovalActions.approve) : null,
                isLoading: isThisRequestProcessing && processingAction == ApprovalActions.approve,
              ),
            ),
          const SizedBox(width: 12),
        ],
        if (isProcessed) const Spacer(),
        _CommentIconButton(onPressed: onAddComment),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final VoidCallback? onPressed;
  final bool isLoading;

  const _ActionButton({
    required this.label,
    required this.icon,
    required this.color,
    this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onPressed == null || isLoading;
    
    return OutlinedButton.icon(
      onPressed: isDisabled ? null : onPressed,
      icon: isLoading 
        ? SizedBox(
            width: 18, 
            height: 18, 
            child: CircularProgressIndicator(
              strokeWidth: 2, 
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          )
        : Icon(icon, size: 18, color: isDisabled ? color.withValues(alpha: 0.3) : color),
      label: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.bold, 
          color: isDisabled ? color.withValues(alpha: 0.3) : color,
        ),
      ),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: isDisabled ? color.withValues(alpha: 0.2) : color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r8)),
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
        color: AppColors.primaryFixed,
        borderRadius: BorderRadius.circular(AppConstants.r8),
      ),
      child: IconButton(
        icon: const Icon(Icons.chat_bubble, color: AppColors.primary, size: 20),
        onPressed: onPressed,
      ),
    );
  }
}
