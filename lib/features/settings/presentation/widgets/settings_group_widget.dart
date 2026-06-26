import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class SettingsGroupWidget extends StatelessWidget {
  final String title;
  final List<Widget> items;

  const SettingsGroupWidget({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: 4.w,
            bottom: 12.h,
          ),
          child: Text(
            title.toUpperCase(),
            style: AppTextStyle.labelMedium.copyWith(
              color: AppColors.of(context).primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              fontSize: 12.sp,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.of(context).surfaceContainerLowest,
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: AppColors.of(context).outlineVariant.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(children: items),
        ),
      ],
    );
  }
}
