import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/widgets/common_button.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class TimesheetSubmitBar extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSubmit;
  final String? submitLabel;

  const TimesheetSubmitBar({
    super.key,
    required this.onCancel,
    required this.onSubmit,
    this.submitLabel,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeColors = AppColors.of(context);

    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
      decoration: BoxDecoration(
        color: themeColors.white.withValues(alpha: 0.95),
        boxShadow: [
          BoxShadow(
            color: themeColors.black.withValues(alpha: 0.08),
            blurRadius: 32,
            offset: const Offset(0, -12),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: CommonButton(
              text: l10n.cancel,
              onPressed: onCancel,
              variant: ButtonVariant.outlined,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: CommonButton(
              text: submitLabel ?? l10n.submitWeeklyTimesheet,
              onPressed: onSubmit,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ],
      ),
    );
  }
}
