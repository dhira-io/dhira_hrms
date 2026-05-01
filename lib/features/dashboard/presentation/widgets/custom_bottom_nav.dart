import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/bottom_nav_cubit.dart';

class CustomBottomNav extends StatelessWidget {
  const CustomBottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<BottomNavCubit, int>(
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.only(
            bottom: AppConstants.p24,
            left: AppConstants.p16,
            right: AppConstants.p16,
          ),
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppConstants.r24),
            boxShadow: [
              BoxShadow(
                color: AppColors.onSurface.withValues(alpha: 0.08),
                blurRadius: 32,
                offset: const Offset(0, -12),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
              child: Container(
                color: Colors.white.withValues(alpha: 0.8),
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.p8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      context,
                      index: BottomNavCubit.homeIndex,
                      currentIndex: state,
                      icon: Icons.home_filled,
                      label: l10n.home,
                    ),
                    _buildNavItem(
                      context,
                      index: BottomNavCubit.attendanceIndex,
                      currentIndex: state,
                      icon: Icons.calendar_today_outlined,
                      label: l10n.calendar,
                    ),
                    _buildNavItem(
                      context,
                      index: BottomNavCubit.myOrgIndex,
                      currentIndex: state,
                      icon: Icons.corporate_fare_outlined,
                      label: l10n.myOrg,
                    ),
                    _buildNavItem(
                      context,
                      index: BottomNavCubit.notificationsIndex,
                      currentIndex: state,
                      icon: Icons.notifications_outlined,
                      label: "Inbox",
                    ),
                    _buildNavItem(
                      context,
                      index: BottomNavCubit.settingsIndex,
                      currentIndex: state,
                      icon: Icons.settings_outlined,
                      label: l10n.settings,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required int index,
    required int currentIndex,
    required IconData icon,
    required String label,
  }) {
    final isActive = index == currentIndex;
    return GestureDetector(
      onTap: () => context.read<BottomNavCubit>().changeIndex(index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppConstants.p16,
          vertical: AppConstants.p8,
        ),
        decoration: BoxDecoration(
          color: isActive ? AppColors.primaryFixed : Colors.transparent,
          borderRadius: BorderRadius.circular(AppConstants.r16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? AppColors.primary : AppColors.onSurfaceVariant,
              size: AppConstants.iconMedium,
            ),
            if (isActive) ...[
              const SizedBox(height: 2),
              Text(
                label,
                style: AppTextStyle.labelSmall.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                  fontSize: 10,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
