import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

class CommonEmptyView extends StatelessWidget {
  final String message;
  final IconData? icon;

  const CommonEmptyView({
    super.key,
    required this.message,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 32.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon ?? Icons.folder_open_outlined,
            size: 48.h,
            color: isDark ? AppColors.of(context).slate600 : AppColors.of(context).slate400,
          ),
          SizedBox(height: 16.h),
          Text(
            message,
            textAlign: TextAlign.center,
            style: AppTextStyle.bodyMedium.copyWith(
              color: isDark ? AppColors.of(context).slate400 : AppColors.of(context).slate500,
            ),
          ),
        ],
      ),
    );
  }
}
