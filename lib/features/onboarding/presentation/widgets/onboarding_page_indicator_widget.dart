import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';

/// Animated row of dot indicators reflecting the current onboarding page.
class OnboardingPageIndicatorWidget extends StatelessWidget {
  const OnboardingPageIndicatorWidget({
    super.key,
    required this.count,
    required this.current,
  });

  final int count;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        return _Dot(isActive: index == current);
      }),
    );
  }
}

/// Single animated dot — expands when active.
class _Dot extends StatelessWidget {
  const _Dot({required this.isActive});

  final bool isActive;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return AnimatedContainer(
      duration: const Duration(milliseconds: AppConstants.animFast),
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.p4),
      height: 8,
      width: isActive ? 24 : 8,
      decoration: BoxDecoration(
        color: isActive
            ? colors.secondary
            : colors.secondary.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(AppConstants.r8),
      ),
    );
  }
}
