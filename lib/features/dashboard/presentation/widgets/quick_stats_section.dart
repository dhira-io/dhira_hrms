import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/dashboard_cubit.dart';
import '../bloc/dashboard_state.dart';

class QuickStatsSection extends StatelessWidget {
  const QuickStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {

        final stats = state.stats;

        return Row(
          children: [
            _buildStatCard(
              context,
              value: stats != null ? stats.daysPresent.toString() : AppConstants.placeholderText,
              label: l10n.daysPresent,
              valueColor: AppColors.primary,
            ),
            const SizedBox(width: AppConstants.p12),
            _buildStatCard(
              context,
              value: stats != null ? stats.leaveBalance.toString() : AppConstants.placeholderText,
              label: l10n.leaveBalance,
              valueColor: AppColors.tertiary,
            ),
            const SizedBox(width: AppConstants.p12),
            _buildStatCard(
              context,
              value: stats != null 
                  ? (stats.nextHoliday.split('-').length >= 2 
                      ? stats.nextHoliday.split('-').sublist(0, 2).join('-') 
                      : stats.nextHoliday)
                  : AppConstants.placeholderText,
              label: l10n.upcomingHoliday,
              valueColor: AppColors.textPrimary,
            ),
          ],
        );
      },
    );
  }


  Widget _buildStatCard(
    BuildContext context, {
    required String value,
    required String label,
    required Color valueColor,
    bool isSmallValue = false,
  }) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(AppConstants.r12),
          child: Ink(
            padding: const EdgeInsets.symmetric(
              vertical: AppConstants.p16,
              horizontal: AppConstants.p8,
            ),
            decoration: BoxDecoration(
              color: AppColors.quickStatsBg,
              borderRadius: BorderRadius.circular(AppConstants.r12),
            ),
            child: Column(
              children: [
                Text(
                  value,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.h1.copyWith(
                    color: valueColor,
                    fontSize: isSmallValue ? AppConstants.iconSmall : AppConstants.iconMedium,
                    height: 1.2,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: AppConstants.p4),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.labelSmall.copyWith(
                    color: AppColors.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
                    fontSize: AppConstants.p12,
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
