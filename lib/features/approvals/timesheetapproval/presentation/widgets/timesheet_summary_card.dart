import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/domain/entities/timesheet_approval_entity.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/projects_worked_list.dart';

class TimesheetSummaryCard extends StatelessWidget {
  final TimesheetApprovalEntity timesheet;

  const TimesheetSummaryCard({super.key, required this.timesheet});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Container(
      padding:       EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.of(context).slate200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: SummaryItem(
                  label: l10n.weekRangeLabel,
                  value: "${timesheet.fromDate} - ${timesheet.toDate}",
                ),
              ),
              Expanded(
                child: SummaryItem(
                  label: l10n.expectedHours,
                  value: "${timesheet.expectedHoursTotal.toInt()}h",
                ),
              ),
              Expanded(
                child: SummaryItem(
                  label: l10n.actualTime,
                  value: "${timesheet.totalSpentHours.toInt()}h",
                ),
              ),
            ],
          ),
                SizedBox(height: 16.h),
          Row(
            children: [
              Expanded(
                child: SummaryItem(
                  label: l10n.approver,
                  value: timesheet.approverName ?? "—",
                  isBadge: true,
                ),
              ),
              Expanded(
                child: ProjectsWorkedList(
                  label: l10n.projectsLabel,
                  projects:
                      timesheet.projectAssignments
                          ?.map((a) => a.project)
                          .toList() ??
                      [],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SummaryItem extends StatelessWidget {
  final String label;
  final String value;
  final bool isBadge;

  const SummaryItem({
    super.key,
    required this.label,
    required this.value,
    this.isBadge = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.bodySmall.copyWith(
            color: AppColors.of(context).slate500,
            fontSize: 12.sp,
          ),
        ),
              SizedBox(height: 8.h),
        if (isBadge)
          Container(
            padding:       EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 6.h,
            ),
            decoration: BoxDecoration(
              color: AppColors.of(context).surfaceContainerLowest,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: AppColors.of(context).slate200),
            ),
            child: Text(
              value,
              style: AppTextStyle.bodySmall.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 13.sp,
              ),
            ),
          )
        else
          Text(
            value,
            style: AppTextStyle.bodyMedium.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 15.sp,
            ),
          ),
      ],
    );
  }
}
