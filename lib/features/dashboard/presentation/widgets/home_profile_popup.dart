import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../l10n/app_localizations.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:dhira_hrms/features/auth/presentation/bloc/auth_event.dart';
import '../bloc/dashboard_cubit.dart';

class HomeProfilePopup extends StatelessWidget {
  const HomeProfilePopup({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () => context.read<DashboardCubit>().closeMenus(),
            child: Container(color: Colors.transparent),
          ),
        ),
        Positioned(
          top: kToolbarHeight + MediaQuery.of(context).padding.top + 8,
          right: 16,
          child: Material(
            color: AppColors.white,
            elevation: 8,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 180,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _popupItem(context, l10n.myProfile, Icons.person, () {
                    context.read<DashboardCubit>().closeMenus();
                    context.push(AppRouter.profilePath);
                  }),
                  _popupItem(context, l10n.changePassword, Icons.password, () {
                    context.read<DashboardCubit>().closeMenus();
                    context.push(AppRouter.changePasswordPath);
                  }),
                  const Divider(),
                  _popupItem(context, l10n.signOut, Icons.logout, () {
                    context.read<DashboardCubit>().closeMenus();
                    context.read<AuthBloc>().add(const AuthEvent.logoutRequested());
                    context.go(AppRouter.loginPath);
                  }, textColor: AppColors.error),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _popupItem(BuildContext context, String title, IconData icon, VoidCallback onTap, {Color? textColor}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 20, color: textColor ?? AppColors.textSecondary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 14, color: textColor ?? AppColors.textPrimary),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
