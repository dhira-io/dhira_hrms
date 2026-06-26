import 'package:flutter/material.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/widgets/common_confirmation_bottom_sheet.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';

class ActionConfirmationBottomSheet extends StatelessWidget {
  final String action;
  final ApprovalRequestEntity data;
  final VoidCallback onConfirm;

  const ActionConfirmationBottomSheet({
    super.key,
    required this.action,
    required this.data,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;

    String title = l10n.confirmationReject;
    if (action == ApprovalActions.approve) title = l10n.approve;
    if (action == ApprovalActions.cancel) title = l10n.withdraw;

    String content = l10n.rejectConfirmGeneric;
    if (data.type == ApprovalType.leave) {
      if (action == ApprovalActions.approve) {
        content = l10n.approveConfirmation;
      } else if (action == ApprovalActions.cancel) {
        content = l10n.withdrawConfirmation;
      } else {
        content = l10n.rejectConfirmation;
      }
    } else {
      if (action == ApprovalActions.approve) {
        content = l10n.approveConfirmGeneric;
      } else if (action == ApprovalActions.cancel) {
        content = l10n.withdrawConfirmation;
      } else {
        content = l10n.rejectConfirmGeneric;
      }
    }

    final isApprove = action == ApprovalActions.approve;

    return CommonConfirmationBottomSheet(
      title: title,
      subtitle: content,
      icon: Icon(
        isApprove ? Icons.check_circle_outline : Icons.cancel_outlined,
        color: isApprove ? colors.success : colors.colorRed600,
      ),
      iconBackgroundColor: isApprove 
          ? colors.success.withValues(alpha: 0.1) 
          : colors.colorRed50,
      confirmButtonColor: isApprove ? colors.success : null,
      confirmAction: ConfirmationAction(
        label: l10n.yes,
        onTap: () {
          Navigator.pop(context);
          onConfirm();
        },
      ),
      cancelAction: ConfirmationAction(
        label: l10n.no,
        onTap: () => Navigator.pop(context),
      ),
    );
  }
}
