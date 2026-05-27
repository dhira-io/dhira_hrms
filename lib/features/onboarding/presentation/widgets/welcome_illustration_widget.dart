import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_constants.dart';

/// SVG illustration displayed inside the wavy gradient area on WelcomeScreen.
class WelcomeIllustrationWidget extends StatelessWidget {
  const WelcomeIllustrationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppConstants.p20,
        bottom: AppConstants.p32,
      ),
      child: SvgPicture.asset(
        AppAssets.welcomeIllustration,
        alignment: Alignment.center,
        fit: BoxFit.contain,
      ),
    );
  }
}
