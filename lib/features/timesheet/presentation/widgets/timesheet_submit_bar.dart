import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
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
            child: ElevatedButton(
              onPressed: onCancel,
              style: ElevatedButton.styleFrom(
                backgroundColor: themeColors.surfaceContainerHigh,
                foregroundColor: themeColors.textSecondary,
                elevation: 0,
              ),
              child: Text(
                l10n.cancel,
                style: AppTextStyle.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  color: themeColors.textSecondary,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [themeColors.primary, themeColors.primaryContainer],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: themeColors.primary.withValues(alpha: 0.2),
                    blurRadius: 16,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: onSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeColors.transparent,
                  shadowColor: themeColors.transparent,
                  elevation: 0,
                ),
                child: Text(
                  submitLabel ?? l10n.submitWeeklyTimesheet,
                  style: AppTextStyle.button.copyWith(
                    color: themeColors.white,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
