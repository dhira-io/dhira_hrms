import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/domain/entities/timesheet_approval_entity.dart';

class TimesheetSummaryCard extends StatelessWidget {
  final TimesheetApprovalEntity timesheet;

  const TimesheetSummaryCard({
    super.key,
    required this.timesheet,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buildItem("Week", "${timesheet.fromDate} - ${timesheet.toDate}"),
              ),
              Expanded(
                child: _buildItem("Expected Hours", "${timesheet.expectedHoursTotal.toInt()}h"),
              ),
              Expanded(
                child: _buildItem("Actual Hours", "${timesheet.totalSpentHours.toInt()}h"),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildItem("Approver", timesheet.approverName ?? "—", isBadge: true),
              ),
              Expanded(
                child: _buildProjects("Projects Worked", timesheet),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItem(String label, String value, {bool isBadge = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.bodySmall.copyWith(color: const Color(0xFF64748B), fontSize: 12)),
        const SizedBox(height: 8),
        if (isBadge)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Text(value, style: AppTextStyle.bodySmall.copyWith(fontWeight: FontWeight.bold, fontSize: 13)),
          )
        else
          Text(value, style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.bold, fontSize: 15)),
      ],
    );
  }

  Widget _buildProjects(String label, TimesheetApprovalEntity timesheet) {
    final projects = timesheet.projectAssignments?.map((a) => a.project).toSet().toList() ?? [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.bodySmall.copyWith(color: const Color(0xFF64748B), fontSize: 12)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: projects.map((p) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Text(p ?? "—", style: AppTextStyle.bodySmall.copyWith(fontWeight: FontWeight.bold, fontSize: 13)),
          )).toList(),
        ),
      ],
    );
  }
}
