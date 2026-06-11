import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

/// Data model encapsulating a single onboarding slide's content.
class OnboardingSlideData {
  const OnboardingSlideData({
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  final String imagePath;
  final String title;
  final String subtitle;
}

/// Single carousel page: title, subtitle, and illustration.
class OnboardingSlideViewWidget extends StatelessWidget {
  const OnboardingSlideViewWidget({super.key, required this.slideData});

  final OnboardingSlideData slideData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.p32.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 64.h),
          // Slide Title
          Text(
            slideData.title,
            style: AppTextStyle.onboardingTitle.copyWith(
              color: AppColors.of(context).primary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppConstants.p16.h),

          // Slide Description
          Text(
            slideData.subtitle,
            style: AppTextStyle.onboardingSubtitle.copyWith(
              color: AppColors.of(context).textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 48.h),

          // Graphic Illustration
          Expanded(
            child: SvgPicture.asset(
              slideData.imagePath,
              fit: BoxFit.contain,
              width: double.infinity,
              alignment: Alignment.center,
            ),
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
