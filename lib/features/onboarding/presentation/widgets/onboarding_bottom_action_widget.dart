import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';

/// Full-width Next / Get Started button at the bottom of OnboardingScreen.
class OnboardingBottomActionWidget extends StatelessWidget {
  const OnboardingBottomActionWidget({
    super.key,
    required this.onNextPressed,
  });

  final VoidCallback onNextPressed;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final localizations = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.p24,
      ),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onNextPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: colors.secondary,
            padding: const EdgeInsets.symmetric(
              vertical: AppConstants.p18,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppConstants.r16),
            ),
            elevation: 0,
          ),
          child: Text(
            localizations.nextText,
            style: AppTextStyle.button.copyWith(
              color: colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
