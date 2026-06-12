import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';

class UpdateProfileCard extends StatelessWidget {
  const UpdateProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: isDark
            ? AppColors.of(context).profileInfoCardBg
            : AppColors.of(context).iconbgblue.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isDark
              ? AppColors.of(context).updateCardBorder
              : AppColors.of(context).updateCardBorder.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.of(context).surfaceContainerLowest,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: isDark
                    ? AppColors.of(
                        context,
                      ).primaryContainer.withValues(alpha: 0.3)
                    : AppColors.of(context).secondary.withValues(alpha: 0.3),
              ),
            ),
            child: Icon(
              Icons.email_outlined,
              color: isDark
                  ? AppColors.of(context).primaryContainer
                  : AppColors.of(context).secondary,
              size: 24,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.updateProfileQuestion,
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: isDark
                        ? AppColors.of(context).onSurface
                        : AppColors.of(context).secondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  l10n.updateProfileInstructions,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: isDark
                        ? AppColors.of(context).onSurfaceVariant
                        : AppColors.of(context).textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
