import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/timesheet_filter_box.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_entity.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class TimesheetFilterSection extends StatelessWidget {
  final List<ProjectEntity> projects;
  final List<Map<String, dynamic>> employees;
  final String? filterProject;
  final String? filterEmployee;
  final String? filterStatus;
  final ValueChanged<String?> onProjectChanged;
  final ValueChanged<String?> onEmployeeChanged;
  final ValueChanged<String?> onStatusChanged;

  const TimesheetFilterSection({
    super.key,
    required this.projects,
    required this.employees,
    this.filterProject,
    this.filterEmployee,
    this.filterStatus,
    required this.onProjectChanged,
    required this.onEmployeeChanged,
    required this.onStatusChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: TimesheetFilterBox(
            label: l10n.allProjects,
            current: filterProject,
            options: projects.map((p) => p.name).toList(),
            onSelect: onProjectChanged,
          ),
        ),
        const SizedBox(width: AppConstants.p8),
        Expanded(
          child: TimesheetFilterBox(
            label: l10n.raisedBy,
            current: filterEmployee,
            options: employees.map((e) => e['name'] as String).toList(),
            onSelect: onEmployeeChanged,
          ),
        ),
        const SizedBox(width: AppConstants.p8),
        Expanded(
          child: TimesheetFilterBox(
            label: l10n.allStatus,
            current: filterStatus,
            options: [l10n.pending, l10n.approved, l10n.rejected],
            onSelect: onStatusChanged,
          ),
        ),
      ],
    );
  }
}
