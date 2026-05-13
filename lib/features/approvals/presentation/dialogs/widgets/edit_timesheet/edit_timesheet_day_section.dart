import 'package:dhira_hrms/core/constants/app_constants.dart';
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
    final l10n = AppLocalizations.of(context)!;
    final totalHrs = assignments.fold(
      0.0,
      (sum, a) => sum + (double.tryParse(actualControllers[a.name ?? a.hashCode.toString()]?.text ?? "") ?? a.spentHours),
    );

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: onToggle,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.calendar_today_outlined, size: 20, color: AppColors.textPrimary),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateTimeUtils.formatDateString(date, pattern: AppFormats.dateWithDay),
                          style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          l10n.submittedOn(assignments.first.date ?? ""),
                          style: AppTextStyle.labelSmall.copyWith(color: AppColors.textSecondary),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.infoBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      l10n.totalHrs(totalHrs.toInt()),
                      style: AppTextStyle.labelSmall.copyWith(color: AppColors.info, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded) ...[
            const Divider(height: 1),
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
                  return DataRow(cells: [
                    DataCell(Text(idx.toString())),
                    DataCell(_buildTableDropdown(key)),
                    DataCell(_buildTableTextField(taskControllers[key]!)),
                    DataCell(_buildTableTextField(descriptionControllers[key]!, width: 180, isLarge: true)),
                    DataCell(_buildTableTextField(expectedControllers[key]!, width: 60, suffix: l10n.hoursUnit)),
                    DataCell(_buildTableTextField(actualControllers[key]!, width: 60, suffix: l10n.hoursUnit)),
                    DataCell(TimesheetStatusBadge(status: a.status ?? l10n.pending)),
                    DataCell(Text(getEmployeeName(a.raisedBy, employees), style: AppTextStyle.bodySmall)),
                  ]);
                }).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTableDropdown(String key) {
    return SizedBox(
      width: 150,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedProjects[key],
          isExpanded: true,
          isDense: true,
          style: AppTextStyle.bodySmall,
          items: projects
              .map((p) => DropdownMenuItem(
                    value: p.name,
                    child: Text(
                      p.projectName,
                      style: AppTextStyle.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ))
              .toList(),
          onChanged: (val) => onProjectChanged(key, val),
        ),
      ),
    );
  }

  Widget _buildTableTextField(
    TextEditingController controller, {
    double width = 120,
    bool isLarge = false,
    String? suffix,
  }) {
    return SizedBox(
      width: width,
      child: TextField(
        controller: controller,
        style: AppTextStyle.bodySmall,
        maxLines: isLarge ? 3 : 1,
        minLines: 1,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(6)),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: AppColors.border),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: AppColors.primary),
          ),
          suffixText: suffix,
        ),
      ),
    );
  }
}
