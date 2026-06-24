import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../bloc/dashboard_cubit.dart';
import '../bloc/dashboard_state.dart';
import '../../utils/dashboard_utils.dart';

class HomeQuickStats extends StatelessWidget {
  const HomeQuickStats({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppConstants.p20.w),
      child: Container(
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: colors.outlineVariant.withValues(alpha: 0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                l10n.quickStats,
                style: AppTextStyle.bodyLarge.copyWith(
                  color: colors.onSurface,
                  fontWeight: FontWeight.w500,
                  ),
              ),
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: colors.outlineVariant.withValues(alpha: 0.3),
            ),
            BlocSelector<DashboardCubit, DashboardState, dynamic>(
              selector: (state) => state.stats,
              builder: (context, stats) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: IntrinsicHeight(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: _StatColumn(
                            title: l10n.daysPresentTitle,
                            value: stats != null ? stats.daysPresent.toString() : l10n.notAvailable,
                            subtitle: "(${l10n.currentMonth})",
                          ),
                        ),
                        VerticalDivider(
                          width: 1,
                          thickness: 1,
                          color: colors.outlineVariant.withValues(alpha: 0.3),
                        ),
                        Expanded(
                          child: _StatColumn(
                            title: l10n.leaveBalanceTitle,
                            value: stats != null ? stats.leaveBalance.toString() : l10n.notAvailable,
                            subtitle: "(${l10n.total})",
                          ),
                        ),
                        VerticalDivider(
                          width: 1,
                          thickness: 1,
                          color: colors.outlineVariant.withValues(alpha: 0.3),
                        ),
                        Expanded(
                          child: _StatColumn(
                            title: l10n.upcoming,
                            value: stats != null
                                ? DashboardUtils.formatHoliday(stats.nextHoliday)
                                : l10n.notAvailable,
                            subtitle: l10n.dhiraHoliday,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;

  const _StatColumn({
    required this.title,
    required this.value,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: AppTextStyle.headlineSmall.copyWith(
            color: colors.primary,
            fontWeight: FontWeight.w500,
            ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 4.h),
        Text(
          title,
          style: AppTextStyle.bodySmall.copyWith(
            color: colors.onSurfaceVariant,
            fontWeight: FontWeight.w500,
            ),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (subtitle.isNotEmpty) ...[
          Text(
            subtitle,
            style: AppTextStyle.bodySmall.copyWith(
              color: colors.onSurfaceVariant,
              fontWeight: FontWeight.w500,
              ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }
}
