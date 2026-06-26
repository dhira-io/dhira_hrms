import 'package:dhira_hrms/features/approvals/presentation/bottom_sheets/edit_timesheet_task_bottom_sheet.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/domain/entities/project_assignment_approval_entity.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/timesheet_status_badge.dart';
import 'package:dhira_hrms/core/widgets/common_confirmation_bottom_sheet.dart';
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
  final Future<void> Function(String, String, String, String, String, String) onTaskSave;
  final Future<void> Function(String) onTaskDelete;
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
    required this.onTaskSave,
    required this.onTaskDelete,
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
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        border: Border.all(color: colors.slateBorder),
        borderRadius: BorderRadius.circular(12.r),
        color: isExpanded ? colors.slate50 : colors.surfaceContainerLowest,
      ),
      child: Column(
        children: [
          // Header Card
          InkWell(
            onTap: onToggle,
            borderRadius: BorderRadius.circular(12.r),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(10.w),
                    decoration: BoxDecoration(
                      color: colors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Icon(
                      Icons.calendar_today_outlined,
                      size: 20,
                      color: colors.primary,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          DateTimeUtils.formatDateString(
                            date,
                            pattern: DateTimeUtils.dateWithDayMonth,
                          ),
                          style: AppTextStyle.bodyLarge.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colors.textPrimary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          "${l10n.tasksCount(assignments.length)} • ${totalHrs.toInt()}h ${l10n.logged}",
                          style: AppTextStyle.bodySmall.copyWith(
                            color: colors.textSecondary,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
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
          
          if (isExpanded)
            Divider(height: 1, thickness: 1, color: colors.slateBorder),
          
          // Expanded Task List
          if (isExpanded)
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                children: assignments.map((a) {
                  final key = a.name ?? a.hashCode.toString();
                  final currentProject = selectedProjects[key] ?? a.project;
                  final projectName = projects.firstWhere(
                    (p) => p.name == currentProject,
                    orElse: () => ProjectEntity(name: currentProject, projectName: currentProject),
                  ).projectName;

                  return Container(
                    margin: EdgeInsets.only(bottom: 8.h),
                    decoration: BoxDecoration(
                      border: Border.all(color: colors.slateBorder),
                      borderRadius: BorderRadius.circular(12.r),
                      color: colors.surfaceContainerLowest,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  projectName,
                                  style: AppTextStyle.titleMedium.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: colors.textPrimary,
                                  ),
                                ),
                              ),
                              TimesheetStatusBadge(status: a.status ?? l10n.pending),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            taskControllers[key]?.text ?? "",
                            style: AppTextStyle.bodyMedium.copyWith(
                              color: colors.textSecondary,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.access_time, size: 16, color: colors.textSecondary),
                                  SizedBox(width: 4.w),
                                  Text(
                                    "${actualControllers[key]?.text ?? 0}h ${l10n.logged}",
                                    style: AppTextStyle.bodySmall.copyWith(
                                      color: colors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                                Row(
                                  children: [
                                    IconButton(
                                      constraints: const BoxConstraints(),
                                      padding: EdgeInsets.zero,
                                      icon: Icon(Icons.edit_outlined, size: 20, color: colors.textSecondary),
                                      onPressed: () {
                                        showModalBottomSheet(
                                          context: context,
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          builder: (ctx) => EditTimesheetTaskBottomSheet(
                                            date: date,
                                            initialProject: selectedProjects[key] ?? "",
                                            initialTask: taskControllers[key]?.text ?? "",
                                            initialExpected: expectedControllers[key]?.text ?? "",
                                            initialActual: actualControllers[key]?.text ?? "",
                                            initialDescription: descriptionControllers[key]?.text ?? "",
                                            projects: projects,
                                            onSave: (proj, task, exp, act, desc) async {
                                              await onTaskSave(key, proj, task, exp, act, desc);
                                            },
                                          ),
                                        );
                                      },
                                    ),
                                    if (a.status != TimesheetStatus.approved) ...[
                                      SizedBox(width: 8.w),
                                      IconButton(
                                        constraints: const BoxConstraints(),
                                        padding: EdgeInsets.zero,
                                        icon: Icon(Icons.delete_outline, size: 20, color: colors.colorRed600),
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            builder: (ctx) => CommonConfirmationBottomSheet(
                                              title: l10n.confirmDeletion,
                                              subtitle: l10n.deleteTaskConfirmationSubtitle,
                                              icon: Icon(Icons.delete_outline, color: colors.colorRed600),
                                              iconBackgroundColor: colors.colorRed50,
                                              confirmButtonColor: colors.colorRed600,
                                              confirmAction: ConfirmationAction(
                                                label: l10n.yes,
                                                onTap: () {
                                                  Navigator.pop(ctx);
                                                  onTaskDelete(key);
                                                },
                                              ),
                                              cancelAction: ConfirmationAction(
                                                label: l10n.no,
                                                onTap: () => Navigator.pop(ctx),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ],
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
