import 'package:flutter/material.dart';
import '../../../../core/widgets/common_alert_dialog.dart';
import '../../../../l10n/app_localizations.dart';

class SubmitSelfAssessmentDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const SubmitSelfAssessmentDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CommonAlertDialog(
      title: l10n.submitAssessment,
      content: l10n.submitAssessmentConfirm,
      confirmText: l10n.confirmSubmit,
      cancelText: l10n.cancel,
      onConfirm: onConfirm,
    );
  }
}
