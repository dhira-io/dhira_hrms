import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class TimesheetWeeklyTotalCard extends StatelessWidget {
  final double totalWeeklyHours;

  const TimesheetWeeklyTotalCard({super.key, required this.totalWeeklyHours});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding:       EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.of(context).black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: AppColors.of(context).tableBorder,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.timesheetWeekTotal,
                style: AppTextStyle.statsLabel.copyWith(
                  fontSize: 11.sp,
                  color: AppColors.of(context).slate600,
                ),
              ),
                    SizedBox(height: 2.h),
              Text(
                l10n.timesheetHoursGoal(totalWeeklyHours.toStringAsFixed(1)),
                style: AppTextStyle.h1.copyWith(
                  color: AppColors.of(context).brandBlue,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
                SizedBox(width: 12.w),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppConstants.r8),
              child: LinearProgressIndicator(
                value: (totalWeeklyHours / 48).clamp(0.0, 1.0),
                backgroundColor: AppColors.of(context).slate100,
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.of(context).brandBlue,
                ),
                minHeight: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
