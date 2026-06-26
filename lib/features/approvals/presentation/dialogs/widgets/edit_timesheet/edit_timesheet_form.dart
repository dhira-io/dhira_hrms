import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/domain/entities/timesheet_approval_entity.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_entity.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../core/constants/app_constants.dart';
import '../../../../timesheetapproval/domain/usecases/sync_timesheet_week_wise_usecase.dart';
import '../../../../../timesheet/domain/usecases/delete_timesheet_entry_usecase.dart';
import '../../../../timesheetapproval/presentation/widgets/timesheet_summary_card.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/features/approvals/data/constants/approvals_api_constants.dart';
import 'edit_timesheet_header.dart';
import 'edit_timesheet_day_section.dart';

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
      _descriptionControllers[key] = TextEditingController(
        text: a.description ?? "",
      );
      _expectedControllers[key] = TextEditingController(
        text: a.expectedHours.toString(),
      );
      _actualControllers[key] = TextEditingController(
        text: a.spentHours.toString(),
      );
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

  List<ProjectAssignmentApprovalEntity> _getFilteredAssignments() {
    if (_localAssignments == null) return [];
    return _localAssignments!.where((a) {
      if (_filterProject != null && a.project != _filterProject) return false;
      if (_filterStatus != null && a.status != _filterStatus) return false;
      return true;
    }).toList();
  }

  String _getEmployeeName(
    String? employeeId,
    List<Map<String, dynamic>> employees,
  ) {
    if (employeeId == null) return "—";
    final emp = employees.firstWhere(
      (e) => e['name'] == employeeId,
      orElse: () => {},
    );
    return emp['employee_name'] ?? employeeId;
  }

  String _formatDateRange(String? start, String? end) {
    if (start == null || end == null) return "$start - $end";
    try {
      final s = DateTime.parse(start);
      final e = DateTime.parse(end);
      final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      return "${months[s.month - 1]} ${s.day}, ${s.year} - ${months[e.month - 1]} ${e.day}, ${e.year}";
    } catch (_) {
      return "$start - $end";
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);
    final filteredAssignments = _getFilteredAssignments();
    final Map<String, List<ProjectAssignmentApprovalEntity>> grouped = {};
    for (final a in filteredAssignments) {
      if (a.date != null) {
        grouped.putIfAbsent(a.date!, () => []).add(a);
      }
    }
    final sortedDates = grouped.keys.toList()..sort();
    final dateRange = _formatDateRange(widget.timesheet.fromDate, widget.timesheet.toDate);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                EditTimesheetHeader(onClose: () => Navigator.pop(context), dateRange: dateRange),
                Divider(height: 1, thickness: 1, color: colors.slate400),
                SizedBox(height: 8.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TimesheetSummaryCard(timesheet: widget.timesheet),
                      SizedBox(height: 24.h),
                      Text(
                        l10n.dailyLog,
                        style: AppTextStyle.bodyLarge.copyWith(
                          color: colors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      if (sortedDates.isEmpty)
                        _EmptyState(l10n: l10n)
                      else
                        ...sortedDates.map(
                          (date) => EditTimesheetDaySection(
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
                            onProjectChanged: (key, val) =>
                                setState(() => _selectedProjects[key] = val),
                            onRemove: _removeAssignment,
                            getEmployeeName: _getEmployeeName,
                            onTaskSave: (key, proj, task, exp, act, desc) async {
                              if (_localAssignments == null) return;
                              
                              final dateKey = DateTimeUtils.formatDateString(date);
                              final weekRange = '${DateTimeUtils.formatDateString(widget.timesheet.fromDate)} - ${DateTimeUtils.formatDateString(widget.timesheet.toDate)}';
                              
                              final existingA = _localAssignments!.firstWhere(
                                (a) => (a.name ?? a.hashCode.toString()) == key,
                              );
                              
                              final payload = {
                                TimesheetApiKeys.changes: {
                                  weekRange: {
                                    dateKey: [
                                      {
                                        TimesheetApiKeys.name: existingA.name,
                                        TimesheetApiKeys.date: existingA.date,
                                        TimesheetApiKeys.project: proj,
                                        TimesheetApiKeys.taskData: task,
                                        TimesheetApiKeys.description: desc,
                                        TimesheetApiKeys.expectedHours: double.tryParse(exp) ?? 0,
                                        TimesheetApiKeys.spentHours: double.tryParse(act) ?? 0,
                                        TimesheetApiKeys.status: existingA.status ?? TimesheetStatus.pending,
                                      }
                                    ]
                                  }
                                }
                              };
                              
                              final usecase = Get.find<SyncTimesheetWeekWiseUseCase>();
                              final result = await usecase.call(payload);
                              
                              return result.fold(
                                (l) {
                                  ToastUtils.showError(l.message);
                                  throw Exception(l.message);
                                },
                                (r) {
                                  if (r) {
                                    setState(() {
                                      _selectedProjects[key] = proj;
                                      _taskControllers[key]?.text = task;
                                      _expectedControllers[key]?.text = exp;
                                      _actualControllers[key]?.text = act;
                                      _descriptionControllers[key]?.text = desc;
                                      final index = _localAssignments!.indexOf(existingA);
                                      if (index != -1) {
                                        _localAssignments![index] = existingA.copyWith(
                                          project: proj,
                                          taskData: task,
                                          description: desc,
                                          expectedHours: double.tryParse(exp) ?? 0,
                                          spentHours: double.tryParse(act) ?? 0,
                                        );
                                      }
                                    });
                                    ToastUtils.showSuccess(ApprovalsApiConstants.msgTimesheetUpdated);
                                  } else {
                                    ToastUtils.showError(ApprovalsApiConstants.msgTimesheetUpdateFailed);
                                    throw Exception(ApprovalsApiConstants.msgTimesheetUpdateFailed);
                                  }
                                }
                              );
                            },
                            onTaskDelete: (key) async {
                              if (_localAssignments == null) return;
                              
                              final existingA = _localAssignments!.firstWhere(
                                (a) => (a.name ?? a.hashCode.toString()) == key,
                              );
                              
                              final usecase = Get.find<DeleteTimesheetEntryUseCase>();
                              final result = await usecase.call(
                                DeleteTimesheetEntryParams(
                                  name: existingA.name ?? "",
                                  parent: widget.timesheet.name,
                                  date: existingA.date ?? "",
                                ),
                              );
                              
                              result.fold(
                                (failure) {
                                  ToastUtils.showError(failure.message);
                                },
                                (success) {
                                  setState(() {
                                    _localAssignments!.remove(existingA);
                                    _taskControllers.remove(key);
                                    _descriptionControllers.remove(key);
                                    _expectedControllers.remove(key);
                                    _actualControllers.remove(key);
                                    _selectedProjects.remove(key);
                                  });
                                  ToastUtils.showSuccess(l10n.taskDeletedSuccess);
                                },
                              );
                            },
                          ),
                        ),
                      SizedBox(height: 8.h), // Bottom padding
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  final AppLocalizations l10n;

  const _EmptyState({required this.l10n});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 40.h),
      child: Center(
        child: Column(
          children: [
            Icon(
              Icons.info_outline,
              size: 48,
              color: colors.textSecondary,
            ),
            SizedBox(height: 16.h),
            Text(
              l10n.noTimesheetEntriesFound,
              style: AppTextStyle.bodyMedium.copyWith(
                color: colors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
