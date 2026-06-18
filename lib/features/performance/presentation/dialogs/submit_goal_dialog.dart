import 'package:flutter/material.dart';
import '../../../../core/widgets/common_alert_dialog.dart';
import '../../../../l10n/app_localizations.dart';

void showSubmitGoalDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) {
  final l10n = AppLocalizations.of(context)!;

  CommonAlertDialog.show(
    context: context,
    title: l10n.submitGoalSetup,
    content: l10n.submitGoalConfirmation,
    confirmText: l10n.confirmSubmit,
    cancelText: l10n.cancel,
    onConfirm: onConfirm,
  );
}
