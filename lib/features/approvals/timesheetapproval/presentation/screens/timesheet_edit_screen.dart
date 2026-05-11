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
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/timesheet_summary_card.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/small_action_btn.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/timesheet_filter_box.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/timesheet_status_badge.dart';
import 'package:dhira_hrms/core/widgets/shimmer_loading.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';

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

    return BlocListener<ApprovalsBloc, ApprovalsState>(
      listener: (context, state) {
        state.maybeWhen(
          success: (data) {
            if (data.successMessage != null) {
              ToastUtils.showSuccess(data.successMessage!);
            }
            if (data.errorMessage != null) {
              ToastUtils.showError(data.errorMessage!);
            }
          },
          failure: (message) => ToastUtils.showError(message),
          orElse: () {},
        );
      },
      child: Scaffold(
        backgroundColor: AppColors.slate500.withValues(alpha: 0.5),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.9,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: BlocSelector<ApprovalsBloc, ApprovalsState, bool>(
              selector: (state) => state.maybeMap(
                success: (s) => s.data.isTimesheetLoading,
                orElse: () => true,
              ),
              builder: (context, isLoading) {
                if (isLoading) return const _TimesheetSkeleton();

                return BlocSelector<ApprovalsBloc, ApprovalsState, TimesheetApprovalEntity?>(
                  selector: (state) => state.maybeMap(
                    success: (s) => s.data.editingTimesheet,
                    orElse: () => null,
                  ),
                  builder: (context, timesheet) {
                    if (timesheet == null) {
                      final error = context.select<ApprovalsBloc, String?>((bloc) => bloc.state.maybeMap(
                            success: (s) => s.data.errorMessage,
                            orElse: () => null,
                          ));
                      return _buildErrorState(error, l10n);
                    }

                    _initializeLocalData(timesheet);

                    final projects = context.select<ApprovalsBloc, List<ProjectEntity>>((bloc) => bloc.state.maybeMap(
                          success: (s) => s.data.projects,
                          orElse: () => [],
                        ));
                    final employees = context.select<ApprovalsBloc, List<Map<String, dynamic>>>((bloc) => bloc.state.maybeMap(
                          success: (s) => s.data.employees,
                          orElse: () => [],
                        ));

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
                        TimesheetEditHeader(onClose: () => Navigator.pop(context)),
                        Expanded(
                          child: CustomScrollView(
                            slivers: [
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      TimesheetSummaryCard(timesheet: timesheet),
                                      const SizedBox(height: 24),
                                      _SectionTitleRow(
                                        onExpandAll: () {
                                          setState(() {
                                            if (_localAssignments != null) {
                                              for (final a in _localAssignments!) {
                                                if (a.date != null) _expandedDates.add(a.date!);
                                              }
                                            }
                                          });
                                        },
                                        onCollapseAll: () => setState(() => _expandedDates.clear()),
                                      ),
                                      const SizedBox(height: 16),
                                      _TimesheetFilterSection(
                                        projects: projects,
                                        employees: employees,
                                        filterProject: _filterProject,
                                        filterEmployee: _filterEmployee,
                                        filterStatus: _filterStatus,
                                        onProjectChanged: (val) => setState(() => _filterProject = val),
                                        onEmployeeChanged: (val) => setState(() => _filterEmployee = val),
                                        onStatusChanged: (val) => setState(() => _filterStatus = val),
                                      ),
                                      const SizedBox(height: 16),
                                    ],
                                  ),
                                ),
                              ),
                              if (sortedDates.isEmpty)
                                const SliverToBoxAdapter(child: EmptyTimesheetState())
                              else
                                SliverPadding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  sliver: SliverList(
                                    delegate: SliverChildBuilderDelegate(
                                      (context, index) {
                                        final date = sortedDates[index];
                                        return _DaySectionWidget(
                                          date: date,
                                          assignments: grouped[date]!,
                                          projects: projects,
                                          employees: employees,
                                          isExpanded: _expandedDates.contains(date),
                                          onTap: () => setState(() {
                                            _expandedDates.contains(date) ? _expandedDates.remove(date) : _expandedDates.add(date);
                                          }),
                                          taskControllers: _taskControllers,
                                          descriptionControllers: _descriptionControllers,
                                          expectedControllers: _expectedControllers,
                                          actualControllers: _actualControllers,
                                          selectedProjects: _selectedProjects,
                                          onRemove: _removeAssignment,
                                          onStateChange: () => setState(() {}),
                                          onProjectChanged: (key, val) => setState(() => _selectedProjects[key] = val),
                                        );
                                      },
                                      childCount: sortedDates.length,
                                    ),
                                  ),
                                ),
                              const SliverToBoxAdapter(child: SizedBox(height: 20)),
                            ],
                          ),
                        ),
                        TimesheetEditFooter(
                          selectedCount: _localAssignments?.length ?? 0,
                          onCancel: () => Navigator.pop(context),
                          onUpdate: () => _onUpdate(context, timesheet),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ),
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

class TimesheetEditHeader extends StatelessWidget {
  final VoidCallback onClose;

  const TimesheetEditHeader({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.requestDetails, style: AppTextStyle.h2Bold.copyWith(color: AppColors.slate800)),
                Text(l10n.timesheetRequestDetails, style: AppTextStyle.bodySmall.copyWith(color: AppColors.slate500)),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.slate800),
            onPressed: onClose,
          ),
        ],
      ),
    );
  }
}

