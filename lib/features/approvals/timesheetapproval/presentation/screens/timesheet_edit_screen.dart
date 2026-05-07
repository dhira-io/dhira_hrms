import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_bloc.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_event.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_state.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/domain/entities/timesheet_approval_entity.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_entity.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/timesheet_summary_card.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/small_action_btn.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/timesheet_filter_box.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/timesheet_status_badge.dart';

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
          backgroundColor: AppColors.slate500.withValues(alpha: 0.5), // Semi-transparent background to look like dialog
          body: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.height * 0.9,
              decoration: BoxDecoration(
                color: AppColors.white,
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
                                const EmptyTimesheetState()
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
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.requestDetails, style: AppTextStyle.headlineSmall.copyWith(fontWeight: FontWeight.bold, color: AppColors.slate800)),
              Text(l10n.timesheetRequestDetails, style: AppTextStyle.bodySmall.copyWith(color: AppColors.slate500)),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.slate800),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitleRow() {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(l10n.dailyTimesheet, style: AppTextStyle.headlineSmall.copyWith(fontWeight: FontWeight.bold, color: AppColors.slate800)),
        Row(
          children: [
            SmallActionBtn(
              icon: Icons.unfold_more,
              label: l10n.expandAll,
              onTap: () {
                setState(() {
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
                  _expandedDates.clear();
                });
              },
            ),
          ],
        ),
      ],
    );
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
            label: l10n.raisedBy,
            current: _filterEmployee,
            options: employees.map((e) => e['name'] as String).toList(),
            onSelect: (val) => setState(() => _filterEmployee = val),
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
    final l10n = AppLocalizations.of(context)!;
    final isExpanded = _expandedDates.contains(date);
    final totalHrs = assignments.fold(0.0, (sum, a) => sum + (double.tryParse(_actualControllers[a.name ?? a.hashCode.toString()]?.text ?? "") ?? a.spentHours));

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.slate50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.slate200),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () => setState(() => isExpanded ? _expandedDates.remove(date) : _expandedDates.add(date)),
            leading: const Icon(Icons.calendar_today_outlined, size: 24, color: AppColors.slate800),
            title: Text(_formatDateLong(date), style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.bold, color: AppColors.slate800)),
            subtitle: Text(l10n.submittedOn(date), style: AppTextStyle.bodySmall.copyWith(color: AppColors.slate500)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.infoBg,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(l10n.totalHrs(totalHrs.toInt()), style: AppTextStyle.bodySmall.copyWith(fontWeight: FontWeight.bold, color: AppColors.info)),
                ),
                const SizedBox(width: 12),
                Icon(isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down, color: AppColors.slate500),
              ],
            ),
          ),
          if (isExpanded) ...[
            const Divider(height: 1, color: AppColors.slate200),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: DataTable(
                  columnSpacing: 24,
                  headingRowHeight: 40,
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
                    const DataColumn(label: Text("")),
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
                      DataCell(TimesheetStatusBadge(status: a.status ?? "Pending")),
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
          fillColor: AppColors.white,
          filled: true,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.slate200)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.slate200)),
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
          fillColor: AppColors.white,
          filled: true,
          suffixText: suffix,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.slate200)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.slate200)),
        ),
        onChanged: (_) => setState(() {}),
      ),
    );
  }


  Widget _buildFooter(BuildContext context, TimesheetApprovalEntity timesheet, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: const BoxDecoration(
        border: Border(top: BorderSide(color: AppColors.slate200)),
      ),
      child: Row(
        children: [
          Text(l10n.selectedRows(_localAssignments?.length ?? 0), style: AppTextStyle.bodySmall.copyWith(color: AppColors.slate500)),
          const Spacer(),
          OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              side: const BorderSide(color: AppColors.slate200),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              backgroundColor: AppColors.slate100,
            ),
            child: Text(l10n.cancel, style: AppTextStyle.bodyMedium.copyWith(color: AppColors.slate800, fontWeight: FontWeight.w600)),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            onPressed: () => _onUpdate(context, timesheet),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 0,
            ),
            child: Text(l10n.update, style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.bold, color: AppColors.white)),
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
          Text(error ?? l10n.failedToLoadTimesheet),
          const SizedBox(height: 24),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: Text(l10n.close)),
        ],
      ),
    );
  }


  String _formatDateLong(String dateStr) {
    return DateTimeUtils.formatDateString(dateStr, pattern: AppFormats.dateWithDay);
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

class EmptyTimesheetState extends StatelessWidget {
  const EmptyTimesheetState({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.description_outlined, size: 48, color: AppColors.slate300),
            const SizedBox(height: 16),
            Text(l10n.noTimesheetEntriesFound, style: AppTextStyle.bodyMedium.copyWith(color: AppColors.slate500)),
          ],
        ),
      ),
    );
  }
}
