import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class SalaryActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final Color iconBgColor;
  final Color iconColor;
  final VoidCallback onTap;

  const SalaryActionCard({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.iconBgColor,
    required this.iconColor,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Material(
      color: colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        child: Ink(
          padding: const EdgeInsets.all(AppConstants.p10),
          decoration: BoxDecoration(
            color: colors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppConstants.r16),
            boxShadow: [
              BoxShadow(
                color: colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 48.w,
                height: 48.h,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(AppConstants.r12),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: AppConstants.iconXXSmall,
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.p16),
              Text(
                label,
                style: AppTextStyle.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppConstants.p4),
              Text(
                subtitle,
                style: AppTextStyle.bodySmall.copyWith(
                  color: colors.textSecondary,
                  ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
