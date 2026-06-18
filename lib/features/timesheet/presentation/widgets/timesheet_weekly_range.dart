import 'package:dhira_hrms/features/timesheet/domain/constants/timesheet_constants.dart';
import 'package:dhira_hrms/core/utils/double_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
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
        // Computed in TimesheetState using TimesheetConstants.weeklyTargetHours (48h)
        final double remaining = state.weeklyRemainingHours;
        final int percentInt = state.weeklyProgressPercentInt;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.of(context).surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.of(context).tableBorder),
            boxShadow: [
              BoxShadow(
                color: AppColors.of(context).black.withValues(alpha: 0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.weeklyRange,
                style: AppTextStyle.labelLarge.copyWith(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.of(context).textPrimary,
                ),
              ),
              SizedBox(height: 6.h),
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      title: l10n.logged,
                      value: '${logged.formatHours()}h',
                      subtitle: l10n.thisWeek,
                      valueColor: AppColors.colorBlue400,
                      bgColor: AppColors.colorBlue50,
                      borderColor: AppColors.colorBlue200,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: _StatCard(
                      title: l10n.target,
                      value: '${TimesheetConstants.weeklyTargetHours.toInt()}h',
                      subtitle: l10n.monFri,
                      valueColor: AppColors.colorGreen600,
                      bgColor: AppColors.colorGreen50,
                      borderColor: AppColors.colorGreen200,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Expanded(
                    child: _StatCard(
                      title: l10n.remaining,
                      value: '${remaining.formatHours()}h',
                      subtitle: l10n.percentComplete(percentInt.toString()),
                      valueColor: AppColors.colorOrange500,
                      bgColor: AppColors.colorOrange50,
                      borderColor: AppColors.colorOrange200,
                    ),
                  ),
                ],
              ),
            ],
          ),
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
            style: AppTextStyle.bodySmall.copyWith(
              color: AppColors.of(context).textPrimary,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            style: AppTextStyle.bodyLarge.copyWith(
              color: valueColor,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            subtitle,
            style: AppTextStyle.bodySmall.copyWith(
              color: AppColors.of(context).textSecondary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
