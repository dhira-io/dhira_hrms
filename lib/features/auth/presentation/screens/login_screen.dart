import 'package:dhira_hrms/features/dashboard/presentation/bloc/bottom_nav_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../core/widgets/geometric_background_pattern.dart';
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
      backgroundColor: AppColors.of(context).primaryContainer,
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
          child: Column(
            children: [
              // Top Blue Header Section
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.of(context).primaryContainer.withValues(alpha: 0.85),
                          AppColors.of(context).primaryContainer,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  // Background geometric pattern mimicking the target design
                  const GeometricBackgroundPattern(),
                  // Content
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + 8.h,
                      left: 16.w,
                      right: 16.w,
                      bottom: 24.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Top Logo (ColorFiltered to White)
                        ColorFiltered(
                          colorFilter: ColorFilter.mode(
                            AppColors.of(context).white,
                            BlendMode.srcIn,
                          ),
                          child: Image.asset(
                            AppAssets.logo,
                            height: 48.h,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        // Heading: "Welcome to DHIRA ERP!"
                        Text(
                          l10n.welcomeToDhiraErp,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.loginHeaderTitle.copyWith(
                            color: AppColors.of(context).white,
                            fontSize: 24.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        // Subheading: "A unified platform..."
                        Text(
                          l10n.dhiraErpSubtitle,
                          textAlign: TextAlign.center,
                          style: AppTextStyle.loginHeaderSubtitle.copyWith(
                            color: AppColors.of(context).white.withValues(alpha: 0.9),
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Bottom White Container (Expanded to fill remaining space)
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.of(context).background,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(32.r)),
                  ),
                  child: SingleChildScrollView(
                    padding: EdgeInsets.fromLTRB(24.w, 12.h, 24.w, 32.h),
                    child: LoginForm(
                      onForgotPasswordTap: () {
                        context.push(AppRouter.forgotPasswordPath);
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
