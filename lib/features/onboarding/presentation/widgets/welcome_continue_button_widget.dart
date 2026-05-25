import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
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
    final colors = AppColors.of(context);
    final localizations = AppLocalizations.of(context)!;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: colors.primaryContainer,
        foregroundColor: colors.slate50,
        elevation: 0,
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.p24,
          vertical: AppConstants.p12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.r12),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            localizations.continueText,
            style: AppTextStyle.continueButtonText.copyWith(
              color: colors.slate50,
            ),
          ),
          const SizedBox(width: AppConstants.p8),
          Icon(
            Icons.arrow_forward_rounded,
            size: AppConstants.iconXSmall,
            color: colors.slate50,
          ),
        ],
      ),
    );
  }
}
