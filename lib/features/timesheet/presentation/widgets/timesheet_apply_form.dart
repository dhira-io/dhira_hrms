import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../domain/entities/timesheet_entities.dart';
import '../bloc/timesheet_bloc.dart';
import '../bloc/timesheet_event.dart';
import '../bloc/timesheet_state.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../l10n/app_localizations.dart';

class TimesheetApplyForm extends StatefulWidget {
  final String timesheetId;
  final ProjectAssignmentEntity? editingTask;
  final int? editingIndex;
  final VoidCallback? onEditComplete;
  final String? activeIdOverride;

  const TimesheetApplyForm({
    super.key,
    required this.timesheetId,
    this.editingTask,
    this.editingIndex,
    this.onEditComplete,
    this.activeIdOverride,
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
    } else {
      _taskController.clear();
      _expectedController.clear();
      _actualController.clear();
      _descriptionController.clear();
      _selectedProject = null;
    }
  }

  void _tryMatchProject(List<ProjectEntity> projects) {
    if (widget.editingTask == null || _selectedProject != null || projects.isEmpty) return;
    try {
      final match = projects.firstWhere((p) => p.projectName == widget.editingTask!.project);
      if (mounted) setState(() => _selectedProject = match);
    } catch (_) {}
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
      name: widget.editingTask?.name,
      project: _selectedProject?.projectName ?? widget.editingTask?.project ?? "",
      date: selectedDate.toIso8601String(),
      taskData: _taskController.text,
      description: _descriptionController.text,
      expectedHours: double.tryParse(_expectedController.text) ?? 0.0,
      spentHours: double.tryParse(_actualController.text) ?? 0.0,
      status: "Draft",
    );

    final List<ProjectAssignmentEntity> onlyThisTask = [newTask];

    final user = state.user;
    final from = state.editFromDate;
    final to = state.editToDate;

    if (from == null || to == null) return;

    final effectiveId = widget.activeIdOverride ?? state.activeTimesheetId ?? (
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
        hoursTotal: newTask.spentHours,
        assignments: onlyThisTask,
      ));
    }

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
        final l10n = AppLocalizations.of(context)!;
        final projects = state.projects;
        final selectedDate = state.selectedDate ?? DateTime.now();

        WidgetsBinding.instance.addPostFrameCallback((_) => _tryMatchProject(projects));

        final selectedProjectName = _selectedProject?.projectName;

        return Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLowest,
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
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.editingTask != null ? l10n.updateTask : l10n.addNewTask,
                    style: AppTextStyle.h3.copyWith(fontSize: 14),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              StatLabel(text: l10n.selectProject),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: projects.any((p) => p.projectName == selectedProjectName) ? selectedProjectName : null,
                    isExpanded: true,
                    icon: projects.isEmpty
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.expand_more, color: AppColors.textSecondary),
                    hint: Text(
                      projects.isEmpty ? l10n.loadingProjects : l10n.selectProject,
                      style: AppTextStyle.bodyMedium,
                    ),
                    items: projects.map((p) {
                      return DropdownMenuItem(
                        value: p.projectName,
                        child: Text(p.projectName, style: AppTextStyle.bodyMedium),
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
              StatLabel(text: l10n.task),
              TimesheetTextField(controller: _taskController, hint: l10n.taskHint),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StatLabel(text: l10n.expectedH),
                        TimesheetTextField(
                          controller: _expectedController,
                          hint: "0.0",
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        StatLabel(text: l10n.actualH),
                        TimesheetTextField(
                          controller: _actualController,
                          hint: "0.0",
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              StatLabel(text: l10n.detailedDescription),
              TimesheetTextField(
                controller: _descriptionController,
                hint: l10n.descriptionHint,
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              StatLabel(text: l10n.supportingDocuments),
              TimesheetUploadCard(
                onTap: () {
                  ToastUtils.showInfo(l10n.docUploadComingSoon);
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: state.isActionLoading
                    ? null
                    : () => _addTask(context, selectedDate, state.editAssignments, state),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.surfaceContainerHigh,
                    foregroundColor: AppColors.textPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 0,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: state.isActionLoading
                    ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primary),
                    )
                    : Text(
                      widget.editingTask != null ? l10n.updateTask : l10n.addToDay,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class StatLabel extends StatelessWidget {
  final String text;
  const StatLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 6),
      child: Text(
        text.toUpperCase(),
        style: AppTextStyle.statsLabel.copyWith(fontSize: 10, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class TimesheetTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final TextInputType? keyboardType;

  const TimesheetTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: AppTextStyle.bodyMedium,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary.withValues(alpha: 0.5)),
        filled: true,
        fillColor: AppColors.surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }
}

class TimesheetUploadCard extends StatelessWidget {
  final VoidCallback onTap;

  const TimesheetUploadCard({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(12),
        ),
        child: CustomPaint(
          painter: _DashedRectPainter(color: AppColors.outlineVariant.withValues(alpha: 0.4)),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Icon(Icons.cloud_upload, color: AppColors.primary, size: 32),
                const SizedBox(height: 8),
                Text(l10n.tapToBrowseFiles, style: AppTextStyle.bodySmall.copyWith(fontWeight: FontWeight.bold)),
                Text(l10n.fileSizeLimit, style: AppTextStyle.bodySmall.copyWith(fontSize: 10)),
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
