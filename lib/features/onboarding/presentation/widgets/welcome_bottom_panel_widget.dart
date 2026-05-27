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
    final localizations = AppLocalizations.of(context)!;

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.p32,
        vertical: AppConstants.p24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Title line 1 — "Welcome to"
          /// ✅ Dark mode: welcomeTitlePrimary → #E8EDF2 (light near-white)
          Text(
            localizations.welcomeTo,
            style: AppTextStyle.welcomeTitle.copyWith(
              color: AppColors.of(context).welcomeTitlePrimary,
            ),
          ),

          /// Title line 2 — "DHIRA HRMS" (brand blue, same in both modes)
          Text(
            localizations.dhiraHrms,
            style: AppTextStyle.welcomeTitle.copyWith(
              color: AppColors.of(context).primaryContainer,
            ),
          ),

          const SizedBox(height: AppConstants.p16),

          /// Subtitle
          /// ✅ Dark mode: welcomeSubtitleColor → #8899AA (muted steel)
          Text(
            localizations.welcomeSubtitle,
            style: AppTextStyle.welcomeSubtitle.copyWith(
              color: AppColors.of(context).welcomeSubtitleColor,
            ),
          ),

          const Spacer(),

          /// Continue button aligned to bottom-right
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(
                left: AppConstants.p180,
                bottom: AppConstants.p20,
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
