import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../domain/entities/timesheet_entities.dart';
import '../bloc/timesheet_bloc.dart';
import '../bloc/timesheet_event.dart';
import '../bloc/timesheet_state.dart';
import 'timesheet_header_info.dart';
import 'timesheet_date_selectors.dart';
import 'timesheet_assignment_list.dart';
import 'timesheet_summary_section.dart';
import 'timesheet_assignment_dialog.dart';

class TimesheetApplyForm extends StatefulWidget {
  final String timesheetId;

  const TimesheetApplyForm({
    super.key,
    required this.timesheetId,
  });

  @override
  State<TimesheetApplyForm> createState() => _TimesheetApplyFormState();
}

class _TimesheetApplyFormState extends State<TimesheetApplyForm> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      context.read<TimesheetBloc>().add(const TimesheetEvent.userInitRequested());
      if (widget.timesheetId != "0") {
        context.read<TimesheetBloc>().add(TimesheetEvent.fetchDetailsRequested(widget.timesheetId));
      }
    });
  }

  void _addOrEditAssignment(List<ProjectAssignmentEntity> currentAssignments, DateTime? fromDate, DateTime? toDate, String? userName) {
    if (fromDate == null || toDate == null) return;
    
    final state = context.read<TimesheetBloc>().state;
    final projects = state.projects;

    showDialog(
      context: context,
      builder: (context) => TimesheetAssignmentDialog(
        projects: projects,
        initialDate: fromDate,
        minDate: fromDate,
        maxDate: toDate,
        raisedBy: userName ?? "—",
        onSave: (assignment) {
          final newAssignments = List<ProjectAssignmentEntity>.from(currentAssignments)..add(assignment);
          context.read<TimesheetBloc>().add(TimesheetEvent.assignmentsChanged(newAssignments));
        },
      ),
    );
  }

  void _editAssignment(List<ProjectAssignmentEntity> currentAssignments, int index, ProjectAssignmentEntity existing, DateTime? fromDate, DateTime? toDate, String? userName) {
    if (fromDate == null || toDate == null) return;
    
    final state = context.read<TimesheetBloc>().state;
    final projects = state.projects;

    showDialog(
      context: context,
      builder: (context) => TimesheetAssignmentDialog(
        projects: projects,
        existing: existing,
        initialDate: fromDate,
        minDate: fromDate,
        maxDate: toDate,
        raisedBy: userName ?? "—",
        onSave: (assignment) {
          final newAssignments = List<ProjectAssignmentEntity>.from(currentAssignments)..[index] = assignment;
          context.read<TimesheetBloc>().add(TimesheetEvent.assignmentsChanged(newAssignments));
        },
      ),
    );
  }

  void _deleteAssignment(List<ProjectAssignmentEntity> currentAssignments, int index) {
    final newAssignments = List<ProjectAssignmentEntity>.from(currentAssignments)..removeAt(index);
    context.read<TimesheetBloc>().add(TimesheetEvent.assignmentsChanged(newAssignments));
  }

  Future<void> _selectDate(BuildContext context, bool isFrom, DateTime? current) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: current ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (!context.mounted) return;
    if (picked != null && picked != current) {
      if (isFrom) {
        context.read<TimesheetBloc>().add(TimesheetEvent.fromDateChanged(picked));
      } else {
        context.read<TimesheetBloc>().add(TimesheetEvent.toDateChanged(picked));
      }
    }
  }

  void _submit(String? employeeId, String? department, String? approver, DateTime? fromDate, DateTime? toDate, List<ProjectAssignmentEntity> assignments) {
    final l10n = AppLocalizations.of(context)!;
    if (assignments.isEmpty) {
      ToastUtils.showError(l10n.addAtLeastOneProjectError);
      return;
    }
    if (fromDate == null || toDate == null) return;

    if (widget.timesheetId == "0") {
      context.read<TimesheetBloc>().add(TimesheetEvent.submitRequested(
        employee: employeeId ?? "",
        department: department ?? "",
        approver: approver ?? "",
        fromDate: fromDate.format(),
        toDate: toDate.format(),
        assignments: assignments,
      ));
    } else {
      context.read<TimesheetBloc>().add(TimesheetEvent.updateRequested(
        name: widget.timesheetId,
        employee: employeeId ?? "",
        department: department ?? "",
        approver: approver ?? "",
        approved: 0,
        hoursTotal: assignments.fold(0.0, (sum, item) => sum + item.spentHours),
        assignments: assignments,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocBuilder<TimesheetBloc, TimesheetState>(
      builder: (context, state) {
        final isLoading = state.maybeMap(loading: (_) => true, orElse: () => false);
        final user = state.user;
        final fromDate = state.editFromDate;
        final toDate = state.editToDate;
        final assignments = state.editAssignments;

        if (isLoading && user == null) return const Center(child: CircularProgressIndicator());

        final totalExpected = assignments.fold(0.0, (sum, item) => sum + item.expectedHours);
        final totalSpent = assignments.fold(0.0, (sum, item) => sum + item.spentHours);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TimesheetHeaderInfo(
              employeeName: user?.fullName,
              department: user?.department,
              approver: user?.approver,
            ),
            const SizedBox(height: AppConstants.p20),
            TimesheetDateSelectors(
              fromDate: fromDate, 
              toDate: toDate,
              onFromDateTap: () => _selectDate(context, true, fromDate),
              onToDateTap: () => _selectDate(context, false, toDate),
            ),
            const SizedBox(height: AppConstants.p20),
            TimesheetAssignmentList(
              assignments: assignments,
              onAdd: () => _addOrEditAssignment(assignments, fromDate, toDate, user?.fullName),
              onEdit: (idx, item) => _editAssignment(assignments, idx, item, fromDate, toDate, user?.fullName),
              onDelete: (idx) => _deleteAssignment(assignments, idx),
            ),
            const SizedBox(height: AppConstants.p20),
            TimesheetSummarySection(totalExpected: totalExpected, totalSpent: totalSpent),
            if (isLoading) 
              const Padding(
                padding: EdgeInsets.symmetric(vertical: AppConstants.p16),
                child: Center(child: CircularProgressIndicator()),
              ),
            const SizedBox(height: AppConstants.p32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: isLoading ? null : () => _submit(user?.empId, user?.department, user?.approver, fromDate, toDate, assignments),
                child: Text(l10n.submit, style: AppTextStyle.button),
              ),
            ),
          ],
        );
      },
    );
  }
}
