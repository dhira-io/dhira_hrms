import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_constants.dart';

/// SVG illustration displayed inside the wavy gradient area on WelcomeScreen.
class WelcomeIllustrationWidget extends StatelessWidget {
  const WelcomeIllustrationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AppAssets.welcomeIllustrationPng,
      alignment: Alignment.topCenter,
      fit: BoxFit.cover,
    );
  }
}
