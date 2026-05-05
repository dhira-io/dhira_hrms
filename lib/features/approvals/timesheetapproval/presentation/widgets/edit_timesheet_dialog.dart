import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_bloc.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_event.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_state.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/domain/entities/timesheet_approval_entity.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/timesheet_summary_card.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_entity.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class EditTimesheetDialog extends StatefulWidget {
  const EditTimesheetDialog({super.key});

  @override
  State<EditTimesheetDialog> createState() => _EditTimesheetDialogState();
}

class _EditTimesheetDialogState extends State<EditTimesheetDialog> {
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
    for (final c in _taskControllers.values) c.dispose();
    for (final c in _descriptionControllers.values) c.dispose();
    for (final c in _expectedControllers.values) c.dispose();
    for (final c in _actualControllers.values) c.dispose();
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
            if (s.isTimesheetLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            
            final timesheet = s.editingTimesheet;
            
            if (timesheet == null) {
              return Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(40),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (s.isTimesheetLoading)
                        const CircularProgressIndicator()
                      else ...[
                        const Icon(Icons.error_outline, size: 48, color: AppColors.error),
                        const SizedBox(height: 16),
                        Text(s.errorMessage ?? "Failed to load timesheet details", textAlign: TextAlign.center),
                        const SizedBox(height: 24),
                        ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("Close")),
                      ],
                    ],
                  ),
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

            return Dialog(
              insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.9),
                child: Column(
                  children: [
                    _buildHeader(context, timesheet),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: TimesheetSummaryCard(timesheet: timesheet),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildBreakdownHeader(l10n),
                            const SizedBox(height: 16),
                            _buildFilters(s.projects, s.employees),
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
                              ...sortedDates.map((date) => _buildDaySection(context, date, grouped[date]!, s.projects, s.employees)),
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
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Request Details", style: AppTextStyle.h3.copyWith(fontSize: 18)),
              Text("Timesheet Request Details", style: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary)),
            ],
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
            _buildSmallActionBtn(Icons.unfold_more, "Expand All", () {
              setState(() {
                _isAllExpanded = true;
                if (_localAssignments != null) {
                  for (final a in _localAssignments!) {
                    if (a.date != null) _expandedDates.add(a.date!);
                  }
                }
              });
            }),
            const SizedBox(width: 8),
            _buildSmallActionBtn(Icons.unfold_less, "Collapse All", () {
              setState(() {
                _isAllExpanded = false;
                _expandedDates.clear();
              });
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildSmallActionBtn(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: AppColors.textSecondary),
            const SizedBox(width: 4),
            Text(label, style: AppTextStyle.labelSmall.copyWith(color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  String _getEmployeeName(String? employeeId, List<Map<String, dynamic>> employees) {
    if (employeeId == null) return "—";
    final emp = employees.firstWhere((e) => e['name'] == employeeId, orElse: () => {});
    return emp['employee_name'] ?? employeeId;
  }

  Widget _buildFilters(List<ProjectEntity> projects, List<Map<String, dynamic>> employees) {
    return Row(
      children: [
        Expanded(
          child: _buildFilterDropdown(
            "All Projects",
            _filterProject,
            projects.map((p) => DropdownMenuItem(value: p.name, child: Text(p.projectName, style: AppTextStyle.bodySmall))).toList(),
            (val) => setState(() => _filterProject = val),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildFilterDropdown(
            "Raised by",
            _filterEmployee,
            employees.map((e) => DropdownMenuItem(value: e['name'] as String, child: Text(e['employee_name'] as String, style: AppTextStyle.bodySmall))).toList(),
            (val) => setState(() => _filterEmployee = val),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildFilterDropdown(
            "All Status",
            _filterStatus,
            ["Pending", "Approved", "Rejected"].map((s) => DropdownMenuItem(value: s, child: Text(s, style: AppTextStyle.bodySmall))).toList(),
            (val) => setState(() => _filterStatus = val),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterDropdown(String hint, String? value, List<DropdownMenuItem<String>> items, ValueChanged<String?> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          hint: Text(hint, style: AppTextStyle.bodySmall),
          isExpanded: true,
          icon: const Icon(Icons.keyboard_arrow_down, size: 18),
          items: [
            DropdownMenuItem<String>(value: null, child: Text(hint, style: AppTextStyle.bodySmall)),
            ...items,
          ],
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildDaySection(BuildContext context, String date, List<ProjectAssignmentApprovalEntity> assignments, List<ProjectEntity> projects, List<Map<String, dynamic>> employees) {
    final isExpanded = _expandedDates.contains(date);
    final totalHrs = assignments.fold(0.0, (sum, a) => sum + (double.tryParse(_actualControllers[a.name ?? a.hashCode.toString()]?.text ?? "") ?? a.spentHours));

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
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(_formatDate(date), style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                      Text("Submitted on ${assignments.first.date}", style: AppTextStyle.labelSmall.copyWith(color: AppColors.textSecondary)),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.infoBg,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text("Total ${totalHrs.toInt()}hrs", style: AppTextStyle.labelSmall.copyWith(color: AppColors.info, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 12),
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
                    DataCell(_buildStatusBadge(a.status ?? "Pending")),
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
        child: DropdownButtonFormField<String>(
          value: _selectedProjects[key],
          isExpanded: true,
          decoration: const InputDecoration(
            isDense: true,
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          ),
          items: projects.map((p) => DropdownMenuItem(value: p.name, child: Text(p.projectName, style: AppTextStyle.bodySmall, overflow: TextOverflow.ellipsis))).toList(),
          onChanged: (val) => setState(() => _selectedProjects[key] = val),
        ),
      ),
    );
  }

  Widget _buildTableTextField(TextEditingController controller, {double width = 120, bool isLarge = false, String? suffix}) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        style: AppTextStyle.bodySmall,
        maxLines: isLarge ? 2 : 1,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          suffixText: suffix,
        ),
        onChanged: (_) => setState(() {}), // Trigger total recalculation
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final isPending = status.toLowerCase() == "pending";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isPending ? AppColors.warningBg : AppColors.successBg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(status, style: AppTextStyle.labelSmall.copyWith(color: isPending ? AppColors.warning : AppColors.success, fontWeight: FontWeight.bold)),
    );
  }

  Widget _buildFooter(BuildContext context, TimesheetApprovalEntity timesheet) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.border)),
      ),
      child: Row(
        children: [
          Text("0 of ${_localAssignments?.length ?? 0} row(s) selected", style: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary)),
          const Spacer(),
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(minimumSize: const Size(100, 48)),
            child: const Text("Cancel"),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () => _onUpdate(context, timesheet),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, minimumSize: const Size(100, 48)),
            child: const Text("Update", style: TextStyle(color: AppColors.white)),
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

  String _formatDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('EEEE, dd-MM-yyyy').format(date);
    } catch (_) {
      return dateStr;
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

  void _onUpdate(BuildContext context, TimesheetApprovalEntity timesheet) {
    if (_localAssignments == null) return;
    
    final Map<String, List<Map<String, dynamic>>> innerDetails = {};

    for (final a in _localAssignments!) {
      final key = a.name ?? a.hashCode.toString();
      final dateStr = a.date ?? ""; // e.g., "2026-03-08"
      final dateKey = _toDDMMYYYY(dateStr); // "08-03-2026"
      
      final spent = double.tryParse(_actualControllers[key]?.text ?? "") ?? a.spentHours;
      final expected = double.tryParse(_expectedControllers[key]?.text ?? "") ?? a.expectedHours;

      final entry = {
        "name": a.name,
        "date": dateStr,
        "project": _selectedProjects[key],
        "task_data": _taskControllers[key]?.text,
        "description": _descriptionControllers[key]?.text,
        "expected_hours": expected,
        "spent_hours": spent,
        "status": a.status ?? "Pending",
      };
      
      if (dateKey.isNotEmpty) {
        innerDetails.putIfAbsent(dateKey, () => []).add(entry);
      }
    }

    final String weekRange = "${_toDDMMYYYY(timesheet.fromDate ?? '')} - ${_toDDMMYYYY(timesheet.toDate ?? '')}";

    final payload = {
      "changes": {
        weekRange: innerDetails
      }
    };

    context.read<ApprovalsBloc>().add(ApprovalsEvent.updateTimesheetRequested(payload: payload));
    Navigator.pop(context);
  }

  String _toDDMMYYYY(String dateStr) {
    if (dateStr.isEmpty) return "";
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('dd-MM-yyyy').format(date);
    } catch (_) {
      return dateStr;
    }
  }
}
