import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/common_button.dart';
import '../../../../l10n/app_localizations.dart';

/// Bottom panel on WelcomeScreen: brand title, subtitle and Continue button.
class WelcomeBottomPanelWidget extends StatelessWidget {
  const WelcomeBottomPanelWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 24.h,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Text(
                      localizations.welcomeTo,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.welcomeTitle.copyWith(
                        color: colors.slate950,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      localizations.dhiraHrms,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.welcomeTitle.copyWith(
                        color: colors.primaryContainer,
                        fontSize: 36.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      localizations.getStartedSubtitle,
                      textAlign: TextAlign.center,
                      style: AppTextStyle.welcomeSubtitle.copyWith(
                        color: colors.slate500,
                        fontSize: 13.sp,
                        fontFamily: 'Inter',
                      ),
                    ),
                    const Spacer(),
                    CommonButton(
                      text: localizations.getStarted,
                      width: double.infinity,
                      suffixIcon: Icons.arrow_forward,
                      onPressed: () => context.go(AppRouter.onboardingPath),
                    ),
                    SizedBox(height: 12.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
