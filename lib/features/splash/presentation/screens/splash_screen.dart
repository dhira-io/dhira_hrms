import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/auth_event.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/auth_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late final AuthBloc authBloc;

  @override
  void initState() {
    super.initState();
    authBloc = Get.find<AuthBloc>();
    authBloc.add(const AuthEvent.authStatusChecked());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>.value(
      value: authBloc,
      child: const SplashView(),
    );
  }
}

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        state.whenOrNull(
          authenticated: (user) => context.go(AppRouter.dashboardPath),
          unauthenticated: () => context.go(AppRouter.loginPath),
          error: (_) => context.go(AppRouter.loginPath),
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.surface,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(AppAssets.logo, height: 100),
              const SizedBox(height: AppConstants.p20),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
