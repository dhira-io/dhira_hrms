import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;

    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        final stats = state.stats;

        return IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _StatCardWidget(
                value: stats != null
                    ? stats.daysPresent.toString()
                    : AppConstants.placeholderText,
                label: l10n.daysPresent,
                valueColor: colors.primary,
              ),
              const SizedBox(width: AppConstants.p12),
              _StatCardWidget(
                value: stats != null
                    ? stats.leaveBalance.toString()
                    : AppConstants.placeholderText,
                label: l10n.leaveBalance,
                valueColor: colors.tertiary,
              ),
              const SizedBox(width: AppConstants.p12),
              _StatCardWidget(
                value: stats != null
                    ? (stats.nextHoliday.split('-').length >= 2
                          ? stats.nextHoliday.split('-').sublist(0, 2).join('-')
                          : stats.nextHoliday)
                    : AppConstants.placeholderText,
                label: l10n.upcomingHoliday,
                valueColor: colors.textPrimary,
              ),
            ],
          ),
        );
      },
    );
  }

}

class _StatCardWidget extends StatelessWidget {
  final String value;
  final String label;
  final Color valueColor;
  final bool isSmallValue;

  const _StatCardWidget({
    required this.value,
    required this.label,
    required this.valueColor,
    this.isSmallValue = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Expanded(
      child: Material(
        color: colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(AppConstants.r12),
          child: Ink(
            padding: const EdgeInsets.symmetric(
              vertical: AppConstants.p16,
              horizontal: AppConstants.p8,
            ),
            decoration: BoxDecoration(
              color: colors.quickStatsBg,
              borderRadius: BorderRadius.circular(AppConstants.r12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.h1.copyWith(
                    color: valueColor,
                    height: 1.2.h,
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
                    color: colors.onSurfaceVariant,
                    fontWeight: FontWeight.bold,
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
