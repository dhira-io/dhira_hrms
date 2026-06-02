import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/widgets/common_alert_dialog.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ActionConfirmationDialog extends StatelessWidget {
  final String action;
  final ApprovalRequestEntity data;
  final VoidCallback onConfirm;

  const ActionConfirmationDialog({
    super.key,
    required this.action,
    required this.data,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    String title = l10n.reject;
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

    return CommonAlertDialog(
      title: title,
      content: content,
      confirmText: l10n.yes,
      cancelText: l10n.no,
      onConfirm: onConfirm,
      confirmButtonColor: action == ApprovalActions.approve
          ? AppColors.of(context).success
          : AppColors.of(context).error,
    );
  }
}
