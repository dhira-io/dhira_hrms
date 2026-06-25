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
          padding:       EdgeInsets.only(
            left: 8.0.w,
            right: 8.0.w,
            bottom: 12.0.h,
          ),
          child: Text(
            title.toUpperCase(),
            style: AppTextStyle.labelSmall.copyWith(
              color: AppColors.of(context).primary,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.of(context).surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: AppColors.of(context).onSurface.withValues(alpha: 0.02),
                blurRadius: 32,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(children: items),
        ),
      ],
    );
  }
}
