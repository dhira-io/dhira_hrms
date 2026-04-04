import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/dialogs/app_dialogs.dart';
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
  DateTime? _fromDate;
  DateTime? _toDate;
  String? _employeeId;
  String? _employeeName;
  String? _department;
  String? _approver;
  List<ProjectAssignmentEntity> _localAssignments = [];

  @override
  void initState() {
    super.initState();
    _loadUserData();
    if (widget.timesheetId != "0") {
      context.read<TimesheetBloc>().add(TimesheetEvent.fetchDetailsRequested(widget.timesheetId));
    } else {
      _setDefaultDates();
    }
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _employeeId = prefs.getString('empid');
      _employeeName = prefs.getString('userfullname');
      _department = prefs.getString('department');
      _approver = prefs.getString('leaveapprovername');
    });
  }

  void _setDefaultDates() {
    final now = DateTime.now();
    _fromDate = now.subtract(Duration(days: now.weekday - DateTime.monday));
    _toDate = _fromDate!.add(const Duration(days: 4)); // Friday
  }

  double get _totalExpected => _localAssignments.fold(0.0, (sum, item) => sum + item.expectedHours);
  double get _totalSpent => _localAssignments.fold(0.0, (sum, item) => sum + item.spentHours);

  void _addOrEditAssignment({ProjectAssignmentEntity? existing, int? index}) {
    final state = context.read<TimesheetBloc>().state;
    final projects = state.maybeWhen(
      detailLoaded: (_, projects) => projects,
      orElse: () => <ProjectEntity>[],
    );

    showDialog(
      context: context,
      builder: (context) => TimesheetAssignmentDialog(
        projects: projects,
        existing: existing,
        initialDate: _fromDate ?? DateTime.now(),
        minDate: _fromDate!,
        maxDate: _toDate!,
        onSave: (assignment) {
          setState(() {
            if (index != null) {
              _localAssignments[index] = assignment;
            } else {
              _localAssignments.add(assignment);
            }
          });
        },
      ),
    );
  }

  void _submit() {
    final l10n = AppLocalizations.of(context)!;
    if (_localAssignments.isEmpty) {
      AppDialogs.showAlertDialog(context, l10n.addAtLeastOneProjectError);
      return;
    }

    if (widget.timesheetId == "0") {
      context.read<TimesheetBloc>().add(TimesheetEvent.submitRequested(
        employee: _employeeId ?? "",
        department: _department ?? "",
        approver: _approver ?? "",
        fromDate: DateFormat('yyyy-MM-dd').format(_fromDate!),
        toDate: DateFormat('yyyy-MM-dd').format(_toDate!),
        assignments: _localAssignments,
      ));
    } else {
      context.read<TimesheetBloc>().add(TimesheetEvent.updateRequested(
        name: widget.timesheetId,
        employee: _employeeId ?? "",
        department: _department ?? "",
        approver: _approver ?? "",
        approved: 0,
        hoursTotal: 48.0,
        assignments: _localAssignments,
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocListener<TimesheetBloc, TimesheetState>(
      listener: (context, state) {
        state.whenOrNull(
          detailLoaded: (ts, _) {
            setState(() {
              _fromDate = DateTime.parse(ts.fromDate);
              _toDate = DateTime.parse(ts.toDate);
              _localAssignments = List.from(ts.projectAssignments ?? []);
            });
          },
        );
      },
      child: BlocBuilder<TimesheetBloc, TimesheetState>(
        builder: (context, state) {
          final isLoading = state == const TimesheetState.loading();

          if (isLoading) return const Center(child: CircularProgressIndicator());

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TimesheetHeaderInfo(
                employeeName: _employeeName,
                department: _department,
                approver: _approver,
              ),
              const SizedBox(height: AppConstants.p20),
              TimesheetDateSelectors(fromDate: _fromDate, toDate: _toDate),
              const SizedBox(height: AppConstants.p20),
              TimesheetAssignmentList(
                assignments: _localAssignments,
                onAdd: () => _addOrEditAssignment(),
                onEdit: (idx, item) => _addOrEditAssignment(existing: item, index: idx),
                onDelete: (idx) => setState(() => _localAssignments.removeAt(idx)),
              ),
              const SizedBox(height: AppConstants.p20),
              TimesheetSummarySection(totalExpected: _totalExpected, totalSpent: _totalSpent),
              const SizedBox(height: AppConstants.p32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submit,
                  child: Text(l10n.submit, style: AppTextStyle.button),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
