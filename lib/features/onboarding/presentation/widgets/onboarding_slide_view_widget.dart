import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

/// Single carousel page: illustration, title and subtitle.
class OnboardingSlideViewWidget extends StatelessWidget {
  const OnboardingSlideViewWidget({
    super.key,
    required this.slideData,
  });

  final OnboardingSlideData slideData;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.p32,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Graphic Illustration
          Padding(
            padding: const EdgeInsets.only(
              top: 72.75, // top: 72.75px spec
            ),
            child: Transform.translate(
              offset: const Offset(-5.5, 0.0), // left: -5.5px spec
              child: SizedBox(
                width: 280,
                height: 280,
                child: SvgPicture.asset(
                  slideData.imagePath,
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppConstants.p40),

          // Slide Title
          Text(
            slideData.title,
            style: AppTextStyle.onboardingTitle.copyWith(
              color: colors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.p16),

          // Slide Description
          Text(
            slideData.subtitle,
            style: AppTextStyle.onboardingSubtitle.copyWith(
              color: colors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
