import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import 'welcome_continue_button_widget.dart';

/// Bottom panel on WelcomeScreen: brand title, subtitle and Continue button.
class WelcomeBottomPanelWidget extends StatelessWidget {
  const WelcomeBottomPanelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final localizations = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.p32,
        vertical: AppConstants.p24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title — two-line brand copy
          Text(
            localizations.welcomeTo,
            style: AppTextStyle.welcomeTitle.copyWith(
              color: colors.slate900,
            ),
          ),

          Text(
            localizations.dhiraHrms,
            style: AppTextStyle.welcomeTitle.copyWith(
              color: colors.primaryContainer,
            ),
          ),

          const SizedBox(height: AppConstants.p16),

          /// Subtitle
          Text(
            localizations.welcomeSubtitle,
            style: AppTextStyle.welcomeSubtitle.copyWith(
              color: colors.slate500,
            ),
          ),

          const Spacer(),

          /// Continue button aligned to bottom-right
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 160,
                bottom: 20,
              ),
              child: WelcomeContinueButtonWidget(
                onPressed: () => context.go(AppRouter.getStartedPath),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
