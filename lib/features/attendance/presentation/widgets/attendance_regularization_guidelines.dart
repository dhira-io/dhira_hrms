import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        color: AppColors.of(context).primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppConstants.r12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: AppColors.of(context).primary, size: 14),
                    SizedBox(width: 8.w),
              Text(
                l10n.regularizationGuidelines.toUpperCase(),
                style: AppTextStyle.labelSmall.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.of(context).primary,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
                SizedBox(height: 12.h),
          _GuidelineItem(text: l10n.regGuideline1),
                SizedBox(height: 8.h),
          _GuidelineItem(text: l10n.regGuideline2),
                SizedBox(height: 8.h),
          _GuidelineItem(text: l10n.regGuideline3),
                SizedBox(height: 8.h),
          _GuidelineItem(text: l10n.regGuideline4),
                SizedBox(height: 8.h),
          _GuidelineItem(text: l10n.regGuideline5),
                SizedBox(height: 8.h),
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
          width: 6.w,
          height: 6.h,
          decoration: BoxDecoration(
            color: AppColors.of(context).outlineVariant,
            shape: BoxShape.circle,
          ),
        ),
              SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: AppTextStyle.labelLarge.copyWith(
              color: AppColors.of(context).onSurfaceVariant,
              fontSize: AppConstants.fs13,
            ),
          ),
        ),
      ],
    );
  }
}
