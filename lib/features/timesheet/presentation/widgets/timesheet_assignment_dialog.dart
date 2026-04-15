import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/timesheet_entities.dart';

class TimesheetAssignmentDialog extends StatefulWidget {
  final List<ProjectEntity> projects;
  final ProjectAssignmentEntity? existing;
  final DateTime initialDate;
  final DateTime minDate;
  final DateTime maxDate;
  final String raisedBy;
  final Function(ProjectAssignmentEntity) onSave;

  const TimesheetAssignmentDialog({
    super.key,
    required this.projects,
    this.existing,
    required this.initialDate,
    required this.minDate,
    required this.maxDate,
    required this.raisedBy,
    required this.onSave,
  });

  @override
  State<TimesheetAssignmentDialog> createState() => _TimesheetAssignmentDialogState();
}

class _TimesheetAssignmentDialogState extends State<TimesheetAssignmentDialog> {
  String? _selectedProject;
  DateTime? _selectedDate;
  final _taskController = TextEditingController();
  final _expectedController = TextEditingController();
  final _spentController = TextEditingController();
  final _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.existing?.date != null 
        ? DateTime.parse(widget.existing!.date!) 
        : widget.initialDate;
    
    if (widget.existing != null) {
      _selectedProject = widget.existing!.project;
      _taskController.text = widget.existing!.taskName ?? "";
      _expectedController.text = widget.existing!.expectedHours.toString();
      _spentController.text = widget.existing!.spentHours.toString();
      _descController.text = widget.existing!.description ?? "";
    }

    _expectedController.addListener(_updateDetails);
    _spentController.addListener(_updateDetails);
  }

  void _updateDetails() {
    setState(() {});
  }

  @override
  void dispose() {
    _taskController.dispose();
    _expectedController.dispose();
    _spentController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? widget.initialDate,
      firstDate: widget.minDate,
      lastDate: widget.maxDate,
    );
    if (picked != null && picked != _selectedDate) {
      setState(() => _selectedDate = picked);
    }
  }

  String get _hoursDetails {
    final spent = double.tryParse(_spentController.text) ?? 0.0;
    final expected = double.tryParse(_expectedController.text) ?? 0.0;
    return "${spent.toStringAsFixed(2)} / ${expected.toStringAsFixed(2)}";
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r16)),
      child: Container(
        padding: const EdgeInsets.all(AppConstants.p24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l10n.addEditProject, style: AppTextStyle.h3.copyWith(color: AppColors.textSecondary)),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close, color: AppColors.textSecondary),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.p24),
              
              _buildLabel(l10n.projectName),
              DropdownButtonFormField<String>(
                value: _selectedProject,
                items: widget.projects
                    .map((p) => DropdownMenuItem(
                          value: p.name,
                          child: Text(p.projectName, style: AppTextStyle.bodyMedium),
                        ))
                    .toList(),
                onChanged: (val) => setState(() => _selectedProject = val),
                decoration: _fieldDecoration(l10n.selectProject),
              ),
              const SizedBox(height: AppConstants.p16),

              _buildLabel(l10n.task),
              TextField(
                controller: _taskController,
                style: AppTextStyle.bodyMedium,
                decoration: _fieldDecoration(l10n.taskHint),
              ),
              const SizedBox(height: AppConstants.p16),

              _buildLabel(l10n.date),
              GestureDetector(
                onTap: _selectDate,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  decoration: _boxDecoration(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('dd-MM-yyyy').format(_selectedDate ?? widget.initialDate),
                        style: AppTextStyle.bodyMedium,
                      ),
                      const Icon(Icons.calendar_month, color: AppColors.textSecondary, size: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppConstants.p16),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel(l10n.expectedHours),
                        TextField(
                          controller: _expectedController,
                          keyboardType: TextInputType.number,
                          style: AppTextStyle.bodyMedium,
                          decoration: _fieldDecoration("0.00"),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppConstants.p16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel(l10n.spentHours),
                        TextField(
                          controller: _spentController,
                          keyboardType: TextInputType.number,
                          style: AppTextStyle.bodyMedium,
                          decoration: _fieldDecoration("0.00"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppConstants.p16),

              _buildLabel(l10n.hoursDetails),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: _boxDecoration(),
                child: Text(_hoursDetails, style: AppTextStyle.bodyMedium.copyWith(color: AppColors.textSecondary)),
              ),
              const SizedBox(height: AppConstants.p16),

              _buildLabel(l10n.raisedBy),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: _boxDecoration(),
                child: Text(widget.raisedBy, style: AppTextStyle.bodyMedium.copyWith(color: AppColors.textSecondary)),
              ),
              const SizedBox(height: AppConstants.p24),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r8)),
                      ),
                      child: Text(l10n.cancel, style: AppTextStyle.label),
                    ),
                  ),
                  const SizedBox(width: AppConstants.p16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_selectedProject != null) {
                          widget.onSave(ProjectAssignmentEntity(
                            project: _selectedProject!,
                            date: _selectedDate?.toIso8601String().split('T')[0],
                            taskName: _taskController.text,
                            expectedHours: double.tryParse(_expectedController.text) ?? 0.0,
                            spentHours: double.tryParse(_spentController.text) ?? 0.0,
                            description: _descController.text,
                          ));
                          Navigator.pop(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r8)),
                      ),
                      child: Text(l10n.save, style: AppTextStyle.button),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(text, style: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary, fontWeight: FontWeight.w500)),
    );
  }

  InputDecoration _fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.r8),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.r8),
        borderSide: const BorderSide(color: AppColors.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppConstants.r8),
        borderSide: const BorderSide(color: AppColors.primary),
      ),
    );
  }

  BoxDecoration _boxDecoration() {
    return BoxDecoration(
      color: AppColors.background.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(AppConstants.r8),
      border: Border.all(color: AppColors.border),
    );
  }


}
