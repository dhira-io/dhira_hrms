import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';

/// Logo + Skip button row at the top of OnboardingScreen.
class OnboardingTopBarWidget extends StatelessWidget {
  const OnboardingTopBarWidget({
    super.key,
    required this.onSkipPressed,
  });

  final VoidCallback onSkipPressed;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.p24,
        vertical: AppConstants.p12,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left-aligned brand logo
          Image.asset(AppAssets.logo, height: 37),

          // Right-aligned Skip button
          TextButton(
            onPressed: onSkipPressed,
            child: Text(
              localizations.skipText,
              style: AppTextStyle.continueButtonText.copyWith(
                color: AppColors.of(context).primaryContainer,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
