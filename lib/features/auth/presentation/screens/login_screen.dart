import 'package:dhira_hrms/features/dashboard/presentation/bloc/bottom_nav_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../l10n/app_localizations.dart';
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
  }
}

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
        child: MultiBlocListener(
          listeners: [
            BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              state.whenOrNull(
                authenticated: (user) {
                  Get.find<BottomNavCubit>().changeIndex(BottomNavCubit.homeIndex);
                  context.go(AppRouter.dashboardPath);
                },
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Premium starry/dark slate header
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 32,
                  left: 24,
                  right: 24,
                  bottom: 36,
                ),
                decoration: BoxDecoration(
                  color: AppColors.of(context).primaryContainer,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Logo (ColorFiltered to White)
                    ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        AppColors.of(context).white,
                        BlendMode.srcIn,
                      ),
                      child: Image.asset(
                        AppAssets.logo,
                        height: 37,
                      ),
                    ),
                    const SizedBox(height: 36),
                    // Heading: "Sign in to your Account"
                    Text(
                      l10n.signInToYourAccount,
                      style: AppTextStyle.loginHeaderTitle.copyWith(
                        color: AppColors.of(context).white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Subheading: "Enter your email and password to log in"
                    Text(
                      l10n.enterEmailAndPasswordToLogin,
                      style: AppTextStyle.loginHeaderSubtitle.copyWith(
                        color: AppColors.of(context).lightGrey,
                      ),
                    ),
                  ],
                ),
              ),

              // Bottom container with Login form
              Container(
                color: AppColors.of(context).background,
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: LoginForm(
                  onForgotPasswordTap: () {
                    context.push(AppRouter.forgotPasswordPath);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
}
