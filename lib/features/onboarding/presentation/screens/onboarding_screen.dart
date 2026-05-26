import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';

import '../../../../core/constants/app_assets.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../widgets/onboarding_bottom_action_widget.dart';
import '../widgets/onboarding_page_indicator_widget.dart';
import '../widgets/onboarding_slide_view_widget.dart';
import '../widgets/onboarding_top_bar_widget.dart';

/// Multi-page carousel slider introducing core modules of the app.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late final PageController _pageController;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        // Log slide entrance or register any local listeners if needed.
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onPageChanged(int page) {
    setState(() {
      _currentPage = page;
    });
  }

  void _handleNext(int totalPages) {
    if (_currentPage < totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: AppConstants.animNormal),
        curve: Curves.easeInOut,
      );
    } else {
      Get.find<LocalStorageService>().saveIsFirstTime(false);
      context.go(AppRouter.loginPath);
    }
  }

  void _handleSkip() {
    Get.find<LocalStorageService>().saveIsFirstTime(false);
    context.go(AppRouter.loginPath);
  }

  List<OnboardingSlideData> _buildSlides(AppLocalizations localizations) {
    return [
      OnboardingSlideData(
        imagePath: AppAssets.onboardingLeave,
        title: localizations.leaveTitle,
        subtitle: localizations.leaveSubtitle,
      ),
      OnboardingSlideData(
        imagePath: AppAssets.onboardingTimesheet,
        title: localizations.timesheetTitle,
        subtitle: localizations.timesheetSubtitle,
      ),
      OnboardingSlideData(
        imagePath: AppAssets.onboardingCompoff,
        title: localizations.compoffTitle,
        subtitle: localizations.compoffSubtitle,
      ),
      OnboardingSlideData(
        imagePath: AppAssets.onboardingPayslip,
        title: localizations.payslipTitle,
        subtitle: localizations.payslipSubtitle,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final localizations = AppLocalizations.of(context)!;
    final slides = _buildSlides(localizations);

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            // 1. Top bar — logo + Skip button
            OnboardingTopBarWidget(
              onSkipPressed: _handleSkip,
            ),

            // 2. Carousel page content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: slides.length,
                itemBuilder: (context, index) {
                  return OnboardingSlideViewWidget(
                    slideData: slides[index],
                  );
                },
              ),
            ),

            // 3. Dot indicators
            OnboardingPageIndicatorWidget(
              count: slides.length,
              current: _currentPage,
            ),
            const SizedBox(height: AppConstants.p40),

            // 4. Next / Get Started button
            OnboardingBottomActionWidget(
              onNextPressed: () => _handleNext(slides.length),
            ),
            const SizedBox(height: AppConstants.p24),
          ],
        ),
      ),
    );
  }
}
