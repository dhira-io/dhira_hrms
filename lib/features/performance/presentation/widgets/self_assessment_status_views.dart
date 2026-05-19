import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class SelfAssessmentEmptyState extends StatelessWidget {
  const SelfAssessmentEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.p24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.assignment_outlined,
              size: 100,
              color: AppColors.primary,
            ),
            const SizedBox(height: AppConstants.p24),
            Text(
              l10n.noSelfAssessmentTitle,
              style: AppTextStyle.h2.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.p16),
            Text(
              l10n.noSelfAssessmentSubtitle,
              style: AppTextStyle.bodyMedium.copyWith(
                color: AppColors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class SelfAssessmentErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const SelfAssessmentErrorState({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          const SizedBox(height: AppConstants.p16),
          ElevatedButton(onPressed: onRetry, child: Text(l10n.retry)),
        ],
      ),
    );
  }
}

class SelfAssessmentSubmittedStatus extends StatelessWidget {
  const SelfAssessmentSubmittedStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.p16),
      color: AppColors.surfaceContainerLowest,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppConstants.p16),
        decoration: BoxDecoration(
          color: AppColors.successBg,
          borderRadius: BorderRadius.circular(AppConstants.r12),
          border: Border.all(color: AppColors.successBorder),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_circle_outline,
                color: AppColors.successDark,
                size: AppConstants.iconSmall,
              ),
              const SizedBox(width: AppConstants.p8),
              Text(
                l10n.submitted,
                style: AppTextStyle.labelMedium.copyWith(
                  color: AppColors.successDark,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
