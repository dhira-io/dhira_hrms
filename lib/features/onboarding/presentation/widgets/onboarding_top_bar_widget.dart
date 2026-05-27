import 'package:flutter/material.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/common_button.dart';
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
          Theme.of(context).brightness == Brightness.dark
              ? ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    AppColors.of(context).white,
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(AppAssets.logo, height: 37),
                )
              : Image.asset(AppAssets.logo, height: 37),

          // Right-aligned Skip button
          CommonButton(
            text: localizations.skipText,
            onPressed: onSkipPressed,
            variant: ButtonVariant.text,
            padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.p16,
              vertical: AppConstants.p8,
            ),
          ),
        ],
      ),
    );
  }
}
