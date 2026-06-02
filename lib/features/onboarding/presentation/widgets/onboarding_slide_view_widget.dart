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
    final screenHeight = MediaQuery.sizeOf(context).height;

    // Proportional sizes based on screen height so it adapts to all devices.
    final topPadding = (screenHeight * 0.08).clamp(32.0, 72.75);
    final imageSize = (screenHeight * 0.30).clamp(160.0, 280.0);
    final spacingAfterImage = (screenHeight * 0.04).clamp(16.0, 40.0);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.p32,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Graphic Illustration
          Flexible(
            child: Padding(
              padding: EdgeInsets.only(
                top: topPadding,
              ),
              child: Transform.translate(
                offset: const Offset(-5.5, 0.0), // left: -5.5px spec
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: imageSize,
                    maxHeight: imageSize,
                  ),
                  child: SvgPicture.asset(
                    slideData.imagePath,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: spacingAfterImage),

          // Slide Title
          Text(
            slideData.title,
            style: AppTextStyle.onboardingTitle.copyWith(
              color: AppColors.of(context).textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppConstants.p16),

          // Slide Description
          Text(
            slideData.subtitle,
            style: AppTextStyle.onboardingSubtitle.copyWith(
              color: AppColors.of(context).textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
