import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
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
              _HeaderInfo(
                employeeName: _employeeName,
                department: _department,
                approver: _approver,
              ),
              const SizedBox(height: AppConstants.p20),
              _DateSelectors(fromDate: _fromDate, toDate: _toDate),
              const SizedBox(height: AppConstants.p20),
              _AssignmentList(
                assignments: _localAssignments,
                onAdd: () => _addOrEditAssignment(),
                onEdit: (idx, item) => _addOrEditAssignment(existing: item, index: idx),
                onDelete: (idx) => setState(() => _localAssignments.removeAt(idx)),
              ),
              const SizedBox(height: AppConstants.p20),
              _SummarySection(totalExpected: _totalExpected, totalSpent: _totalSpent),
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

class _HeaderInfo extends StatelessWidget {
  final String? employeeName;
  final String? department;
  final String? approver;

  const _HeaderInfo({this.employeeName, this.department, this.approver});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.p12),
        child: Column(
          children: [
            _InfoRow(label: l10n.employee, value: employeeName ?? ""),
            _InfoRow(label: l10n.department, value: department ?? ""),
            _InfoRow(label: l10n.approver, value: approver ?? ""),
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
          Text(label, style: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary)),
          Text(value, style: AppTextStyle.bodySmall.copyWith(fontWeight: FontWeight.bold)),
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
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(child: _DateTile(label: l10n.fromDate, date: fromDate)),
        const SizedBox(width: AppConstants.p15),
        Expanded(child: _DateTile(label: l10n.toDate, date: toDate)),
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
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.bodySmall.copyWith(color: Colors.grey)),
        const SizedBox(height: AppConstants.p4),
        Container(
          padding: const EdgeInsets.all(AppConstants.p12),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border), 
            borderRadius: BorderRadius.circular(AppConstants.r8),
          ),
          child: Text(
            date == null ? l10n.select : DateFormat('dd MMM yyyy').format(date!),
            style: AppTextStyle.bodySmall,
          ),
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
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MandatoryLabel(labelText: l10n.projectAssignments),
            TextButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add, color: AppColors.primary),
              label: Text(l10n.addProject, style: AppTextStyle.bodyMedium.copyWith(color: AppColors.primary)),
            ),
          ],
        ),
        if (assignments.isEmpty)
          Center(
            child: Padding(
              padding: const EdgeInsets.all(AppConstants.p20), 
              child: Text(
                l10n.noProjectsAdded, 
                style: AppTextStyle.bodySmall.copyWith(color: Colors.grey),
              ),
            ),
          )
        else
          ...assignments.asMap().entries.map((entry) {
            final idx = entry.key;
            final item = entry.value;
            return Card(
              margin: const EdgeInsets.only(bottom: AppConstants.p8),
              child: ListTile(
                title: Text(item.project, style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.bold)),
                subtitle: Text(
                  'Spent: ${item.spentHours}h | Expected: ${item.expectedHours}h',
                  style: AppTextStyle.bodySmall,
                ),
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
    final l10n = AppLocalizations.of(context)!;
    return Card(
      color: AppColors.primary.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.p12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _SummaryItem(label: l10n.totalExpected, value: totalExpected.toStringAsFixed(1)),
            _SummaryItem(label: l10n.totalSpent, value: totalSpent.toStringAsFixed(1)),
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
        Text(value, style: AppTextStyle.h3),
        Text(label, style: AppTextStyle.bodySmall.copyWith(color: Colors.grey, fontSize: 10)),
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
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(widget.existing == null ? l10n.addAssignment : l10n.editAssignment, style: AppTextStyle.h3),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              initialValue: _selectedProject,
              hint: Text(l10n.selectProject, style: AppTextStyle.bodyMedium),
              items: widget.projects.map((p) => DropdownMenuItem(value: p.name, child: Text(p.projectName, style: AppTextStyle.bodyMedium))).toList(),
              onChanged: (val) => setState(() => _selectedProject = val),
              decoration: const InputDecoration(contentPadding: EdgeInsets.symmetric(horizontal: 10)),
            ),
            const SizedBox(height: AppConstants.p10),
            TextField(
              controller: _expectedController, 
              style: AppTextStyle.bodyMedium,
              decoration: InputDecoration(labelText: l10n.expectedHours), 
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: AppConstants.p10),
            TextField(
              controller: _spentController, 
              style: AppTextStyle.bodyMedium,
              decoration: InputDecoration(labelText: l10n.spentHours), 
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: AppConstants.p10),
            TextField(
              controller: _descController, 
              style: AppTextStyle.bodyMedium,
              decoration: InputDecoration(labelText: l10n.description), 
              maxLines: 2,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context), 
          child: Text(l10n.cancel, style: AppTextStyle.bodyMedium.copyWith(color: Colors.grey)),
        ),
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
          child: Text(l10n.save, style: AppTextStyle.button),
        ),
      ],
    );
  }
}

