import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/utils/toast_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/timesheet_entities.dart';
import '../bloc/timesheet_bloc.dart';
import '../bloc/timesheet_event.dart';
import '../bloc/timesheet_state.dart';
import '../bloc/timesheet_success_type.dart';

class AddTaskBottomSheet extends StatefulWidget {
  final String timesheetId;
  final ProjectAssignmentEntity? editingTask;
  final int? editingIndex;
  final VoidCallback? onEditComplete;
  final String? activeIdOverride;
  final DateTime? selectedDate;

  const AddTaskBottomSheet({
    super.key,
    required this.timesheetId,
    this.editingTask,
    this.editingIndex,
    this.onEditComplete,
    this.activeIdOverride,
    this.selectedDate,
  });

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final _taskController = TextEditingController();
  final _expectedController = TextEditingController();
  final _actualController = TextEditingController();
  final _descriptionController = TextEditingController();
  ProjectEntity? _selectedProject;

  // Snapshot of original values when entering edit mode
  String? _originalTask;
  String? _originalDescription;
  String? _originalExpected;
  String? _originalActual;
  String? _originalProject;

  @override
  void initState() {
    super.initState();
    _prefillForm();
  }

  void _prefillForm() {
    if (widget.editingTask != null) {
      final task = widget.editingTask!;
      _taskController.text = task.taskData ?? '';
      _descriptionController.text = task.description ?? '';
      _expectedController.text = task.expectedHours.toString();
      _actualController.text = task.spentHours.toString();

      final projects = context.read<TimesheetBloc>().state.projects;

      ProjectEntity? matched;
      try {
        matched = projects.firstWhere((p) => p.projectName == task.project);
      } catch (_) {}

      _originalTask = task.taskData ?? '';
      _originalDescription = task.description ?? '';
      _originalExpected = task.expectedHours.toString();
      _originalActual = task.spentHours.toString();
      _originalProject = task.project;

      setState(() {
        _selectedProject = matched;
      });
    } else {
      _taskController.clear();
      _expectedController.clear();
      _actualController.clear();
      _descriptionController.clear();
      _originalTask = null;
      _originalDescription = null;
      _originalExpected = null;
      _originalActual = null;
      _originalProject = null;
      setState(() {
        _selectedProject = null;
      });
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

  bool _validateFields() {
    final l10n = AppLocalizations.of(context)!;

    if (_selectedProject == null) {
      ToastUtils.showError(l10n.selectProjectValidation);
      return false;
    }

    if (_taskController.text.trim().isEmpty) {
      ToastUtils.showError(l10n.taskValidation);
      return false;
    }

    if (_expectedController.text.trim().isEmpty) {
      ToastUtils.showError(l10n.expectedHoursValidation);
      return false;
    }

    if (_actualController.text.trim().isEmpty) {
      ToastUtils.showError(l10n.actualHoursValidation);
      return false;
    }

    if (_descriptionController.text.trim().isEmpty) {
      ToastUtils.showError(l10n.descriptionValidation);
      return false;
    }

    return true;
  }

  bool _hasChanges(TimesheetState state) {
    if (widget.editingTask == null) return true;

    final currentAttachment =
        state.uploadedFileUrl ?? widget.editingTask?.attachments ?? '';
    final originalAttachment = widget.editingTask?.attachments ?? '';
    final hasAttachmentChanged = currentAttachment != originalAttachment;

    return _taskController.text.trim() != (_originalTask ?? '') ||
        _descriptionController.text.trim() != (_originalDescription ?? '') ||
        _expectedController.text.trim() != (_originalExpected ?? '') ||
        _actualController.text.trim() != (_originalActual ?? '') ||
        (_selectedProject?.projectName ?? '') != (_originalProject ?? '') ||
        hasAttachmentChanged;
  }


  @override
  Widget build(BuildContext context) {
    return BlocListener<TimesheetBloc, TimesheetState>(
      listenWhen: (previous, current) => current.maybeMap(
        success: (s) =>
            s.successType == TimesheetSuccessType.taskAdded ||
            s.successType == TimesheetSuccessType.taskUpdated,
        orElse: () => false,
      ),
      listener: (context, state) {
        widget.onEditComplete?.call();
        // Automatically close the bottom sheet upon successful addition/modification
        Navigator.of(context).pop();
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.of(context).surfaceContainerLowest,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        ),
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Premium drag handle
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 8),
                  width: 36,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.of(
                      context,
                    ).outlineVariant.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Flexible(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                  child: BlocBuilder<TimesheetBloc, TimesheetState>(
                    builder: (context, state) {
                      final l10n = AppLocalizations.of(context)!;
                      final projects = state.projects;
                      final selectedDate = state.selectedDate ?? DateTime.now();
                      final isLoadingProjects =
                          projects.isEmpty &&
                          state.maybeMap(
                            loading: (_) => true,
                            orElse: () => false,
                          );

                      final attachment =
                          state.uploadedFileUrl ??
                          widget.editingTask?.attachments;
                      final selectedProjectName = _selectedProject?.projectName;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                width: 4,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: AppColors.of(context).primary,
                                  borderRadius: BorderRadius.circular(99),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  widget.editingTask != null
                                      ? l10n.updateTask
                                      : l10n.addNewTask,
                                  style: AppTextStyle.h3.copyWith(fontSize: 14),
                                ),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: AppColors.of(context).textSecondary,
                                  size: 20,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          StatLabel(
                            text: l10n.selectProject,
                            isMandatory: true,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              color: AppColors.of(
                                context,
                              ).surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value:
                                    projects.any(
                                      (p) =>
                                          p.projectName == selectedProjectName,
                                    )
                                    ? selectedProjectName
                                    : null,
                                isExpanded: true,
                                icon: isLoadingProjects
                                    ? const SizedBox(
                                        width: 20,
                                        height: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Icon(
                                        Icons.expand_more,
                                        color: AppColors.of(
                                          context,
                                        ).textSecondary,
                                      ),
                                hint: Text(
                                  isLoadingProjects
                                      ? l10n.loadingProjects
                                      : l10n.selectProject,
                                  style: AppTextStyle.bodyMedium,
                                ),
                                items: projects.map((p) {
                                  return DropdownMenuItem(
                                    value: p.projectName,
                                    child: Text(
                                      p.projectName,
                                      style: AppTextStyle.bodyMedium,
                                    ),
                                  );
                                }).toList(),
                                onChanged: isLoadingProjects
                                    ? null
                                    : (val) {
                                        if (val != null) {
                                          setState(() {
                                            _selectedProject = projects
                                                .firstWhere(
                                                  (p) => p.projectName == val,
                                                );
                                          });
                                        }
                                      },
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                          StatLabel(text: l10n.task, isMandatory: true),
                          TimesheetTextField(
                            controller: _taskController,
                            hint: l10n.taskHint,
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    StatLabel(
                                      text: l10n.expectedH,
                                      isMandatory: true,
                                    ),
                                    TimesheetTextField(
                                      controller: _expectedController,
                                      hint: "0.0",
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                            decimal: true,
                                          ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9.]'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    StatLabel(
                                      text: l10n.actualH,
                                      isMandatory: true,
                                    ),
                                    TimesheetTextField(
                                      controller: _actualController,
                                      hint: "0.0",
                                      keyboardType:
                                          const TextInputType.numberWithOptions(
                                            decimal: true,
                                          ),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                          RegExp(r'[0-9.]'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          StatLabel(
                            text: l10n.detailedDescription,
                            isMandatory: true,
                          ),
                          TimesheetTextField(
                            controller: _descriptionController,
                            hint: l10n.descriptionHint,
                            maxLines: 3,
                          ),
                          const SizedBox(height: 16),
                          StatLabel(text: l10n.supportingDocuments),
                          state.isUploading
                              ? const Center(child: CircularProgressIndicator())
                              : TimesheetUploadCard(
                                  onTap: () async {
                                    final timesheetBloc = context
                                        .read<TimesheetBloc>();
                                    final result = await FilePicker.platform
                                        .pickFiles(
                                          type: FileType.custom,
                                          allowedExtensions: [
                                            'pdf',
                                            'jpg',
                                            'png',
                                          ],
                                        );

                                    if (result != null) {
                                      final filePath = result.files.first.path!;
                                      timesheetBloc.add(
                                        TimesheetEvent.uploadFileRequested(
                                          filePath,
                                        ),
                                      );
                                    }
                                  },
                                ),
                          if ((attachment ?? "").isNotEmpty) ...[
                            const SizedBox(height: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.of(
                                  context,
                                ).surfaceContainerLow,
                              ),
                              child: Row(
                                children: [
                                  const Icon(Icons.attach_file, size: 18),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: Text(
                                      attachment!.split('/').last,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyle.bodySmall,
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close, size: 18),
                                    onPressed: () {
                                      context.read<TimesheetBloc>().add(
                                        const TimesheetEvent.clearUploadedFile(),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: state.isActionLoading
                                  ? null
                                  : () {
                                      FocusScope.of(context).unfocus();
                                      if (_validateFields()) {
                                        if (!_hasChanges(state)) {
                                          ToastUtils.showError(
                                            'No changes done',
                                          );
                                          return;
                                        }

                                        final newTask = ProjectAssignmentEntity(
                                          name: widget.editingTask?.name,
                                          project: _selectedProject?.projectName ??
                                              widget.editingTask?.project ??
                                              "",
                                          date: selectedDate.toIso8601String(),
                                          taskData: _taskController.text,
                                          description: _descriptionController.text,
                                          expectedHours: double.tryParse(
                                                  _expectedController.text) ??
                                              0.0,
                                          spentHours: double.tryParse(
                                                  _actualController.text) ??
                                              0.0,
                                          status: widget.editingTask?.status ??
                                              TimesheetStatus.draft,
                                          attachments: state.uploadedFileUrl ??
                                              widget.editingTask?.attachments,
                                        );

                                        context.read<TimesheetBloc>().add(
                                              TimesheetEvent.saveTaskRequested(
                                                task: newTask,
                                                timesheetId: widget.timesheetId,
                                              ),
                                            );
                                      }
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.of(
                                  context,
                                ).surfaceContainerHigh,
                                foregroundColor: AppColors.of(
                                  context,
                                ).textPrimary,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 14,
                                ),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: state.isActionLoading
                                  ? SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: AppColors.of(context).primary,
                                      ),
                                    )
                                  : Text(
                                      widget.editingTask != null
                                          ? l10n.updateTask
                                          : l10n.addToDay,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StatLabel extends StatelessWidget {
  final String text;
  final bool isMandatory;
  const StatLabel({super.key, required this.text, this.isMandatory = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 6),
      child: RichText(
        text: TextSpan(
          text: text.toUpperCase(),
          style: AppTextStyle.statsLabel.copyWith(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: AppColors.of(context).textPrimary,
          ),
          children: [
            if (isMandatory)
              TextSpan(
                text: AppConstants.mandatoryIndicator,
                style: AppTextStyle.labelSmall.copyWith(
                  color: AppColors.of(context).absentText,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class TimesheetTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  const TimesheetTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.keyboardType,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      inputFormatters: inputFormatters,
      maxLines: maxLines,
      keyboardType: keyboardType,
      style: AppTextStyle.bodyMedium,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyle.bodySmall.copyWith(
          color: AppColors.of(context).textSecondary.withValues(alpha: 0.5),
        ),
        filled: true,
        fillColor: AppColors.of(context).surfaceContainerHighest,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
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
          color: AppColors.of(context).surfaceContainerLow,
          borderRadius: BorderRadius.circular(12),
        ),
        child: CustomPaint(
          painter: _DashedRectPainter(
            color: AppColors.of(context).outlineVariant.withValues(alpha: 0.4),
          ),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Icon(
                  Icons.cloud_upload,
                  color: AppColors.of(context).primary,
                  size: 32,
                ),
                const SizedBox(height: 8),
                Text(
                  l10n.tapToBrowseFiles,
                  style: AppTextStyle.bodySmall.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  l10n.fileSizeLimit,
                  style: AppTextStyle.bodySmall.copyWith(fontSize: 10),
                ),
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
