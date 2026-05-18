import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';

class ActionCard extends StatelessWidget {
  final String iconPath;
  final String label;
  final String subtitle;
  final Color iconBgColor;
  final Color iconColor;
  final VoidCallback onTap;

  const ActionCard({
    super.key,
    required this.iconPath,
    required this.label,
    required this.subtitle,
    required this.iconBgColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Theme.of(context); // Force rebuild on theme change
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        child: Ink(
          padding: const EdgeInsets.all(AppConstants.p16),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(AppConstants.r16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(AppConstants.r12),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    iconPath,
                    width: AppConstants.iconXXSmall,
                    height: AppConstants.iconXXSmall,
                    colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
                  ),
                ),
              ),
              SizedBox(height: AppConstants.p16),
              Text(
                label,
                style: AppTextStyle.bodyMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: AppConstants.p14,
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: AppConstants.p4),
              Text(
                subtitle,
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                  height: 1.2,
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
