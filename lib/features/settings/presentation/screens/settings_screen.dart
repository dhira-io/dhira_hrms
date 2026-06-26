import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_state.dart';
import '../bloc/settings_cubit.dart';
import '../bloc/settings_state.dart';
import '../widgets/settings_body.dart';
import '../../../dashboard/presentation/bloc/bottom_nav_cubit.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SettingsCubit>().loadProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return MultiBlocListener(
      listeners: [
        BlocListener<SettingsCubit, SettingsState>(
          listenWhen: (prev, curr) => prev.errorMessage != curr.errorMessage,
          listener: (context, state) {
            if (state.errorMessage != null) {
              final errorMessage = state.errorMessage == 'userEmailNotFound'
                  ? l10n.userEmailNotFound
                  : state.errorMessage!;
              ToastUtils.showError(errorMessage);
            }
          },
        ),
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            state.maybeWhen(
              unauthenticated: () => context.go(AppRouter.loginPath),
              error: (message) => ToastUtils.showError(message),
              orElse: () {},
            );
          },
        ),
      ],
      child: Scaffold(
        backgroundColor: AppColors.of(context).background,
        appBar: AppBar(
          backgroundColor: AppColors.of(context).surfaceContainerLowest,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.chevron_left,
              color: AppColors.of(context).onSurface,
            ),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.read<BottomNavCubit>().changeIndex(0);
              }
            },
          ),
          title: Text(
            l10n.settings,
            style: TextStyle(
              color: AppColors.of(context).onSurface,
              fontWeight: FontWeight.bold,
              fontSize: 18.sp,
            ),
          ),
          centerTitle: false,
          titleSpacing: 0,
        ),
        body: const SettingsBody(),
      ),
    );
  }
}
