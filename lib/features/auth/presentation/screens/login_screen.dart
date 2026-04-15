import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/utils/toast_utils.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../bloc/login_cubit.dart';
import '../bloc/sso_cubit.dart';
import '../widgets/login_form.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const LoginView();
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>.value(value: Get.find<AuthBloc>()),
        BlocProvider<LoginCubit>.value(value: Get.find<LoginCubit>()),
        BlocProvider<SSOCubit>.value(value: Get.find<SSOCubit>()),
      ],
      child: const LoginView(),
    );
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              state.whenOrNull(
                authenticated: (user) => context.go(AppRouter.dashboardPath),
                error: (message) => ToastUtils.showError(message),
              );
            },
          ),
          BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              state.whenOrNull(
                success: (user) {
                  context.read<AuthBloc>().add(AuthEvent.loggedIn(user));
                },
                error: (message) => ToastUtils.showError(message),
              );
            },
          ),
          BlocListener<SSOCubit, SSOState>(
            listener: (context, state) {
              state.whenOrNull(
                success: (user) {
                  context.read<AuthBloc>().add(AuthEvent.loggedIn(user));
                },
                error: (message) => ToastUtils.showError(message),
              );
            },
          ),
        ],
        child: Padding(
          padding: const EdgeInsets.all(AppConstants.p20),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(AppAssets.logo, height: 100),
                  const SizedBox(height: AppConstants.p40),
                  LoginForm(
                    onForgotPasswordTap: () {
                      context.push(AppRouter.forgotPasswordPath);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

