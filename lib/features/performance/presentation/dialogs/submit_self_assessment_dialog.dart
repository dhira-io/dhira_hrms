import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';

class SubmitSelfAssessmentDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const SubmitSelfAssessmentDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return AlertDialog(
      backgroundColor: AppColors.of(context).surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppConstants.r16),
      ),
      titlePadding: const EdgeInsets.fromLTRB(AppConstants.p24, AppConstants.p24, AppConstants.p24, AppConstants.p12),
      contentPadding: const EdgeInsets.symmetric(horizontal: AppConstants.p24),
      title: Text(
        l10n.submitAssessment,
        style: AppTextStyle.h3.copyWith(fontWeight: FontWeight.bold),
      ),
      content: Text(
        l10n.submitAssessmentConfirm,
        style: AppTextStyle.bodyMedium.copyWith(
          color: AppColors.of(context).onSurfaceVariant,
        ),
      ),
      actionsPadding: const EdgeInsets.all(AppConstants.p24),
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
                    color: AppColors.of(context).outline.withValues(alpha: 0.5),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.r12),
                  ),
                ),
                child: Text(
                  l10n.cancel,
                  style: AppTextStyle.labelLarge.copyWith(
                    color: AppColors.of(context).onSurfaceVariant,
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
                  backgroundColor: AppColors.of(context).primary,
                  foregroundColor: AppColors.of(context).white,
                  padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.p12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.r12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  l10n.confirmSubmit,
                  style: AppTextStyle.labelLarge.copyWith(
                    color: AppColors.of(context).white,
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
