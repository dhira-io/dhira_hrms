import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/dashboard_cubit.dart';
import '../bloc/dashboard_state.dart';
import 'package:shimmer/shimmer.dart';

class QuickStatsSection extends StatelessWidget {
  const QuickStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        if (state.statsLoading && state.stats == null) {
          return _buildLoadingShimmer();
        }

        final stats = state.stats;

        return Row(
          children: [
            _buildStatCard(
              context,
              value: stats != null ? stats.daysPresent.toString() : '--',
              label: l10n.daysPresent,
              valueColor: AppColors.primary,
            ),
            const SizedBox(width: AppConstants.p12),
            _buildStatCard(
              context,
              value: stats != null ? stats.leaveBalance.toString() : '--',
              label: l10n.leaveBalance,
              valueColor: AppColors.tertiary,
            ),
            const SizedBox(width: AppConstants.p12),
            _buildStatCard(
              context,
              value: stats != null ? stats.nextHoliday : '--',
              label: l10n.upcomingHoliday,
              valueColor: AppColors.textPrimary,
              isSmallValue: true,
            ),
          ],
        );
      },
    );
  }

  Widget _buildLoadingShimmer() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Row(
        children: List.generate(
          3,
          (index) => Expanded(
            child: Container(
              height: 80,
              margin: EdgeInsets.only(right: index == 2 ? 0 : 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
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
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppConstants.p16,
          horizontal: AppConstants.p8,
        ),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
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
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyle.labelSmall.copyWith(
                color: AppColors.onSurfaceVariant,
                fontWeight: FontWeight.w600,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
