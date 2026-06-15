import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/timesheet_bloc.dart';
import '../bloc/timesheet_state.dart';

class TimesheetWeeklyRange extends StatelessWidget {
  const TimesheetWeeklyRange({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimesheetBloc, TimesheetState>(
      buildWhen: (previous, current) =>
          previous.weeklyTotalHours != current.weeklyTotalHours,
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;
        final double logged = state.weeklyTotalHours;
        const double target = 48.0; // The user requested 48h earlier
        final double remaining = (target - logged).clamp(0.0, target);
        final double percent = (logged / target).clamp(0.0, 1.0);
        final int percentInt = (percent * 100).toInt();

        return Row(
          children: [
            Expanded(
              child: _StatCard(
                title: l10n.logged,
                value: '${logged.toStringAsFixed(logged.truncateToDouble() == logged ? 0 : 1)}h',
                subtitle: l10n.thisWeek,
                valueColor: AppColors.colorBlue400,
                bgColor: AppColors.colorBlue50,
                borderColor: AppColors.colorBlue200,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: _StatCard(
                title: l10n.target,
                value: '${target.toInt()}h',
                subtitle: 'Mon-Sat', // Or localized
                valueColor: AppColors.colorGreen600,
                bgColor: AppColors.colorGreen50,
                borderColor: AppColors.colorGreen200,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: _StatCard(
                title: l10n.remaining,
                value: '${remaining.toStringAsFixed(remaining.truncateToDouble() == remaining ? 0 : 1)}h',
                subtitle: '$percentInt% complete',
                valueColor: AppColors.colorOrange500,
                bgColor: AppColors.colorOrange50,
                borderColor: AppColors.colorOrange200,
              ),
            ),
          ],
        );
      },
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String subtitle;
  final Color valueColor;
  final Color bgColor;
  final Color borderColor;

  const _StatCard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.valueColor,
    required this.bgColor,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 9.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: AppColors.of(context).textPrimary,
              fontSize: 10.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            style: TextStyle(
              color: valueColor,
              fontSize: 14.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            subtitle,
            style: TextStyle(
              color: AppColors.of(context).textSecondary,
              fontSize: 10.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
