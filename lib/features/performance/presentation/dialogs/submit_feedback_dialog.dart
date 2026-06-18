import 'package:flutter/material.dart';
import '../../../../core/widgets/common_alert_dialog.dart';
import '../../../../l10n/app_localizations.dart';

class SubmitFeedbackDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const SubmitFeedbackDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CommonAlertDialog(
      title: l10n.submitManagerFeedback,
      content: l10n.submitManagerFeedbackConfirm,
      confirmText: l10n.submit,
      cancelText: l10n.cancel,
      onConfirm: onConfirm,
    );
  }
}
