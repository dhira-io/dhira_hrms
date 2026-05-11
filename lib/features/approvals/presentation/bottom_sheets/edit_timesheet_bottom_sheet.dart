import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_bloc.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_event.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_state.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/domain/entities/timesheet_approval_entity.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/timesheet_summary_card.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/small_action_btn.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/timesheet_filter_box.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/timesheet_status_badge.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_entity.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditTimesheetBottomSheet extends StatefulWidget {
  const EditTimesheetBottomSheet({super.key});

  @override
  State<EditTimesheetBottomSheet> createState() => _EditTimesheetBottomSheetState();
}

class _EditTimesheetBottomSheetState extends State<EditTimesheetBottomSheet> {
  final Map<String, TextEditingController> _taskControllers = {};
  final Map<String, TextEditingController> _descriptionControllers = {};
  final Map<String, TextEditingController> _expectedControllers = {};
  final Map<String, TextEditingController> _actualControllers = {};
  final Map<String, String?> _selectedProjects = {};
  
  String? _filterProject;
  String? _filterEmployee;
  String? _filterStatus;
  
  bool _isAllExpanded = true;
  final Set<String> _expandedDates = {};
  
  List<ProjectAssignmentApprovalEntity>? _localAssignments;

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

  void _initializeLocalData(TimesheetApprovalEntity timesheet) {
    if (_localAssignments != null) return;
    _localAssignments = List.from(timesheet.projectAssignments ?? []);
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return BlocBuilder<ApprovalsBloc, ApprovalsState>(
      builder: (context, state) {
        return state.maybeMap(
          success: (s) {
            if (s.data.isTimesheetLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            
            final timesheet = s.data.editingTimesheet;
            
            if (timesheet == null) {
              return Container(
                padding: const EdgeInsets.all(40),
                decoration: const BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (s.data.isTimesheetLoading)
                      const CircularProgressIndicator()
                    else ...[
                      const Icon(Icons.error_outline, size: 48, color: AppColors.error),
                      const SizedBox(height: 16),
                      Text(s.data.errorMessage ?? "Failed to load timesheet details", textAlign: TextAlign.center),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          ),
                          child: const Text("Close", style: TextStyle(color: AppColors.white)),
                        ),
                      ),
                    ],
                  ],
                ),
              );
            }

            _initializeLocalData(timesheet);

            final filteredAssignments = _getFilteredAssignments();
            final Map<String, List<ProjectAssignmentApprovalEntity>> grouped = {};
            for (final a in filteredAssignments) {
              if (a.date != null) {
                grouped.putIfAbsent(a.date!, () => []).add(a);
              }
            }
            final sortedDates = grouped.keys.toList()..sort();

            return Container(
              decoration: const BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Container(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height * 0.9,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildHeader(context, timesheet),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TimesheetSummaryCard(timesheet: timesheet),
                                  const SizedBox(height: 20),
                                  _buildBreakdownHeader(l10n),
                                  const SizedBox(height: 16),
                                  _buildFilters(s.data.projects, s.data.employees),
                                  const SizedBox(height: 16),
                                  if (sortedDates.isEmpty)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 40),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            const Icon(Icons.info_outline, size: 48, color: AppColors.textSecondary),
                                            const SizedBox(height: 16),
                                            Text("No timesheet entries found", style: AppTextStyle.bodyMedium.copyWith(color: AppColors.textSecondary)),
                                          ],
                                        ),
                                      ),
                                    )
                                  else
                                    ...sortedDates.map((date) => _buildDaySection(context, date, grouped[date]!, s.data.projects, s.data.employees)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    _buildFooter(context, timesheet),
                  ],
                ),
              ),
            );
          },
          orElse: () => const Center(child: Text("Invalid state for edit")),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context, TimesheetApprovalEntity timesheet) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Request Details", style: AppTextStyle.h3.copyWith(fontSize: 18), overflow: TextOverflow.ellipsis),
                Text("Timesheet Request Details", style: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary), overflow: TextOverflow.ellipsis),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }


  Widget _buildBreakdownHeader(AppLocalizations l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "Daily Timesheet Breakdown",
            style: AppTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.bold),
            maxLines: 2,
            softWrap: true,
          ),
        ),
        const SizedBox(width: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SmallActionBtn(
              icon: Icons.unfold_more,
              label: l10n.expandAll,
              onTap: () {
                setState(() {
                  _isAllExpanded = true;
                  if (_localAssignments != null) {
                    for (final a in _localAssignments!) {
                      if (a.date != null) _expandedDates.add(a.date!);
                    }
                  }
                });
              },
            ),
            const SizedBox(width: 8),
            SmallActionBtn(
              icon: Icons.unfold_less,
              label: l10n.collapseAll,
              onTap: () {
                setState(() {
                  _isAllExpanded = false;
                  _expandedDates.clear();
                });
              },
            ),
          ],
        ),
      ],
    );
  }


  String _getEmployeeName(String? employeeId, List<Map<String, dynamic>> employees) {
    if (employeeId == null) return "—";
    final emp = employees.firstWhere((e) => e['name'] == employeeId, orElse: () => {});
    return emp['employee_name'] ?? employeeId;
  }

  Widget _buildFilters(List<ProjectEntity> projects, List<Map<String, dynamic>> employees) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: TimesheetFilterBox(
            label: l10n.allProjects,
            current: _filterProject,
            options: projects.map((p) => p.name).toList(),
            onSelect: (val) => setState(() => _filterProject = val),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TimesheetFilterBox(
            label: l10n.allStatus,
            current: _filterStatus,
            options: [l10n.pending, l10n.approved, l10n.rejected],
            onSelect: (val) => setState(() => _filterStatus = val),
          ),
        ),
      ],
    );
  }


  Widget _buildDaySection(BuildContext context, String date, List<ProjectAssignmentApprovalEntity> assignments, List<ProjectEntity> projects, List<Map<String, dynamic>> employees) {
    final isExpanded = _expandedDates.contains(date);
    final totalHrs = assignments.fold(0.0, (sum, a) => sum + (double.tryParse(_actualControllers[a.name ?? a.hashCode.toString()]?.text ?? "") ?? a.spentHours));

    final l10n = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () => setState(() => isExpanded ? _expandedDates.remove(date) : _expandedDates.add(date)),
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
                  Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: AppColors.textSecondary),
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
                columns: const [
                  DataColumn(label: Text("Sl. no")),
                  DataColumn(label: Text("Project")),
                  DataColumn(label: Text("Task")),
                  DataColumn(label: Text("Description")),
                  DataColumn(label: Text("Expected Time")),
                  DataColumn(label: Text("Actual Time")),
                  DataColumn(label: Text("Status")),
                  DataColumn(label: Text("Raised By")),
                  DataColumn(label: Text("")),
                ],
                rows: assignments.asMap().entries.map((entry) {
                  final idx = entry.key + 1;
                  final a = entry.value;
                  final key = a.name ?? a.hashCode.toString();
                  return DataRow(cells: [
                    DataCell(Text(idx.toString())),
                    DataCell(_buildTableDropdown(key, projects, a.project)),
                    DataCell(_buildTableTextField(_taskControllers[key]!)),
                    DataCell(_buildTableTextField(_descriptionControllers[key]!, width: 180, isLarge: true)),
                    DataCell(_buildTableTextField(_expectedControllers[key]!, width: 60, suffix: "h")),
                    DataCell(_buildTableTextField(_actualControllers[key]!, width: 60, suffix: "h")),
                    DataCell(TimesheetStatusBadge(status: a.status ?? "Pending")),
                    DataCell(Text(_getEmployeeName(a.raisedBy, employees), style: AppTextStyle.bodySmall)),
                    DataCell(IconButton(
                      icon: const Icon(Icons.delete_outline, color: AppColors.error, size: 20),
                      onPressed: () => _removeAssignment(a),
                    )),
                  ]);
                }).toList(),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTableDropdown(String key, List<ProjectEntity> projects, String? currentProject) {
    return SizedBox(
      width: 150,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedProjects[key],
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
          onChanged: (val) => setState(() => _selectedProjects[key] = val),
        ),
      ),
    );
  }

  Widget _buildTableTextField(TextEditingController controller, {double width = 120, bool isLarge = false, String? suffix}) {
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
        onChanged: (_) => setState(() {}),
      ),
    );
  }


  Widget _buildFooter(BuildContext context, TimesheetApprovalEntity timesheet) {
    final l10n = AppLocalizations.of(context)!;
    final btnShape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(8));
    const btnSize = Size(100, 44);

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(
                l10n.rowsSelected(0, _localAssignments?.length ?? 0),
                style: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _onUpdate(context, timesheet),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: btnSize,
                shape: btnShape,
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                elevation: 0,
              ),
              child: Text(l10n.update, style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                minimumSize: btnSize,
                shape: btnShape,
                side: const BorderSide(color: AppColors.primary),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              ),
              child: Text(l10n.cancel, style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }

  List<ProjectAssignmentApprovalEntity> _getFilteredAssignments() {
    if (_localAssignments == null) return [];
    return _localAssignments!.where((a) {
      if (_filterProject != null && a.project != _filterProject) return false;
      if (_filterEmployee != null && a.raisedBy != _filterEmployee) return false;
      if (_filterStatus != null && a.status != _filterStatus) return false;
      return true;
    }).toList();
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

  void _onUpdate(BuildContext context, TimesheetApprovalEntity timesheet) {
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
          timesheet: timesheet,
          assignments: updatedAssignments,
        ));
    Navigator.pop(context);
  }
}
