import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_bloc.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_event.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/domain/entities/timesheet_approval_entity.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/timesheet_filter_box.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_entity.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/constants/app_constants.dart';
import '../../../../timesheetapproval/presentation/widgets/timesheet_summary_card.dart';
import 'edit_timesheet_header.dart';
import 'edit_timesheet_breakdown_header.dart';
import 'edit_timesheet_day_section.dart';
import 'edit_timesheet_footer.dart';

class EditTimesheetForm extends StatefulWidget {
  final TimesheetApprovalEntity timesheet;
  final List<ProjectEntity> projects;
  final List<Map<String, dynamic>> employees;

  const EditTimesheetForm({
    super.key,
    required this.timesheet,
    required this.projects,
    required this.employees,
  });

  @override
  State<EditTimesheetForm> createState() => _EditTimesheetFormState();
}

class _EditTimesheetFormState extends State<EditTimesheetForm> {
  final Map<String, TextEditingController> _taskControllers = {};
  final Map<String, TextEditingController> _descriptionControllers = {};
  final Map<String, TextEditingController> _expectedControllers = {};
  final Map<String, TextEditingController> _actualControllers = {};
  final Map<String, String?> _selectedProjects = {};
  
  String? _filterProject;
  String? _filterStatus;
  
  bool _isAllExpanded = true;
  final Set<String> _expandedDates = {};
  
  List<ProjectAssignmentApprovalEntity>? _localAssignments;

  @override
  void initState() {
    super.initState();
    _initializeLocalData();
  }

  @override
  void dispose() {
    for (final c in _taskControllers.values) {
      c.dispose();
    }
    for (final c in _descriptionControllers.values) {
      c.dispose();
    }
    for (final c in _expectedControllers.values) {
      c.dispose();
    }
    for (final c in _actualControllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  void _initializeLocalData() {
    if (_localAssignments != null) return;
    _localAssignments = List.from(widget.timesheet.projectAssignments ?? []);
    for (final a in _localAssignments!) {
      final key = a.name ?? a.hashCode.toString();
      _taskControllers[key] = TextEditingController(text: a.hoursDetails ?? "");
      _descriptionControllers[key] = TextEditingController(text: a.description ?? "");
      _expectedControllers[key] = TextEditingController(text: a.expectedHours.toString());
      _actualControllers[key] = TextEditingController(text: a.spentHours.toString());
      _selectedProjects[key] = a.project;
      if (a.date != null) _expandedDates.add(a.date!);
    }
  }

  void _removeAssignment(ProjectAssignmentApprovalEntity a) {
    setState(() {
      _localAssignments?.remove(a);
      final key = a.name ?? a.hashCode.toString();
      _taskControllers.remove(key);
      _descriptionControllers.remove(key);
      _expectedControllers.remove(key);
      _actualControllers.remove(key);
      _selectedProjects.remove(key);
    });
  }

  void _onUpdate() {
    if (_localAssignments == null) return;

    final updatedAssignments = _localAssignments!.map((a) {
      final key = a.name ?? a.hashCode.toString();
      return a.copyWith(
        hoursDetails: _taskControllers[key]?.text,
        description: _descriptionControllers[key]?.text,
        expectedHours: double.tryParse(_expectedControllers[key]?.text ?? "") ?? a.expectedHours,
        spentHours: double.tryParse(_actualControllers[key]?.text ?? "") ?? a.spentHours,
        project: _selectedProjects[key] ?? a.project,
        taskData: _taskControllers[key]?.text,
      );
    }).toList();

    context.read<ApprovalsBloc>().add(ApprovalsEvent.syncTimesheetRequested(
          timesheet: widget.timesheet,
          assignments: updatedAssignments,
        ));
    Navigator.pop(context);
  }

  List<ProjectAssignmentApprovalEntity> _getFilteredAssignments() {
    if (_localAssignments == null) return [];
    return _localAssignments!.where((a) {
      if (_filterProject != null && a.project != _filterProject) return false;
      if (_filterStatus != null && a.status != _filterStatus) return false;
      return true;
    }).toList();
  }

  String _getEmployeeName(String? employeeId, List<Map<String, dynamic>> employees) {
    if (employeeId == null) return "—";
    final emp = employees.firstWhere((e) => e['name'] == employeeId, orElse: () => {});
    return emp['employee_name'] ?? employeeId;
  }

  @override
  Widget build(BuildContext context) {
    Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final filteredAssignments = _getFilteredAssignments();
    final Map<String, List<ProjectAssignmentApprovalEntity>> grouped = {};
    for (final a in filteredAssignments) {
      if (a.date != null) {
        grouped.putIfAbsent(a.date!, () => []).add(a);
      }
    }
    final sortedDates = grouped.keys.toList()..sort();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EditTimesheetHeader(onClose: () => Navigator.pop(context)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TimesheetSummaryCard(timesheet: widget.timesheet),
                      const SizedBox(height: 20),
                      EditTimesheetBreakdownHeader(
                        onExpandAll: () {
                          setState(() {
                            _isAllExpanded = true;
                            for (final a in _localAssignments ?? []) {
                              if (a.date != null) _expandedDates.add(a.date!);
                            }
                          });
                        },
                        onCollapseAll: () {
                          setState(() {
                            _isAllExpanded = false;
                            _expandedDates.clear();
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      _buildFilters(l10n),
                      const SizedBox(height: 16),
                      if (sortedDates.isEmpty)
                        _buildEmptyState(l10n)
                      else
                        ...sortedDates.map((date) => EditTimesheetDaySection(
                              date: date,
                              assignments: grouped[date]!,
                              projects: widget.projects,
                              employees: widget.employees,
                              isExpanded: _expandedDates.contains(date),
                              onToggle: () => setState(() {
                                if (_expandedDates.contains(date)) {
                                  _expandedDates.remove(date);
                                } else {
                                  _expandedDates.add(date);
                                }
                              }),
                              taskControllers: _taskControllers,
                              descriptionControllers: _descriptionControllers,
                              expectedControllers: _expectedControllers,
                              actualControllers: _actualControllers,
                              selectedProjects: _selectedProjects,
                              onProjectChanged: (key, val) => setState(() => _selectedProjects[key] = val),
                              onRemove: _removeAssignment,
                              getEmployeeName: _getEmployeeName,
                            )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        EditTimesheetFooter(
          selectedCount: 0, // Logic for row selection can be added here if needed
          totalCount: _localAssignments?.length ?? 0,
          onUpdate: _onUpdate,
          onCancel: () => Navigator.pop(context),
        ),
      ],
    );
  }

  Widget _buildFilters(AppLocalizations l10n) {
    return Row(
      children: [
        Expanded(
          child: TimesheetFilterBox(
            label: l10n.allProjects,
            current: _filterProject,
            options: widget.projects.map((p) => p.name).toList(),
            onSelect: (val) => setState(() => _filterProject = val == TimesheetFilterBox.allValue ? null : val),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TimesheetFilterBox(
            label: l10n.allStatus,
            current: _filterStatus,
            optionsWithLabels: {
              TimesheetStatus.pending: l10n.pending,
              TimesheetStatus.approved: l10n.approved,
              TimesheetStatus.rejected: l10n.rejected,
            },
            onSelect: (val) => setState(() => _filterStatus = val == TimesheetFilterBox.allValue ? null : val),
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.info_outline, size: 48, color: AppColors.textSecondary),
            SizedBox(height: 16),
            Text(
              l10n.noTimesheetEntriesFound,
              style: AppTextStyle.bodyMedium.copyWith(color: AppColors.textSecondary),
            ),
          ],
        ),
      ),
    );
  }
}
