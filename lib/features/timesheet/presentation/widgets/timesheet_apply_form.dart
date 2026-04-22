import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'timesheet_theme.dart';
import '../../domain/entities/timesheet_entities.dart';
import '../bloc/timesheet_bloc.dart';
import '../bloc/timesheet_event.dart';
import '../bloc/timesheet_state.dart';
import '../../../../core/utils/date_time_utils.dart';

class TimesheetApplyForm extends StatefulWidget {
  final String timesheetId;
  final ProjectAssignmentEntity? editingTask;
  final int? editingIndex;
  final VoidCallback? onEditComplete;

  const TimesheetApplyForm({
    super.key,
    required this.timesheetId,
    this.editingTask,
    this.editingIndex,
    this.onEditComplete,
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
  void initState() {
    super.initState();
    _prefillForm();
  }

  @override
  void didUpdateWidget(TimesheetApplyForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.editingTask != oldWidget.editingTask || widget.editingIndex != oldWidget.editingIndex) {
      _prefillForm();
    }
  }

  void _prefillForm() {
    if (widget.editingTask != null) {
      _taskController.text = widget.editingTask!.taskData ?? '';
      _descriptionController.text = widget.editingTask!.description ?? '';
      _expectedController.text = widget.editingTask!.expectedHours.toString();
      _actualController.text = widget.editingTask!.spentHours.toString();
      // Project matching will happen in the build method once projects are loaded
    } else {
      _taskController.clear();
      _expectedController.clear();
      _actualController.clear();
      _descriptionController.clear();
      _selectedProject = null;
    }
  }

  @override
  void dispose() {
    _taskController.dispose();
    _expectedController.dispose();
    _actualController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _addTask(BuildContext context, DateTime selectedDate, List<ProjectAssignmentEntity> currentAssignments, TimesheetState state) {
    if (_selectedProject == null && widget.editingTask == null) return;
    
    final newTask = ProjectAssignmentEntity(
      name: widget.editingTask?.name, // Crucial: Keep the ID for updates
      project: _selectedProject?.projectName ?? widget.editingTask?.project ?? "",
      date: selectedDate.toIso8601String(),
      taskData: _taskController.text,
      description: _descriptionController.text,
      expectedHours: double.tryParse(_expectedController.text) ?? 0.0,
      spentHours: double.tryParse(_actualController.text) ?? 0.0,
      status: "Draft",
    );
    
    debugPrint("UI: New Task Data to add: name='${newTask.name}', taskData='${newTask.taskData}'");

    // "Pass 1 data only" - only send the modified task to prevent duplicates of other tasks
    final List<ProjectAssignmentEntity> onlyThisTask = [newTask];
    
    final user = state.user;
    final from = state.editFromDate;
    final to = state.editToDate;

    if (from == null || to == null) return;

    final effectiveId = state.activeTimesheetId ?? (
        (widget.timesheetId != "0" && widget.timesheetId != "current") 
        ? widget.timesheetId 
        : null
    );

    if (effectiveId == null) {
      context.read<TimesheetBloc>().add(TimesheetEvent.submitRequested(
        employee: user?.empId ?? "",
        department: user?.department ?? "",
        approver: user?.approver ?? "",
        fromDate: from.format(),
        toDate: to.format(),
        assignments: onlyThisTask,
        docStatus: 0,
      ));
    } else {
      context.read<TimesheetBloc>().add(TimesheetEvent.updateRequested(
        name: effectiveId,
        employee: user?.empId ?? "",
        department: user?.department ?? "",
        approver: user?.approver ?? "",
        fromDate: from.format(),
        toDate: to.format(),
        approved: 0,
        hoursTotal: newTask.spentHours, // Reflecting only this task's contribution for sync
        assignments: onlyThisTask,
      ));
    }

    // Clear form
    _taskController.clear();
    _expectedController.clear();
    _actualController.clear();
    _descriptionController.clear();
    setState(() {
      _selectedProject = null;
    });
    
    widget.onEditComplete?.call();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimesheetBloc, TimesheetState>(
      builder: (context, state) {
        final projects = state.projects;
        final selectedDate = state.selectedDate ?? DateTime.now();

        // Automatic project matching when editing starts
        if (widget.editingTask != null && _selectedProject == null && projects.isNotEmpty) {
          try {
            _selectedProject = projects.firstWhere((p) => p.projectName == widget.editingTask!.project);
          } catch (_) {
            // No match found
          }
        }

        final selectedProjectName = _selectedProject?.projectName;

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
                  Text(widget.editingTask != null ? "Update Task" : "Add New Task", style: TimesheetStyles.h3.copyWith(fontSize: 14)),
                ],
              ),
              const SizedBox(height: 20),
              _buildLabel("Select Project"),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: TimesheetColors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: projects.any((p) => p.projectName == selectedProjectName) ? selectedProjectName : null,
                    isExpanded: true,
                    icon: projects.isEmpty 
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.expand_more, color: TimesheetColors.textSecondary),
                    hint: Text(projects.isEmpty ? "Loading projects..." : "Select a project", style: TimesheetStyles.bodyMedium),
                    items: projects.map((p) {
                      return DropdownMenuItem(
                        value: p.projectName,
                        child: Text(p.projectName, style: TimesheetStyles.bodyMedium),
                      );
                    }).toList(),
                    onChanged: projects.isEmpty ? null : (val) {
                      if (val != null) {
                        setState(() {
                          _selectedProject = projects.firstWhere((p) => p.projectName == val);
                        });
                      }
                    },
                  ),
                ),
              ),
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
                  onPressed: state.isActionLoading
                    ? null
                    : () => _addTask(context, selectedDate, state.editAssignments, state),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: TimesheetColors.surfaceContainerHigh,
                    foregroundColor: TimesheetColors.textPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: state.isActionLoading
                    ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: TimesheetColors.primary),
                    )
                    : Text(widget.editingTask != null ? "Update Task" : "Add To Day", style: const TextStyle(fontWeight: FontWeight.bold)),
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
