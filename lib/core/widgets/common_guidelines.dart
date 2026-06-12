import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_constants.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';

class CommonGuidelines extends StatelessWidget {
  final String title;
  final List<String> items;
  final IconData icon;

  const CommonGuidelines({
    super.key,
    required this.title,
    required this.items,
    this.icon = Icons.info,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.of(context).primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppConstants.r12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: AppColors.of(context).primary, size: 14),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  title.toUpperCase(),
                  style: AppTextStyle.labelSmall.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppColors.of(context).primary,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          ...List.generate(items.length, (index) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == items.length - 1 ? 0 : 8.h,
              ),
              child: _GuidelineItem(text: items[index]),
            );
          }),
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
              fontSize: AppConstants.fs10.sp,
            ),
          ),
        ),
      ],
    );
  }
}
