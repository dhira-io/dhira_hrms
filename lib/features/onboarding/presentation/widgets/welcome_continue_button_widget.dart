import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/common_button.dart';
import '../../../../l10n/app_localizations.dart';

/// Pill-shaped Continue → button used on WelcomeScreen.
class WelcomeContinueButtonWidget extends StatelessWidget {
  const WelcomeContinueButtonWidget({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return CommonButton(
      text: localizations.continueText,
      onPressed: onPressed,
      icon: Icons.arrow_forward_rounded,
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.p24,
        vertical: AppConstants.p12,
      ),
      borderRadius: AppConstants.r12,
    );
  }
}
