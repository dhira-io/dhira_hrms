import 'package:flutter/material.dart';
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
  final Function(ProjectAssignmentEntity) onSave;

  const TimesheetAssignmentDialog({
    super.key,
    required this.projects,
    this.existing,
    required this.initialDate,
    required this.minDate,
    required this.maxDate,
    required this.onSave,
  });

  @override
  State<TimesheetAssignmentDialog> createState() => _TimesheetAssignmentDialogState();
}

class _TimesheetAssignmentDialogState extends State<TimesheetAssignmentDialog> {
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
  void dispose() {
    _expectedController.dispose();
    _spentController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AlertDialog(
      title: Text(
        widget.existing == null ? l10n.addAssignment : l10n.editAssignment,
        style: AppTextStyle.h3,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              initialValue: _selectedProject,
              hint: Text(l10n.selectProject, style: AppTextStyle.bodyMedium),
              items: widget.projects
                  .map((p) => DropdownMenuItem(
                        value: p.name,
                        child: Text(p.projectName, style: AppTextStyle.bodyMedium),
                      ))
                  .toList(),
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
          child: Text(l10n.cancel, style: AppTextStyle.bodyMedium.copyWith(color: AppColors.textSecondary)),
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
