import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';

class RegularizationGuidelines extends StatelessWidget {
  const RegularizationGuidelines({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(AppConstants.p20),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppConstants.r12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info, color: AppColors.primary, size: 14),
              const SizedBox(width: 8),
              Text(
                l10n.regularizationGuidelines.toUpperCase(),
                style: AppTextStyle.labelSmall.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _GuidelineItem(text: l10n.regGuideline1),
          const SizedBox(height: 8),
          _GuidelineItem(text: l10n.regGuideline2),
          const SizedBox(height: 8),
          _GuidelineItem(text: l10n.regGuideline3),
          const SizedBox(height: 8),
          _GuidelineItem(text: l10n.regGuideline4),
          const SizedBox(height: 8),
          _GuidelineItem(text: l10n.regGuideline5),
          const SizedBox(height: 8),
          _GuidelineItem(text: l10n.regGuideline6),
        ],
      ),
    );
  }
}

class _GuidelineItem extends StatelessWidget {
  final String text;

  const _GuidelineItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: AppConstants.p6),
          width: 6,
          height: 6,
          decoration: const BoxDecoration(
            color: AppColors.outlineVariant,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: AppTextStyle.labelLarge.copyWith(
              color: AppColors.onSurfaceVariant,
              fontSize: AppConstants.fs13,
            ),
          ),
        ),
      ],
    );
  }
}
