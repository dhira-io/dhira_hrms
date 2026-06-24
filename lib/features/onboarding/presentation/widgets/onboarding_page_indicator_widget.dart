import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

/// Animated row of dot indicators reflecting the current onboarding page.
class OnboardingPageIndicatorWidget extends StatelessWidget {
  const OnboardingPageIndicatorWidget({
    super.key,
    required this.count,
    required this.current,
    required this.onPrevious,
    required this.onNext,
  });

  final int count;
  final int current;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final appcolors = AppColors.of(context);
    
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onPrevious,
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: appcolors.slate100,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.chevron_left, color: appcolors.slate500, size: 20.sp),
              ),
            ),
            SizedBox(width: 16.w),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(count, (index) {
                return _Dot(isActive: index == current);
              }),
            ),
            SizedBox(width: 16.w),
            GestureDetector(
              onTap: onNext,
              child: Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: appcolors.slate100,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.chevron_right, color: appcolors.slate500, size: 20.sp),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Text(
          '${current + 1}/$count',
          style: AppTextStyle.bodyLarge.copyWith(
            color: appcolors.slate500,
          ),
        ),
      ],
    );
  }
}

/// Single animated dot.
class _Dot extends StatelessWidget {
  const _Dot({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final Appcolors = AppColors.of(context);
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: AppConstants.animFast),
      margin: EdgeInsets.symmetric(horizontal: AppConstants.p4.w),
      height: 8.h,
      width: 8.h,
      decoration: BoxDecoration(
        color: isActive
            ? Appcolors.primary
            : Appcolors.primary.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
    );
  }
}
