import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';

void showSubmitGoalDialog({
  required BuildContext context,
  required VoidCallback onConfirm,
}) {
  final l10n = AppLocalizations.of(context)!;

  showDialog(
    context: context,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.r16),
        ),
        title: Text(
          l10n.submitGoalSetup,
          style: AppTextStyle.h3.copyWith(fontWeight: FontWeight.bold),
        ),
        content: Text(
          l10n.submitGoalConfirmation,
          style: AppTextStyle.bodyMedium.copyWith(
            color: AppColors.of(context).textSecondary,
          ),
        ),
        actionsPadding: const EdgeInsets.fromLTRB(
          AppConstants.p24,
          0,
          AppConstants.p24,
          AppConstants.p24,
        ),
        actions: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: double.infinity,
                height: 48,
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: AppColors.of(context).primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.r12),
                    ),
                    foregroundColor: AppColors.of(context).primary,
                    overlayColor: AppColors.of(context).primary.withValues(alpha: 0.12),
                  ),
                  child: Text(
                    l10n.cancel,
                    style: AppTextStyle.button.copyWith(
                      color: AppColors.of(context).primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.p12),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    onConfirm();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.of(context).primary,
                    foregroundColor: AppColors.of(context).onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppConstants.r12),
                    ),
                    elevation: 0,
                    overlayColor: AppColors.of(context).white.withValues(alpha: 0.12),
                  ),
                  child: Text(
                    l10n.confirmSubmit,
                    style: AppTextStyle.button.copyWith(
                      color: AppColors.of(context).onPrimary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}
