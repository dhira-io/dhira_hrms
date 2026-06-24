import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/domain/entities/project_assignment_approval_entity.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/timesheet_status_badge.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_entity.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class EditTimesheetDaySection extends StatelessWidget {
  final String date;
  final List<ProjectAssignmentApprovalEntity> assignments;
  final List<ProjectEntity> projects;
  final List<Map<String, dynamic>> employees;
  final bool isExpanded;
  final VoidCallback onToggle;
  final Map<String, TextEditingController> taskControllers;
  final Map<String, TextEditingController> descriptionControllers;
  final Map<String, TextEditingController> expectedControllers;
  final Map<String, TextEditingController> actualControllers;
  final Map<String, String?> selectedProjects;
  final Function(String, String?) onProjectChanged;
  final Function(ProjectAssignmentApprovalEntity) onRemove;
  final String Function(String?, List<Map<String, dynamic>>) getEmployeeName;

  const EditTimesheetDaySection({
    super.key,
    required this.date,
    required this.assignments,
    required this.projects,
    required this.employees,
    required this.isExpanded,
    required this.onToggle,
    required this.taskControllers,
    required this.descriptionControllers,
    required this.expectedControllers,
    required this.actualControllers,
    required this.selectedProjects,
    required this.onProjectChanged,
    required this.onRemove,
    required this.getEmployeeName,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;
    final totalHrs = assignments.fold(
      0.0,
      (sum, a) =>
          sum +
          (double.tryParse(
                actualControllers[a.name ?? a.hashCode.toString()]?.text ?? "",
              ) ??
              a.spentHours),
    );

    return Container(
      margin:       EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        border: Border.all(color: colors.border),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            child: Padding(
              padding:       EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 20,
                    color: colors.textPrimary,
                  ),
                        SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateTimeUtils.formatDateString(
                            date,
                            pattern: DateTimeUtils.dateWithDay,
                          ),
                          style: AppTextStyle.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          l10n.submittedOn(assignments.first.date ?? ""),
                          style: AppTextStyle.labelSmall.copyWith(
                            color: colors.textSecondary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                        SizedBox(width: 8.w),
                  Container(
                    padding:       EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: colors.infoBg,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Text(
                      l10n.totalHrs(totalHrs.toInt()),
                      style: AppTextStyle.labelSmall.copyWith(
                        color: colors.info,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                        SizedBox(width: 8.w),
                  Icon(
                    isExpanded
                        ? Icons.keyboard_arrow_up
                        : Icons.keyboard_arrow_down,
                    color: colors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) ...[
            Divider(height: 1.h),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columnSpacing: 16,
                headingRowHeight: 40,
                dataRowMinHeight: 56,
                dataRowMaxHeight: 72,
                horizontalMargin: 16,
                columns: [
                  DataColumn(label: Text(l10n.slNo)),
                  DataColumn(label: Text(l10n.project)),
                  DataColumn(label: Text(l10n.task)),
                  DataColumn(label: Text(l10n.description)),
                  DataColumn(label: Text(l10n.expectedTime)),
                  DataColumn(label: Text(l10n.actualTime)),
                  DataColumn(label: Text(l10n.status)),
                  DataColumn(label: Text(l10n.raisedBy)),
                ],
                rows: assignments.asMap().entries.map((entry) {
                  final idx = entry.key + 1;
                  final a = entry.value;
                  final key = a.name ?? a.hashCode.toString();
                  return DataRow(
                    cells: [
                      DataCell(Text(idx.toString())),
                      DataCell(_buildTableDropdown(context, key)),
                      DataCell(
                        _buildTableTextField(context, taskControllers[key]!),
                      ),
                      DataCell(
                        _buildTableTextField(
                          context,
                          descriptionControllers[key]!,
                          width: 180.w,
                          isLarge: true,
                        ),
                      ),
                      DataCell(
                        _buildTableTextField(
                          context,
                          expectedControllers[key]!,
                          width: 60.w,
                          suffix: l10n.hoursUnit,
                        ),
                      ),
                      DataCell(
                        _buildTableTextField(
                          context,
                          actualControllers[key]!,
                          width: 60.w,
                          suffix: l10n.hoursUnit,
                        ),
                      ),
                      DataCell(
                        TimesheetStatusBadge(status: a.status ?? l10n.pending),
                      ),
                      DataCell(
                        Text(
                          getEmployeeName(a.raisedBy, employees),
                          style: AppTextStyle.bodySmall,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTableDropdown(BuildContext context, String key) {
    final colors = AppColors.of(context);
    return SizedBox(
      width: 150.w,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedProjects[key],
          isExpanded: true,
          isDense: true,
          dropdownColor: colors.surfaceContainerHighest,
          style: AppTextStyle.bodySmall.copyWith(
            color: colors.textPrimary,
          ),
          items: projects
              .map(
                (p) => DropdownMenuItem(
                  value: p.name,
                  child: Text(
                    p.projectName,
                    style: AppTextStyle.bodySmall.copyWith(
                      color: colors.textPrimary,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              )
              .toList(),
          onChanged: (val) => onProjectChanged(key, val),
        ),
      ),
    );
  }

  Widget _buildTableTextField(
    BuildContext context,
    TextEditingController controller, {
    double width = 120,
    bool isLarge = false,
    String? suffix,
  }) {
    final colors = AppColors.of(context);
    return SizedBox(
      width: width,
      child: TextField(
        controller: controller,
        style: AppTextStyle.bodySmall.copyWith(
          color: colors.textPrimary,
        ),
        maxLines: isLarge ? 3 : 1,
        minLines: 1,
        decoration: InputDecoration(
          isDense: true,
          contentPadding:       EdgeInsets.symmetric(
            horizontal: 8.w,
            vertical: 8.h,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6.r)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.r),
            borderSide: BorderSide(color: colors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.r),
            borderSide: BorderSide(color: colors.primary),
          ),
          suffixText: suffix,
        ),
      ),
    );
  }
}
