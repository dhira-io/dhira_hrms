import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/approval_request_entity.dart';
import '../../domain/entities/approval_type.dart';

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

    return AlertDialog(
      backgroundColor: AppColors.of(context).surfaceContainerLowest,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r16)),
      title: Text(title, style: AppTextStyle.headlineSmall.copyWith(fontWeight: FontWeight.bold)),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.no, style: TextStyle(color: AppColors.of(context).onSurface)),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: action == ApprovalActions.approve ? AppColors.of(context).success : AppColors.of(context).error,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            minimumSize: const Size(0, AppConstants.p40),
          ),
          child: Text(
            l10n.yes,
            style: AppTextStyle.labelLarge.copyWith(color: AppColors.of(context).white),
          ),
        ),
      ],
    );
  }
}