class _SectionTitleRow extends StatelessWidget {
  final VoidCallback onExpandAll;
  final VoidCallback onCollapseAll;

  const _SectionTitleRow({required this.onExpandAll, required this.onCollapseAll});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(l10n.dailyTimesheet, style: AppTextStyle.h2Bold.copyWith(color: AppColors.slate800)),
        Row(
          children: [
            SmallActionBtn(
              icon: Icons.unfold_more,
              label: l10n.expandAll,
              onTap: onExpandAll,
            ),
            const SizedBox(width: 8),
            SmallActionBtn(
              icon: Icons.unfold_less,
              label: l10n.collapseAll,
              onTap: onCollapseAll,
            ),
          ],
        ),
      ],
    );
  }
}

class _TimesheetFilterSection extends StatelessWidget {
  final List<ProjectEntity> projects;
  final List<Map<String, dynamic>> employees;
  final String? filterProject;
  final String? filterEmployee;
  final String? filterStatus;
  final ValueChanged<String?> onProjectChanged;
  final ValueChanged<String?> onEmployeeChanged;
  final ValueChanged<String?> onStatusChanged;

  const _TimesheetFilterSection({
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
        const SizedBox(width: 8),
        Expanded(
          child: TimesheetFilterBox(
            label: l10n.raisedBy,
            current: filterEmployee,
            options: employees.map((e) => e['name'] as String).toList(),
            onSelect: onEmployeeChanged,
          ),
        ),
        const SizedBox(width: 8),
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

class TimesheetEditFooter extends StatelessWidget {
  final int selectedCount;
  final VoidCallback onCancel;
  final VoidCallback onUpdate;

  const TimesheetEditFooter({
    super.key,
    required this.selectedCount,
    required this.onCancel,
    required this.onUpdate,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.slate200)),
      ),
      child: Row(
        children: [
          Text(l10n.selectedRows(selectedCount), style: AppTextStyle.bodySmall.copyWith(color: AppColors.slate500)),
          const Spacer(),
          OutlinedButton(
            onPressed: onCancel,
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
            onPressed: onUpdate,
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
}

class _DaySectionWidget extends StatelessWidget {
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

  const _DaySectionWidget({
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
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.slate50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.slate200),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: onTap,
            leading: const Icon(Icons.calendar_today_outlined, size: 24, color: AppColors.slate800),
            title: Text(
              DateTimeUtils.formatDateString(date, pattern: AppFormats.dateWithDay),
              style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.bold, color: AppColors.slate800),
            ),
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
                      DataCell(_buildTableDropdown(key, projects, selectedProjects[key], onProjectChanged)),
                      DataCell(_buildTableTextField(taskControllers[key]!, onStateChange)),
                      DataCell(_buildTableTextField(descriptionControllers[key]!, onStateChange, width: 180)),
                      DataCell(_buildTableTextField(expectedControllers[key]!, onStateChange, width: 70, suffix: "h")),
                      DataCell(_buildTableTextField(actualControllers[key]!, onStateChange, width: 70, suffix: "h")),
                      DataCell(TimesheetStatusBadge(status: a.status ?? "Pending")),
                      DataCell(Text(_getEmployeeName(a.raisedBy, employees), style: const TextStyle(fontSize: 13))),
                      DataCell(IconButton(
                        icon: const Icon(Icons.delete_outline, color: AppColors.error, size: 20),
                        onPressed: () => onRemove(a),
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

  String _getEmployeeName(String? employeeId, List<Map<String, dynamic>> employees) {
    if (employeeId == null) return "—";
    final emp = employees.firstWhere((e) => e['name'] == employeeId, orElse: () => {});
    return emp['employee_name'] ?? employeeId;
  }

  Widget _buildTableDropdown(String key, List<ProjectEntity> projects, String? selectedProject, Function(String, String?) onChanged) {
    return Container(
      width: 140,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<String>(
        value: selectedProject,
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
        onChanged: (val) => onChanged(key, val),
      ),
    );
  }

  Widget _buildTableTextField(TextEditingController controller, VoidCallback onStateChange, {double width = 120, String? suffix}) {
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
        onChanged: (_) => onStateChange(),
      ),
    );
  }
}

class _TimesheetSkeleton extends StatelessWidget {
  const _TimesheetSkeleton();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ShimmerLoading(height: 60, width: double.infinity),
          const SizedBox(height: 24),
          const ShimmerLoading(height: 120, width: double.infinity),
          const SizedBox(height: 24),
          Row(
            children: const [
              Expanded(child: ShimmerLoading(height: 40, width: 100)),
              SizedBox(width: 12),
              Expanded(child: ShimmerLoading(height: 40, width: 100)),
              SizedBox(width: 12),
              Expanded(child: ShimmerLoading(height: 40, width: 100)),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (_, __) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: const ShimmerLoading(height: 80, width: double.infinity),
              ),
            ),
          ),
        ],
      ),
    );
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
