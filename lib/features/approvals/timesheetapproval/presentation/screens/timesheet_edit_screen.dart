import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_bloc.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_event.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_state.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/domain/entities/timesheet_approval_entity.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_entity.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../widgets/timesheet_summary_card.dart';

class TimesheetEditScreen extends StatefulWidget {
  final String requestId;

  const TimesheetEditScreen({
    super.key,
    required this.requestId,
  });

  @override
  State<TimesheetEditScreen> createState() => _TimesheetEditScreenState();
}

class _TimesheetEditScreenState extends State<TimesheetEditScreen> {
  final Map<String, TextEditingController> _taskControllers = {};
  final Map<String, TextEditingController> _descriptionControllers = {};
  final Map<String, TextEditingController> _expectedControllers = {};
  final Map<String, TextEditingController> _actualControllers = {};
  final Map<String, String?> _selectedProjects = {};
  
  String? _filterProject;
  String? _filterEmployee;
  String? _filterStatus;
  
  final Set<String> _expandedDates = {};
  List<ProjectAssignmentApprovalEntity>? _localAssignments;

  @override
  void initState() {
    super.initState();
    context.read<ApprovalsBloc>().add(ApprovalsEvent.editTimesheetRequested(requestId: widget.requestId));
  }

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
        return Scaffold(
          backgroundColor: const Color(0xFF64748B).withValues(alpha: 0.5), // Semi-transparent background to look like dialog
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.9,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: state.maybeMap(
                success: (s) {
                  if (s.isTimesheetLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  
                  final timesheet = s.editingTimesheet;
                  
                  if (timesheet == null) {
                    return _buildErrorState(s.errorMessage, l10n);
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

                  return Column(
                    children: [
                      _buildHeader(context),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TimesheetSummaryCard(timesheet: timesheet),
                              const SizedBox(height: 24),
                              _buildSectionTitleRow(),
                              const SizedBox(height: 16),
                              _buildFilters(s.projects, s.employees),
                              const SizedBox(height: 16),
                              if (sortedDates.isEmpty)
                                _buildEmptyState()
                              else
                                ...sortedDates.map((date) => _buildDaySection(context, date, grouped[date]!, s.projects, s.employees)),
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      ),
                      _buildFooter(context, timesheet, l10n),
                    ],
                  );
                },
                orElse: () => const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Request Details", style: AppTextStyle.headlineSmall.copyWith(fontWeight: FontWeight.bold, color: const Color(0xFF1E293B))),
              const Text("Timesheet Request Details", style: TextStyle(color: Color(0xFF64748B), fontSize: 13)),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Color(0xFF1E293B)),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text("Daily Timesheet", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF1E293B))),
        Row(
          children: [
            _buildActionBtn(Icons.unfold_more, "Expand All", () {
              setState(() {
                if (_localAssignments != null) {
                  for (final a in _localAssignments!) {
                    if (a.date != null) _expandedDates.add(a.date!);
                  }
                }
              });
            }),
            const SizedBox(width: 8),
            _buildActionBtn(Icons.unfold_less, "Collapse All", () {
              setState(() {
                _expandedDates.clear();
              });
            }),
          ],
        ),
      ],
    );
  }

  Widget _buildActionBtn(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 14, color: const Color(0xFF64748B)),
            const SizedBox(width: 6),
            Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Color(0xFF64748B))),
          ],
        ),
      ),
    );
  }

  Widget _buildFilters(List<ProjectEntity> projects, List<Map<String, dynamic>> employees) {
    return Row(
      children: [
        Expanded(child: _buildFilterBox("All Projects", _filterProject, projects.map((p) => p.name).toList(), (val) => setState(() => _filterProject = val))),
        const SizedBox(width: 8),
        Expanded(child: _buildFilterBox("Raised by", _filterEmployee, employees.map((e) => e['name'] as String).toList(), (val) => setState(() => _filterEmployee = val))),
        const SizedBox(width: 8),
        Expanded(child: _buildFilterBox("All Status", _filterStatus, ["Pending", "Approved", "Rejected"], (val) => setState(() => _filterStatus = val))),
      ],
    );
  }

  Widget _buildFilterBox(String label, String? current, List<String> options, ValueChanged<String?> onSelect) {
    return PopupMenuButton<String?>(
      onSelected: onSelect,
      itemBuilder: (context) => [
        const PopupMenuItem(value: null, child: Text("All")),
        ...options.map((o) => PopupMenuItem(value: o, child: Text(o))),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(current ?? label, style: const TextStyle(fontSize: 13, color: Color(0xFF1E293B)), overflow: TextOverflow.ellipsis)),
            const Icon(Icons.keyboard_arrow_down, size: 18, color: Color(0xFF64748B)),
          ],
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
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () => setState(() => isExpanded ? _expandedDates.remove(date) : _expandedDates.add(date)),
            leading: const Icon(Icons.calendar_today_outlined, size: 24, color: Color(0xFF1E293B)),
            title: Text(_formatDateLong(date), style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1E293B))),
            subtitle: Text("Submitted on $date", style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE0F2FE),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text("Total ${totalHrs.toInt()}hrs", style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF0284C7))),
                ),
                const SizedBox(width: 12),
                Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: const Color(0xFF64748B)),
              ],
            ),
          ),
          if (isExpanded) ...[
            const Divider(height: 1, color: Color(0xFFE2E8F0)),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: DataTable(
                  columnSpacing: 24,
                  headingRowHeight: 40,
                  horizontalMargin: 0,
                  columns: const [
                    DataColumn(label: Text("Sl. no", style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text("Project", style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text("Task", style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text("Description", style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text("Expected Time", style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text("Actual Time", style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text("Status", style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(label: Text("Raised By", style: TextStyle(fontWeight: FontWeight.bold))),
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
                      DataCell(_buildTableTextField(_descriptionControllers[key]!, width: 180)),
                      DataCell(_buildTableTextField(_expectedControllers[key]!, width: 70, suffix: "h")),
                      DataCell(_buildTableTextField(_actualControllers[key]!, width: 70, suffix: "h")),
                      DataCell(_buildStatusBadge(a.status ?? "Pending")),
                      DataCell(Text(_getEmployeeName(a.raisedBy, employees), style: const TextStyle(fontSize: 13))),
                      DataCell(IconButton(
                        icon: const Icon(Icons.delete_outline, color: AppColors.error, size: 20),
                        onPressed: () => _removeAssignment(a),
                      )),
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

  Widget _buildTableDropdown(String key, List<ProjectEntity> projects, String? currentProject) {
    return Container(
      width: 140,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: _selectedProjects[key],
        isExpanded: true,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
        ),
        items: projects.map((p) => DropdownMenuItem(value: p.name, child: Text(p.projectName, style: const TextStyle(fontSize: 12), overflow: TextOverflow.ellipsis))).toList(),
        onChanged: (val) => setState(() => _selectedProjects[key] = val),
      ),
    );
  }

  Widget _buildTableTextField(TextEditingController controller, {double width = 120, String? suffix}) {
    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontSize: 13),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          fillColor: Colors.white,
          filled: true,
          suffixText: suffix,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: Color(0xFFE2E8F0))),
        ),
        onChanged: (_) => setState(() {}),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    final isPending = status.toLowerCase() == "pending";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isPending ? const Color(0xFFFEF9C3) : const Color(0xFFDCFCE7),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(status, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: isPending ? const Color(0xFF854D0E) : const Color(0xFF166534))),
    );
  }

  Widget _buildFooter(BuildContext context, TimesheetApprovalEntity timesheet, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      child: Row(
        children: [
          Text("0 of ${_localAssignments?.length ?? 0} row(s) selected", style: const TextStyle(fontSize: 13, color: Color(0xFF64748B))),
          const Spacer(),
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              side: const BorderSide(color: Color(0xFFE2E8F0)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              backgroundColor: const Color(0xFFF1F5F9),
            ),
            child: const Text("Cancel", style: TextStyle(color: Color(0xFF1E293B), fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () => _onUpdate(context, timesheet),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              backgroundColor: const Color(0xFF1D4ED8),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 0,
            ),
            child: const Text("Update", style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String? error, AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: AppColors.error),
          const SizedBox(height: 16),
          Text(error ?? "Failed to load timesheet details"),
          const SizedBox(height: 24),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: Text(l10n.close)),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 60),
      child: Center(
        child: Column(
          children: [
            Icon(Icons.description_outlined, size: 48, color: Color(0xFFCBD5E1)),
            SizedBox(height: 16),
            Text("No timesheet entries found", style: TextStyle(color: Color(0xFF64748B))),
          ],
        ),
      ),
    );
  }

  String _formatDateLong(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      return DateFormat('EEEE, dd-MM-yyyy').format(date);
    } catch (_) {
      return dateStr;
    }
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

  String _getEmployeeName(String? employeeId, List<Map<String, dynamic>> employees) {
    if (employeeId == null) return "—";
    final emp = employees.firstWhere((e) => e['name'] == employeeId, orElse: () => {});
    return emp['employee_name'] ?? employeeId;
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
      final dateStr = a.date ?? "";
      final dateKey = _toDDMMYYYY(dateStr);
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
    final payload = {"changes": {weekRange: innerDetails}};
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
