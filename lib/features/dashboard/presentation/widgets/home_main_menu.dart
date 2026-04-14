import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/dashboard_cubit.dart';

class HomeMainMenu extends StatelessWidget {
  final Animation<Offset> slideAnimation;
  final Animation<double> fadeAnimation;

  const HomeMainMenu({
    super.key,
    required this.slideAnimation,
    required this.fadeAnimation,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Stack(
      children: [
        Positioned.fill(
          child: GestureDetector(
            onTap: () => context.read<DashboardCubit>().closeMenus(),
            child: AnimatedBuilder(
              animation: fadeAnimation,
              builder: (context, child) => Container(
                color: AppColors.textPrimary.withValues(alpha: fadeAnimation.value * 0.4),
              ),
            ),
          ),
        ),
        Positioned(
          top: kToolbarHeight + MediaQuery.of(context).padding.top,
          left: 0,
          right: 0,
          child: SlideTransition(
            position: slideAnimation,
            child: FadeTransition(
              opacity: fadeAnimation,
              child: Material(
                elevation: 8,
                color: AppColors.white,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _menuItem(context, l10n.calendar, Icons.calendar_month, () {
                        context.read<DashboardCubit>().closeMenus();
                      }),
                      _menuItem(context, l10n.timesheet, Icons.access_time, () {
                        context.read<DashboardCubit>().closeMenus();
                        context.push(AppRouter.timesheetPath);
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _menuItem(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.textSecondary),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
