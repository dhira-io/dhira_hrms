import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'timesheet_theme.dart';
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
  final _taskController = TextEditingController();
  final _expectedController = TextEditingController();
  final _actualController = TextEditingController();
  final _descriptionController = TextEditingController();
  ProjectEntity? _selectedProject;

  @override
  void dispose() {
    _taskController.dispose();
    _expectedController.dispose();
    _actualController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _addTask(BuildContext context, DateTime selectedDate, List<ProjectAssignmentEntity> currentAssignments) {
    if (_selectedProject == null) return;
    
    final newTask = ProjectAssignmentEntity(
      project: _selectedProject!.projectName,
      date: selectedDate.toIso8601String(),
      description: _taskController.text,
      expectedHours: double.tryParse(_expectedController.text) ?? 0.0,
      spentHours: double.tryParse(_actualController.text) ?? 0.0,
    );

    final updated = List<ProjectAssignmentEntity>.from(currentAssignments)..add(newTask);
    context.read<TimesheetBloc>().add(TimesheetEvent.assignmentsChanged(updated));

    // Clear form
    _taskController.clear();
    _expectedController.clear();
    _actualController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedProject = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimesheetBloc, TimesheetState>(
      builder: (context, state) {
        final projects = state.projects;
        final selectedDate = state.selectedDate ?? DateTime.now();

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: TimesheetColors.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 32,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 20,
                    decoration: BoxDecoration(
                      color: TimesheetColors.primary,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text("Add New Task", style: TimesheetStyles.h3.copyWith(fontSize: 14)),
                ],
              ),
              const SizedBox(height: 20),
              _buildLabel("Select Project"),
              _buildDropdown(projects),
              const SizedBox(height: 16),
              _buildLabel("Task"),
              _buildTextField(_taskController, "What are you working on?"),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel("Expected (h)"),
                        _buildTextField(_expectedController, "0.0", keyboardType: TextInputType.number),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel("Actual (h)"),
                        _buildTextField(_actualController, "0.0", keyboardType: TextInputType.number),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildLabel("Detailed Description"),
              _buildTextField(_descriptionController, "Provide details about the work done...", maxLines: 3),
              const SizedBox(height: 16),
              _buildLabel("Supporting Documents"),
              _buildUploadPlaceholder(),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _addTask(context, selectedDate, state.editAssignments),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TimesheetColors.surfaceContainerHigh,
                    foregroundColor: TimesheetColors.textPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text("Add To Day", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 6),
      child: Text(
        text.toUpperCase(),
        style: TimesheetStyles.statsLabel.copyWith(fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {int maxLines = 1, TextInputType? keyboardType}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: TimesheetStyles.bodyMedium,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TimesheetStyles.bodySmall.copyWith(color: TimesheetColors.textSecondary.withValues(alpha: 0.5)),
        filled: true,
        fillColor: TimesheetColors.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildDropdown(List<ProjectEntity> projects) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: TimesheetColors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<ProjectEntity>(
          value: _selectedProject,
          isExpanded: true,
          icon: const Icon(Icons.expand_more, color: TimesheetColors.textSecondary),
          hint: Text("Select a project", style: TimesheetStyles.bodyMedium),
          items: projects.map((p) {
            return DropdownMenuItem(
              value: p,
              child: Text(p.projectName, style: TimesheetStyles.bodyMedium),
            );
          }).toList(),
          onChanged: (val) => setState(() => _selectedProject = val),
        ),
      ),
    );
  }

  Widget _buildUploadPlaceholder() {
    return GestureDetector(
      onTap: () async {
        final picker = ImagePicker();
        await picker.pickImage(source: ImageSource.gallery);
      },
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: TimesheetColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: TimesheetColors.border.withValues(alpha: 0.4),
            width: 2,
            style: BorderStyle.none,
          ),
        ),
        child: CustomPaint(
          painter: _DashedRectPainter(color: TimesheetColors.border.withValues(alpha: 0.4)),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Icon(Icons.cloud_upload, color: Color(0xFF155DFC), size: 32),
                const SizedBox(height: 8),
                Text("Tap to Browse Files", style: TimesheetStyles.bodySmall.copyWith(fontWeight: FontWeight.bold)),
                Text("Max size 5MB (PDF, JPG, PNG)", style: TimesheetStyles.bodySmall.copyWith(fontSize: 10)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashedRectPainter extends CustomPainter {
  final Color color;
  _DashedRectPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(12),
    );

    canvas.drawRRect(rrect, paint); 
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
