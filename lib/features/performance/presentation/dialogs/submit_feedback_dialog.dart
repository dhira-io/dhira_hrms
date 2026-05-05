import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';

class SubmitFeedbackDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const SubmitFeedbackDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.r16),
      ),
      title: Text(
        l10n.submitManagerFeedback,
        style: AppTextStyle.h3.copyWith(fontWeight: FontWeight.bold),
      ),
      content: Text(
        l10n.submitManagerFeedbackConfirm,
        style: AppTextStyle.bodyMedium.copyWith(
          color: AppColors.onSurfaceVariant,
        ),
      ),

      actionsPadding: const EdgeInsets.fromLTRB(
        AppConstants.p24,
        0,
        AppConstants.p24,
        AppConstants.p24,
      ),
      actions: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.p12,
                  ),
                  side: BorderSide(
                    color: AppColors.outline.withValues(alpha: 0.5),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.r12),
                  ),
                ),
                child: Text(
                  l10n.cancel,
                  style: AppTextStyle.labelLarge.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: AppConstants.p12),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onConfirm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.white,
                  // padding: const EdgeInsets.symmetric(
                  //   vertical: AppConstants.p12,
                  // ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.r12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  l10n.submit,
                  style: AppTextStyle.labelLarge.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
