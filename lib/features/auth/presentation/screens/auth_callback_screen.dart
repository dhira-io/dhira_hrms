import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/toast_utils.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../bloc/sso_cubit.dart';
import 'package:dhira_hrms/features/dashboard/presentation/bloc/bottom_nav_cubit.dart';

class AuthCallbackScreen extends StatefulWidget {
  const AuthCallbackScreen({super.key});

  @override
  State<AuthCallbackScreen> createState() => _AuthCallbackScreenState();
}

class _AuthCallbackScreenState extends State<AuthCallbackScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _checkCurrentState();
      }
    });
  }

  void _checkCurrentState() {
    final ssoState = context.read<SSOCubit>().state;
    ssoState.whenOrNull(
      success: (user) {
        context.read<AuthBloc>().add(AuthEvent.loggedIn(user));
      },
      error: (message) {
        ToastUtils.showError(message);
        context.go(AppRouter.loginPath);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      body: MultiBlocListener(
        listeners: [
          BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              state.whenOrNull(
                authenticated: (user) {
                  Get.find<BottomNavCubit>().changeIndex(
                    BottomNavCubit.homeIndex,
                  );
                  context.go(AppRouter.dashboardPath);
                },
                error: (message) {
                  ToastUtils.showError(message);
                  context.go(AppRouter.loginPath);
                },
                unauthenticated: () {
                  context.go(AppRouter.loginPath);
                },
              );
            },
          ),
          BlocListener<SSOCubit, SSOState>(
            listener: (context, state) {
              state.whenOrNull(
                success: (user) {
                  context.read<AuthBloc>().add(AuthEvent.loggedIn(user));
                },
                error: (message) {
                  ToastUtils.showError(message);
                  context.go(AppRouter.loginPath);
                },
              );
            },
          ),
        ],
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
