import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/common_alert_dialog.dart';
import '../../../../l10n/app_localizations.dart';

class DeleteTimesheetDialog extends StatelessWidget {
  final String requestId;
  final VoidCallback onDelete;

  const DeleteTimesheetDialog({
    super.key,
    required this.requestId,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CommonAlertDialog(
      title: l10n.deleteTimesheet,
      content:
          "${l10n.areYouSureDelete} $requestId?\n\n${l10n.deleteTimesheetWarning}",
      confirmText: l10n.delete,
      cancelText: l10n.cancel,
      onConfirm: onDelete,
      confirmButtonColor: AppColors.of(context).error,
    );
  }
}
