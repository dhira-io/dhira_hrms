import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';

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
      if (mounted) {
        context.read<AuthBloc>().add(
          const AuthEvent.authStatusChecked(),
        );
      }
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
        final isFirstTime = Get.find<LocalStorageService>().getIsFirstTime();
        state.whenOrNull(
          authenticated: (user) =>
              context.go(AppRouter.dashboardPath),
          unauthenticated: () {
            if (isFirstTime) {
              context.go(AppRouter.welcomePath);
            } else {
              context.go(AppRouter.loginPath);
            }
          },
          error: (_) {
            if (isFirstTime) {
              context.go(AppRouter.welcomePath);
            } else {
              context.go(AppRouter.loginPath);
            }
          },
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.of(context).surface,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              isDark
                  ? ColorFiltered(
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                      child: Image.asset(AppAssets.logo, height: 100),
                    )
                  : Image.asset(AppAssets.logo, height: 100),
              const SizedBox(height: AppConstants.p20),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
