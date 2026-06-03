import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class SettingsItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? value;
  final VoidCallback onTap;
  final bool showDivider;
  final Color? iconColor;
  final Color? textColor;

  const SettingsItemWidget({
    super.key,
    required this.icon,
    required this.title,
    this.value,
    required this.onTap,
    this.showDivider = true,
    this.iconColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          Padding(
            padding:       EdgeInsets.symmetric(
              horizontal: 16.0.w,
              vertical: 12.0.h,
            ),
            child: Row(
              children: [
                Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: AppColors.of(context).surfaceContainerHigh,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: iconColor ?? AppColors.of(context).onSurfaceVariant,
                    size: 20,
                  ),
                ),
                      SizedBox(width: 16.w),
                Expanded(
                  child: Text(
                    title,
                    style: AppTextStyle.bodyMedium.copyWith(
                      fontWeight: FontWeight.w500,
                      color: textColor ?? AppColors.of(context).onSurface,
                      fontSize: AppConstants.f12.sp
                    ),
                  ),
                ),
                if (value != null) ...[
                  Text(
                    value!,
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.of(context).onSurfaceVariant,
                    ),
                  ),
                        SizedBox(width: 8.w),
                ],
                Icon(
                  Icons.chevron_right,
                  color: AppColors.of(context).outlineVariant,
                  size: 20,
                ),
              ],
            ),
          ),
          if (showDivider)
            Padding(
              padding:       EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Divider(
                height: 1.h,
                thickness: 1,
                color: AppColors.of(context).surfaceContainerLow,
              ),
            ),
        ],
      ),
    );
  }
}
