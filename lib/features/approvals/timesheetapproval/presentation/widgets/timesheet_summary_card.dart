import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/domain/entities/timesheet_approval_entity.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/timesheet_status_badge.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';

class TimesheetSummaryCard extends StatelessWidget {
  final TimesheetApprovalEntity timesheet;

  const TimesheetSummaryCard({super.key, required this.timesheet});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;
    final weekText = DateTimeUtils.getWeekNumber(timesheet.fromDate, l10n);
    final dateRangeText = DateTimeUtils.formatWeekRangeStr(timesheet.fromDate, timesheet.toDate);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: colors.blue500,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                weekText,
                style: AppTextStyle.bodySmall.copyWith(
                  color: colors.white.withValues(alpha: 0.8),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const TimesheetStatusBadge(status: 'pending'),
            ],
          ),
          Text(
            dateRangeText,
            style: AppTextStyle.titleMedium.copyWith(
              color: colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: _buildInfoCard(
                  context,
                  l10n.expectedHours,
                  "${timesheet.expectedHoursTotal.toInt()}h",
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildInfoCard(
                  context,
                  l10n.actualTime,
                  "${timesheet.totalSpentHours.toInt()}h",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context, String label, String value) {
    final colors = AppColors.of(context);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: colors.white,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyle.labelMedium.copyWith(
              color: colors.onSecondaryContainer,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            value,
            style: AppTextStyle.titleMedium.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
