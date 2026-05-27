import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/common_button.dart';
import '../../../../l10n/app_localizations.dart';

/// GetStartedScreen – branding transition between WelcomeScreen and OnboardingScreen.
class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _IllustrationSection(
            screenHeight: screenHeight,
            colors: AppColors.of(context),
          ),
          _ContentSection(
            l10n: l10n,
            colors: AppColors.of(context),
          ),
        ],
      ),
    );
  }
}

/// Top gradient container displaying the dashboard mockup SVG illustration.
class _IllustrationSection extends StatelessWidget {
  const _IllustrationSection({
    required this.screenHeight,
    required this.colors,
  });

  final double screenHeight;
  final AppColorsResolved colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * AppConstants.getStartedTopRatio,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colors.primaryContainer, colors.background],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.p8,
            vertical: AppConstants.p12,
          ),
          child: Transform.scale(
            scale: 1.12,
            child: SvgPicture.asset(
              AppAssets.getStartedIllustration,
              fit: BoxFit.contain,
              alignment: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
    );
  }
}

/// Bottom content section with title, subtitle and the Get Started CTA button.
class _ContentSection extends StatelessWidget {
  const _ContentSection({
    required this.l10n,
    required this.colors,
  });

  final AppLocalizations l10n;
  final AppColorsResolved colors;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.p20,
          vertical: AppConstants.p16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _TitleText(l10n: l10n, colors: colors),
            _SubtitleText(l10n: l10n, colors: colors),
            _GetStartedButton(l10n: l10n, colors: colors),
          ],
        ),
      ),
    );
  }
}

/// Screen title text widget.
class _TitleText extends StatelessWidget {
  const _TitleText({
    required this.l10n,
    required this.colors,
  });

  final AppLocalizations l10n;
  final AppColorsResolved colors;

  @override
  Widget build(BuildContext context) {
    return Text(
      l10n.getStartedTitle,
      textAlign: TextAlign.center,
      style: AppTextStyle.getStartedTitle.copyWith(
        color: colors.charcoal,
      ),
    );
  }
}

/// Screen subtitle text widget.
class _SubtitleText extends StatelessWidget {
  const _SubtitleText({
    required this.l10n,
    required this.colors,
  });

  final AppLocalizations l10n;
  final AppColorsResolved colors;

  @override
  Widget build(BuildContext context) {
    return Text(
      l10n.getStartedSubtitle,
      textAlign: TextAlign.center,
      style: AppTextStyle.getStartedSubtitle.copyWith(
        color: colors.slateGrey,
      ),
    );
  }
}

/// Primary CTA button that navigates to the OnboardingScreen.
class _GetStartedButton extends StatelessWidget {
  const _GetStartedButton({
    required this.l10n,
    required this.colors,
  });

  final AppLocalizations l10n;
  final AppColorsResolved colors;

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      text: l10n.getStarted,
      onPressed: () => context.go(AppRouter.onboardingPath),
      width: double.infinity,
    );
  }
}
