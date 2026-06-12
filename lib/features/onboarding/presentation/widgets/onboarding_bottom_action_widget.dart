import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/common_button.dart';
import '../../../../l10n/app_localizations.dart';

/// Full-width Next / Get Started button at the bottom of OnboardingScreen.
class OnboardingBottomActionWidget extends StatelessWidget {
  const OnboardingBottomActionWidget({super.key, required this.onNextPressed});

  final VoidCallback onNextPressed;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstants.p24),
      child: CommonButton(
        text: localizations.nextText,
        onPressed: onNextPressed,
        width: double.infinity,
      ),
    );
  }
}
