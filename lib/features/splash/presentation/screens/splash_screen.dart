import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/services/local_storage_service.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/auth_event.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/auth_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Rule 6: Wrap event under postframecallback with mounted check
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          context.read<AuthBloc>().add(
            const AuthEvent.authStatusChecked(),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashView();
  }
}

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          authenticated: (user) =>
              context.go(AppRouter.dashboardPath),
          unauthenticated: () {
            final isFirstTime = Get.find<LocalStorageService>().getIsFirstTime();
            if (isFirstTime) {
              context.go(AppRouter.welcomePath);
            } else {
              context.go(AppRouter.loginPath);
            }
          },
          error: (_) {
            final isFirstTime = Get.find<LocalStorageService>().getIsFirstTime();
            if (isFirstTime) {
              context.go(AppRouter.welcomePath);
            } else {
              context.go(AppRouter.loginPath);
            }
          },
        );
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.of(context).splashGradientStart,
                AppColors.of(context).splashGradientMiddle,
                AppColors.of(context).splashGradientEnd,
              ],
            ),
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isDark
                    ? ColorFiltered(
                        colorFilter: const ColorFilter.mode(
                          AppColors.white,
                          BlendMode.srcIn,
                        ),
                        child: Image.asset(AppAssets.logo, height: 100),
                      )
                    : Image.asset(AppAssets.logo, height: 100),
                const SizedBox(height: AppConstants.p20),
                Text(AppLocalizations.of(context)!.humanResourceManagementSystem,
                  style: AppTextStyle.bodyLarge.copyWith(
                    color: AppColors.of(context).primary,
                ),)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
