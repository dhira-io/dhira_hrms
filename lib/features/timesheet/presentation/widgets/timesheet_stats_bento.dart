import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/timesheet_bloc.dart';
import '../bloc/timesheet_state.dart';
import '../bloc/timesheet_status.dart';

import 'package:shimmer/shimmer.dart';

class TimesheetBentoStats extends StatelessWidget {
  const TimesheetBentoStats({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimesheetBloc, TimesheetState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.formattedOverviewWeeks != current.formattedOverviewWeeks ||
          previous.overview != current.overview,
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;
        final isLoading = state.status == TimesheetStateStatus.loading;
        final weekMeta = state.formattedOverviewWeeks;
        final overview = state.overview;

        // Fallback to 0 if not provided
        final f = overview?.filled ?? 0;
        final a = overview?.approved ?? 0;
        final p = overview?.pendingApproval ?? 0;
        final r = overview?.correctionNeeded ?? 0;
        final u = overview?.upcomingToSubmit ?? 0;

        return Column(
          children: [
            Container(
              padding:       EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.of(context).surfaceContainerLowest,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.of(context).black.withValues(alpha: 0.04),
                    blurRadius: 32,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.timesheetFiled.toUpperCase(),
                            style: AppTextStyle.statsLabel,
                          ),
                                SizedBox(height: 4.h),
                          isLoading
                              ?       StatShimmer(height: 28.h, width: 80.w)
                              : Text(
                                  l10n.weeksCount(f),
                                  style: AppTextStyle.statsValue,
                                ),
                        ],
                      ),
                      Container(
                        width: 48.w,
                        height: 48.h,
                        decoration: BoxDecoration(
                          color: AppColors.of(context).primaryFixed,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.query_stats,
                          color: AppColors.of(context).onPrimaryFixedVariant,
                        ),
                      ),
                    ],
                  ),
                  if (weekMeta.isNotEmpty) ...[
                          SizedBox(height: 8.h),
                    Text(
                      weekMeta,
                      style: AppTextStyle.statsLabel.copyWith(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
                  SizedBox(height: 12.h),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 2.1,
              children: [
                TimesheetSmallStatCard(
                  label: l10n.timesheetApproved.toUpperCase(),
                  value: a,
                  weeks: "",
                  icon: Icons.check_circle,
                  iconColor: AppColors.of(context).success,
                  isLoading: isLoading,
                ),
                TimesheetSmallStatCard(
                  label: l10n.timesheetPending.toUpperCase(),
                  value: p,
                  weeks: "",
                  icon: Icons.pending,
                  iconColor: AppColors.of(context).warning,
                  isLoading: isLoading,
                ),
                TimesheetSmallStatCard(
                  label: l10n.timesheetRejected.toUpperCase(),
                  value: r,
                  weeks: "",
                  icon: Icons.cancel,
                  iconColor: AppColors.of(context).error,
                  isLoading: isLoading,
                ),
                TimesheetSmallStatCard(
                  label: l10n.timesheetUpcoming.toUpperCase(),
                  value: u,
                  weeks: "",
                  icon: Icons.event,
                  iconColor: AppColors.of(context).primaryBlue,
                  isLoading: isLoading,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class TimesheetSmallStatCard extends StatelessWidget {
  final String label;
  final int value;
  final String weeks;
  final IconData icon;
  final Color iconColor;
  final bool isLoading;

  const TimesheetSmallStatCard({
    super.key,
    required this.label,
    required this.value,
    required this.weeks,
    required this.icon,
    required this.iconColor,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding:       EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLow,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.of(context).outlineVariant.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 14, color: iconColor),
                    SizedBox(width: 8.w),
              Text(
                label,
                style: AppTextStyle.statsLabel.copyWith(fontSize: 10.sp),
              ),
            ],
          ),
                SizedBox(height: 4.h),
          isLoading
              ?       StatShimmer(height: 22.h, width: 50.w)
              : Text(
                  l10n.weeksCount(value),
                  style: AppTextStyle.h3.copyWith(
                    fontWeight: FontWeight.w800,
                    fontSize: 18.sp,
                  ),
                ),
          const Spacer(),
          if (weeks.isNotEmpty)
            Text(
              weeks,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyle.statsLabel.copyWith(
                fontSize: 10.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
        ],
      ),
    );
  }
}

class StatShimmer extends StatelessWidget {
  final double height;
  final double width;

  const StatShimmer({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    final resolvedColors = AppColors.of(context);
    return Shimmer.fromColors(
      baseColor: resolvedColors.shimmerBase,
      highlightColor: resolvedColors.shimmerHighlight,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: resolvedColors.white,
          borderRadius: BorderRadius.circular(4.r),
        ),
      ),
    );
  }
}
