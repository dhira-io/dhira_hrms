import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../shared/components/mandatory_label.dart';
import '../../../../shared/dialogs/app_dialogs.dart';
import '../../domain/entities/timesheet_entities.dart';
import '../bloc/timesheet_bloc.dart';
import '../bloc/timesheet_event.dart';
import '../bloc/timesheet_state.dart';

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
      builder: (context) => _AssignmentDialog(
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
    if (_localAssignments.isEmpty) {
      AppDialogs.showAlertDialog(context, "Please add at least one project assignment.");
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
              _HeaderInfo(
                employeeName: _employeeName,
                department: _department,
                approver: _approver,
              ),
              const SizedBox(height: 20),
              _DateSelectors(fromDate: _fromDate, toDate: _toDate),
              const SizedBox(height: 20),
              _AssignmentList(
                assignments: _localAssignments,
                onAdd: () => _addOrEditAssignment(),
                onEdit: (idx, item) => _addOrEditAssignment(existing: item, index: idx),
                onDelete: (idx) => setState(() => _localAssignments.removeAt(idx)),
              ),
              const SizedBox(height: 20),
              _SummarySection(totalExpected: _totalExpected, totalSpent: _totalSpent),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _submit,
                  style: ElevatedButton.styleFrom(backgroundColor: const Color(0xff1100CC), foregroundColor: Colors.white),
                  child: const Text('SUBMIT'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _HeaderInfo extends StatelessWidget {
  final String? employeeName;
  final String? department;
  final String? approver;

  const _HeaderInfo({this.employeeName, this.department, this.approver});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _InfoRow(label: 'Employee', value: employeeName ?? ""),
            _InfoRow(label: 'Department', value: department ?? ""),
            _InfoRow(label: 'Approver', value: approver ?? ""),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _DateSelectors extends StatelessWidget {
  final DateTime? fromDate;
  final DateTime? toDate;

  const _DateSelectors({this.fromDate, this.toDate});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: _DateTile(label: 'From Date', date: fromDate)),
        const SizedBox(width: 15),
        Expanded(child: _DateTile(label: 'To Date', date: toDate)),
      ],
    );
  }
}

class _DateTile extends StatelessWidget {
  final String label;
  final DateTime? date;

  const _DateTile({required this.label, this.date});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Container(
          padding: const EdgeInsets.all(12),
          width: double.infinity,
          decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade300), borderRadius: BorderRadius.circular(8)),
          child: Text(date == null ? 'Select' : DateFormat('dd MMM yyyy').format(date!)),
        ),
      ],
    );
  }
}

class _AssignmentList extends StatelessWidget {
  final List<ProjectAssignmentEntity> assignments;
  final VoidCallback onAdd;
  final Function(int, ProjectAssignmentEntity) onEdit;
  final Function(int) onDelete;

  const _AssignmentList({
    required this.assignments,
    required this.onAdd,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const MandatoryLabel(labelText: 'Project Assignments'),
            TextButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add),
              label: const Text('Add Project'),
            ),
          ],
        ),
        if (assignments.isEmpty)
          const Center(child: Padding(padding: EdgeInsets.all(20), child: Text('No projects added yet.', style: TextStyle(color: Colors.grey))))
        else
          ...assignments.asMap().entries.map((entry) {
            final idx = entry.key;
            final item = entry.value;
            return Card(
              margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(
                title: Text(item.project, style: const TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('Spent: ${item.spentHours}h | Expected: ${item.expectedHours}h'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(icon: const Icon(Icons.edit, size: 18), onPressed: () => onEdit(idx, item)),
                    IconButton(icon: const Icon(Icons.delete, size: 18, color: Colors.red), onPressed: () => onDelete(idx)),
                  ],
                ),
              ),
            );
          }),
      ],
    );
  }
}

class _SummarySection extends StatelessWidget {
  final double totalExpected;
  final double totalSpent;

  const _SummarySection({required this.totalExpected, required this.totalSpent});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.shade50,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _SummaryItem(label: 'Total Expected', value: totalExpected.toStringAsFixed(1)),
            _SummaryItem(label: 'Total Spent', value: totalSpent.toStringAsFixed(1)),
          ],
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }
}

class _AssignmentDialog extends StatefulWidget {
  final List<ProjectEntity> projects;
  final ProjectAssignmentEntity? existing;
  final DateTime initialDate;
  final DateTime minDate;
  final DateTime maxDate;
  final Function(ProjectAssignmentEntity) onSave;

  const _AssignmentDialog({
    required this.projects,
    this.existing,
    required this.initialDate,
    required this.minDate,
    required this.maxDate,
    required this.onSave,
  });

  @override
  State<_AssignmentDialog> createState() => _AssignmentDialogState();
}

class _AssignmentDialogState extends State<_AssignmentDialog> {
  String? _selectedProject;
  final _expectedController = TextEditingController();
  final _spentController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.existing != null) {
      _selectedProject = widget.existing!.project;
      _expectedController.text = widget.existing!.expectedHours.toString();
      _spentController.text = widget.existing!.spentHours.toString();
      _descController.text = widget.existing!.description ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.existing == null ? 'Add Assignment' : 'Edit Assignment'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              initialValue: _selectedProject,
              hint: const Text('Select Project'),
              items: widget.projects.map((p) => DropdownMenuItem(value: p.name, child: Text(p.projectName))).toList(),
              onChanged: (val) => setState(() => _selectedProject = val),
            ),
            const SizedBox(height: 10),
            TextField(controller: _expectedController, decoration: const InputDecoration(labelText: 'Expected Hours'), keyboardType: TextInputType.number),
            const SizedBox(height: 10),
            TextField(controller: _spentController, decoration: const InputDecoration(labelText: 'Spent Hours'), keyboardType: TextInputType.number),
            const SizedBox(height: 10),
            TextField(controller: _descController, decoration: const InputDecoration(labelText: 'Description'), maxLines: 2),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        ElevatedButton(
          onPressed: () {
            if (_selectedProject != null) {
              widget.onSave(ProjectAssignmentEntity(
                project: _selectedProject!,
                expectedHours: double.tryParse(_expectedController.text) ?? 0.0,
                spentHours: double.tryParse(_spentController.text) ?? 0.0,
                description: _descController.text,
              ));
              Navigator.pop(context);
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}
