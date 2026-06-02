import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/domain/entities/timesheet_approval_entity.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/timesheet_status_badge.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_entity.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class DaySectionWidget extends StatelessWidget {
  final String date;
  final List<ProjectAssignmentApprovalEntity> assignments;
  final List<ProjectEntity> projects;
  final List<Map<String, dynamic>> employees;
  final bool isExpanded;
  final VoidCallback onTap;
  final Map<String, TextEditingController> taskControllers;
  final Map<String, TextEditingController> descriptionControllers;
  final Map<String, TextEditingController> expectedControllers;
  final Map<String, TextEditingController> actualControllers;
  final Map<String, String?> selectedProjects;
  final Function(ProjectAssignmentApprovalEntity) onRemove;
  final VoidCallback onStateChange;
  final Function(String, String?) onProjectChanged;

  const DaySectionWidget({
    super.key,
    required this.date,
    required this.assignments,
    required this.projects,
    required this.employees,
    required this.isExpanded,
    required this.onTap,
    required this.taskControllers,
    required this.descriptionControllers,
    required this.expectedControllers,
    required this.actualControllers,
    required this.selectedProjects,
    required this.onRemove,
    required this.onStateChange,
    required this.onProjectChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final totalHrs = assignments.fold(0.0, (sum, a) => sum + (double.tryParse(actualControllers[a.name ?? a.hashCode.toString()]?.text ?? "") ?? a.spentHours));

    return Container(
      margin: const EdgeInsets.only(bottom: AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.of(context).slate50,
        borderRadius: BorderRadius.circular(AppConstants.r8),
        border: Border.all(color: AppColors.of(context).slate200),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: onTap,
            leading: Icon(Icons.calendar_today_outlined, size: AppConstants.iconMedium, color: AppColors.of(context).onSurface),
            title: Text(
              DateTimeUtils.formatDateString(date, pattern: DateTimeUtils.dateWithDay),
              style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.bold, color: AppColors.of(context).onSurface),
            ),
            subtitle: Text(l10n.submittedOn(date), style: AppTextStyle.bodySmall.copyWith(color: AppColors.of(context).onSurfaceVariant)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppConstants.p12, vertical: AppConstants.p4),
                  decoration: BoxDecoration(
                    color: AppColors.of(context).infoBg,
                    borderRadius: BorderRadius.circular(AppConstants.r20),
                  ),
                  child: Text(l10n.totalHrs(totalHrs.toInt()), style: AppTextStyle.bodySmall.copyWith(fontWeight: FontWeight.bold, color: AppColors.of(context).info)),
                ),
                const SizedBox(width: AppConstants.p12),
                Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: AppColors.of(context).onSurfaceVariant),
              ],
            ),
          ),
          if (isExpanded) ...[
            Divider(height: 1, color: AppColors.of(context).border),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(AppConstants.p12),
                child: DataTable(
                  columnSpacing: AppConstants.p24,
                  headingRowHeight: AppConstants.p40,
                  horizontalMargin: 0,
                  columns: [
                    DataColumn(label: Text(l10n.slNo, style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text(l10n.project, style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text(l10n.task, style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text(l10n.description, style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text(l10n.expectedTime, style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text(l10n.actualTime, style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text(l10n.status, style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text(l10n.raisedBy, style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.bold))),
                  ],
                  rows: assignments.asMap().entries.map((entry) {
                    final idx = entry.key + 1;
                    final a = entry.value;
                    final key = a.name ?? a.hashCode.toString();
                    return DataRow(cells: [
                      DataCell(Text(idx.toString())),
                      DataCell(_buildTableDropdown(context,key, projects, selectedProjects[key], onProjectChanged)),
                      DataCell(_buildTableTextField(context,taskControllers[key]!, onStateChange)),
                      DataCell(_buildTableTextField(context,descriptionControllers[key]!, onStateChange, width: 180)),
                      DataCell(_buildTableTextField(context,expectedControllers[key]!, onStateChange, width: 70, suffix: l10n.hoursUnit)),
                      DataCell(_buildTableTextField(context,actualControllers[key]!, onStateChange, width: 70, suffix: l10n.hoursUnit)),
                      DataCell(TimesheetStatusBadge(status: a.status ?? TimesheetStatus.pending)),
                      DataCell(Text(_getEmployeeName(a.raisedBy, employees), style: AppTextStyle.bodySmall.copyWith(fontSize: AppConstants.fs13))),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getEmployeeName(String? employeeId, List<Map<String, dynamic>> employees) {
    if (employeeId == null) return AppConstants.placeholderText;
    final emp = employees.firstWhere((e) => e['name'] == employeeId, orElse: () => {});
    return emp['employee_name'] ?? employeeId;
  }

  Widget _buildTableDropdown(BuildContext context,String key, List<ProjectEntity> projects, String? selectedProject, Function(String, String?) onChanged) {
    return Container(
      width: 140,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: selectedProject,
        isExpanded: true,
        dropdownColor: AppColors.of(context).surfaceContainerHighest,
        style: AppTextStyle.bodySmall.copyWith(color: AppColors.of(context).textPrimary),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: AppConstants.p10, vertical: AppConstants.p12),
          fillColor: AppColors.of(context).surfaceContainerLowest,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppConstants.r8), borderSide: BorderSide(color: AppColors.of(context).border)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppConstants.r8), borderSide: BorderSide(color: AppColors.of(context).border)),
        ),
        items: projects.map((p) => DropdownMenuItem(value: p.name, child: Text(p.projectName, style: AppTextStyle.bodySmall.copyWith(color: AppColors.of(context).textPrimary), overflow: TextOverflow.ellipsis))).toList(),
        onChanged: (val) => onChanged(key, val),
      ),
    );
  }

  Widget _buildTableTextField(BuildContext context,TextEditingController controller, VoidCallback onStateChange, {double width = 120, String? suffix}) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        style: AppTextStyle.bodySmall.copyWith(fontSize: AppConstants.fs13, color: AppColors.of(context).textPrimary),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: AppConstants.p12, vertical: AppConstants.p12),
          fillColor: AppColors.of(context).surfaceContainerLowest,
          filled: true,
          suffixText: suffix,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppConstants.r8), borderSide: BorderSide(color: AppColors.of(context).border)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppConstants.r8), borderSide: BorderSide(color: AppColors.of(context).border)),
        ),
        onChanged: (_) => onStateChange(),
      ),
    );
  }
}
