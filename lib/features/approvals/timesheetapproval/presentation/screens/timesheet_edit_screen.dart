import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/features/approvals/data/constants/approvals_api_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_bloc.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_event.dart';
import 'package:dhira_hrms/features/approvals/presentation/bloc/approvals_state.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/domain/entities/timesheet_approval_entity.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/timesheet_filter_box.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_entity.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/timesheet_summary_card.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/timesheet_edit_header.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/timesheet_edit_footer.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/day_section_widget.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/timesheet_skeleton.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/empty_timesheet_state.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/timesheet_section_title_row.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/presentation/widgets/timesheet_filter_section.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';

class TimesheetEditScreen extends StatefulWidget {
  final String requestId;

  const TimesheetEditScreen({super.key, required this.requestId});

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
    context.read<ApprovalsBloc>().add(
      ApprovalsEvent.editTimesheetRequested(requestId: widget.requestId),
    );
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

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return BlocListener<ApprovalsBloc, ApprovalsState>(
      listener: (context, state) {
        if (state.status == ApprovalsStatus.success && state.data != null) {
          final data = state.data!;
            if (data.successMessage != null) {
              ToastUtils.showSuccess(data.successMessage!);
              if (data.successMessage == ApprovalsApiConstants.msgTimesheetUpdated) {
                Navigator.pop(context);
              }
            }
            if (data.errorMessage != null) {
              ToastUtils.showError(data.errorMessage!);
            }
          
        } else if (state.status == ApprovalsStatus.failure && state.errorMessage != null) {
          ToastUtils.showError(state.errorMessage!);
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.of(context).slate500.withValues(alpha: 0.5),
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            height: MediaQuery.of(context).size.height * 0.9,
            decoration: BoxDecoration(
              color: AppColors.of(context).white,
              borderRadius: BorderRadius.circular(AppConstants.r16),
            ),
            child: BlocSelector<ApprovalsBloc, ApprovalsState, bool>(
              selector: (state) => (state.status == ApprovalsStatus.success && state.data != null) ? state.data!.isTimesheetLoading : true,
              builder: (context, isLoading) {
                if (isLoading) return const TimesheetSkeleton();

                return BlocSelector<
                  ApprovalsBloc,
                  ApprovalsState,
                  TimesheetApprovalEntity?
                >(
                  selector: (state) => (state.status == ApprovalsStatus.success && state.data != null) ? state.data!.editingTimesheet : null,
                  builder: (context, timesheet) {
                    if (timesheet == null) {
                      final error = context.select<ApprovalsBloc, String?>(
                        (bloc) => (bloc.state.status == ApprovalsStatus.success && bloc.state.data != null) ? bloc.state.data!.errorMessage : null,
                      );
                      return _buildErrorState(error, l10n);
                    }

                    _initializeLocalData(timesheet);

                    final projects = context
                        .select<ApprovalsBloc, List<ProjectEntity>>(
                          (bloc) => (bloc.state.status == ApprovalsStatus.success && bloc.state.data != null) ? bloc.state.data!.projects : [],
                        );
                    final employees = context
                        .select<ApprovalsBloc, List<Map<String, dynamic>>>(
                          (bloc) => (bloc.state.status == ApprovalsStatus.success && bloc.state.data != null) ? bloc.state.data!.employees : [],
                        );

                    final filteredAssignments = _getFilteredAssignments();
                    final Map<String, List<ProjectAssignmentApprovalEntity>>
                    grouped = {};
                    for (final a in filteredAssignments) {
                      if (a.date != null) {
                        grouped.putIfAbsent(a.date!, () => []).add(a);
                      }
                    }
                    final sortedDates = grouped.keys.toList()..sort();

                    return Column(
                      children: [
                        TimesheetEditHeader(
                          onClose: () => Navigator.pop(context),
                        ),
                        Expanded(
                          child: CustomScrollView(
                            slivers: [
                              SliverToBoxAdapter(
                                child: Padding(
                                  padding:       EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TimesheetSummaryCard(
                                        timesheet: timesheet,
                                      ),
                                      const SizedBox(height: AppConstants.p24),
                                      TimesheetSectionTitleRow(
                                        onExpandAll: () {
                                          setState(() {
                                            if (_localAssignments != null) {
                                              for (final a
                                                  in _localAssignments!) {
                                                if (a.date != null)
                                                  _expandedDates.add(a.date!);
                                              }
                                            }
                                          });
                                        },
                                        onCollapseAll: () => setState(
                                          () => _expandedDates.clear(),
                                        ),
                                      ),
                                      SizedBox(height: 16.h),
                                      TimesheetFilterSection(
                                        projects: projects,
                                        employees: employees,
                                        filterProject: _filterProject,
                                        filterEmployee: _filterEmployee,
                                        filterStatus: _filterStatus,
                                        onProjectChanged: (val) => setState(
                                          () => _filterProject =
                                              val == TimesheetFilterBox.allValue
                                              ? null
                                              : val,
                                        ),
                                        onEmployeeChanged: (val) => setState(
                                          () => _filterEmployee =
                                              val == TimesheetFilterBox.allValue
                                              ? null
                                              : val,
                                        ),
                                        onStatusChanged: (val) => setState(
                                          () => _filterStatus =
                                              val == TimesheetFilterBox.allValue
                                              ? null
                                              : val,
                                        ),
                                      ),
                                      SizedBox(height: 16.h),
                                    ],
                                  ),
                                ),
                              ),
                              if (sortedDates.isEmpty)
                                const SliverToBoxAdapter(
                                  child: EmptyTimesheetState(),
                                )
                              else
                                SliverPadding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 20.w,
                                  ),
                                  sliver: SliverList(
                                    delegate: SliverChildBuilderDelegate((
                                      context,
                                      index,
                                    ) {
                                      final date = sortedDates[index];
                                      return DaySectionWidget(
                                        date: date,
                                        assignments: grouped[date]!,
                                        projects: projects,
                                        employees: employees,
                                        isExpanded: _expandedDates.contains(
                                          date,
                                        ),
                                        onTap: () => setState(() {
                                          _expandedDates.contains(date)
                                              ? _expandedDates.remove(date)
                                              : _expandedDates.add(date);
                                        }),
                                        taskControllers: _taskControllers,
                                        descriptionControllers:
                                            _descriptionControllers,
                                        expectedControllers:
                                            _expectedControllers,
                                        actualControllers: _actualControllers,
                                        selectedProjects: _selectedProjects,
                                        onRemove: _removeAssignment,
                                        onStateChange: () => setState(() {}),
                                        onProjectChanged: (key, val) =>
                                            setState(
                                              () =>
                                                  _selectedProjects[key] = val,
                                            ),
                                      );
                                    }, childCount: sortedDates.length),
                                  ),
                                ),
                              SliverToBoxAdapter(
                                child: const SizedBox(height: AppConstants.p20),
                              ),
                            ],
                          ),
                        ),
                        BlocSelector<ApprovalsBloc, ApprovalsState, bool>(
                          selector: (state) => (state.status == ApprovalsStatus.success && state.data != null) ? state.data!.processingIds.contains(timesheet.name) : false,
                          builder: (context, isProcessing) {
                            return TimesheetEditFooter(
                              selectedCount: _localAssignments?.length ?? 0,
                              onCancel: () => Navigator.pop(context),
                              onUpdate: () => _onUpdate(context, timesheet),
                              isLoading: isProcessing,
                            );
                          },
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
          Icon(
            Icons.error_outline,
            size: AppConstants.iconXLarge,
            color: AppColors.of(context).error,
          ),
          SizedBox(height: 16.h),
          Text(error ?? l10n.failedToLoadTimesheet),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.close),
          ),
        ],
      ),
    );
  }

  List<ProjectAssignmentApprovalEntity> _getFilteredAssignments() {
    if (_localAssignments == null) return [];
    return _localAssignments!.where((a) {
      if (_filterProject != null && a.project != _filterProject) return false;
      if (_filterEmployee != null && a.raisedBy != _filterEmployee)
        return false;
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
        expectedHours:
            double.tryParse(_expectedControllers[key]?.text ?? "") ??
            a.expectedHours,
        spentHours:
            double.tryParse(_actualControllers[key]?.text ?? "") ??
            a.spentHours,
        project: _selectedProjects[key] ?? a.project,
        taskData: _taskControllers[key]?.text,
      );
    }).toList();

    context.read<ApprovalsBloc>().add(
      ApprovalsEvent.syncTimesheetRequested(
        timesheet: timesheet,
        assignments: updatedAssignments,
      ),
    );
  }
}
