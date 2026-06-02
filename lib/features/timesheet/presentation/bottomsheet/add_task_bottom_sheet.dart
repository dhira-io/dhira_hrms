import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_assignment_entity.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_bloc.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_event.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_state.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_status.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_success_type.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  static void show(
    BuildContext context, {
    required String timesheetId,
    ProjectAssignmentEntity? editingTask,
    int? editingIndex,
    VoidCallback? onEditComplete,
  }) {
    final timesheetBloc = context.read<TimesheetBloc>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.of(context).transparent,
      builder: (bottomSheetContext) {
        return BlocProvider.value(
          value: timesheetBloc,
          child: AddTaskBottomSheet(
            timesheetId: timesheetId,
            editingTask: editingTask,
            editingIndex: editingIndex,
            onEditComplete: onEditComplete ?? () => timesheetBloc.add(const TimesheetEvent.editTaskCleared()),
            activeIdOverride: timesheetBloc.state.currentWeekActiveId,
          ),
        );
      },
    ).then((_) {
      timesheetBloc.add(const TimesheetEvent.editTaskCleared());
    });
  }

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final _taskController = TextEditingController();
  final _expectedController = TextEditingController();
  final _actualController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final state = context.read<TimesheetBloc>().state;
    _taskController.text = state.formTaskData;
    _descriptionController.text = state.formDescription;
    _expectedController.text = state.formExpectedHours;
    _actualController.text = state.formSpentHours;

    _taskController.addListener(_onTaskChanged);
    _descriptionController.addListener(_onDescriptionChanged);
    _expectedController.addListener(_onExpectedChanged);
    _actualController.addListener(_onActualChanged);
  }

  void _onTaskChanged() {
    context.read<TimesheetBloc>().add(
      TimesheetEvent.formTaskDataChanged(_taskController.text),
    );
  }

  void _onDescriptionChanged() {
    context.read<TimesheetBloc>().add(
      TimesheetEvent.formDescriptionChanged(_descriptionController.text),
    );
  }

  void _onExpectedChanged() {
    context.read<TimesheetBloc>().add(
      TimesheetEvent.formExpectedHoursChanged(_expectedController.text),
    );
  }

  void _onActualChanged() {
    context.read<TimesheetBloc>().add(
      TimesheetEvent.formSpentHoursChanged(_actualController.text),
    );
  }

  @override
  void dispose() {
    _taskController.removeListener(_onTaskChanged);
    _descriptionController.removeListener(_onDescriptionChanged);
    _expectedController.removeListener(_onExpectedChanged);
    _actualController.removeListener(_onActualChanged);

    _taskController.dispose();
    _expectedController.dispose();
    _actualController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TimesheetBloc, TimesheetState>(
      listenWhen: (previous, current) =>
          (current.status == TimesheetStateStatus.success &&
              (current.successType == TimesheetSuccessType.taskAdded ||
                  current.successType == TimesheetSuccessType.taskUpdated)) ||
          previous.formTaskData != current.formTaskData ||
          previous.formDescription != current.formDescription ||
          previous.formExpectedHours != current.formExpectedHours ||
          previous.formSpentHours != current.formSpentHours,
      listener: (context, state) {
        if (state.status == TimesheetStateStatus.success &&
            (state.successType == TimesheetSuccessType.taskAdded ||
                state.successType == TimesheetSuccessType.taskUpdated)) {
          widget.onEditComplete?.call();
          // Automatically close the bottom sheet upon successful addition/modification
          Navigator.of(context).pop();
          return;
        }

        // Synchronize controllers if state changes externally (e.g., cleared/reset)
        // Avoid setting text when it matches to prevent resetting cursor position during active typing
        if (state.formTaskData != _taskController.text) {
          _taskController.value = _taskController.value.copyWith(
            text: state.formTaskData,
            selection: TextSelection.collapsed(
              offset: state.formTaskData.length,
            ),
          );
        }
        if (state.formDescription != _descriptionController.text) {
          _descriptionController.value = _descriptionController.value.copyWith(
            text: state.formDescription,
            selection: TextSelection.collapsed(
              offset: state.formDescription.length,
            ),
          );
        }
        if (state.formExpectedHours != _expectedController.text) {
          _expectedController.value = _expectedController.value.copyWith(
            text: state.formExpectedHours,
            selection: TextSelection.collapsed(
              offset: state.formExpectedHours.length,
            ),
          );
        }
        if (state.formSpentHours != _actualController.text) {
          _actualController.value = _actualController.value.copyWith(
            text: state.formSpentHours,
            selection: TextSelection.collapsed(
              offset: state.formSpentHours.length,
            ),
          );
        }
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        behavior: HitTestBehavior.opaque,
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
                      final isLoadingProjects =
                          projects.isEmpty &&
                          state.status == TimesheetStateStatus.loading;

                      final attachment =
                          state.uploadedFileUrl ??
                          widget.editingTask?.attachments;
                      final selectedProjectName =
                          state.formSelectedProject?.projectName;

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
                                          final matched = projects.firstWhere(
                                            (p) => p.projectName == val,
                                          );
                                          context.read<TimesheetBloc>().add(
                                            TimesheetEvent.formProjectChanged(
                                              matched,
                                            ),
                                          );
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
                                  onTap: () {
                                    context.read<TimesheetBloc>().add(
                                      const TimesheetEvent.pickAndUploadFileRequested(),
                                    );
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
                                      context.read<TimesheetBloc>().add(
                                        TimesheetEvent.saveTaskRequested(
                                          timesheetId: widget.timesheetId,
                                        ),
                                      );
                                    },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.of(context).primary,
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
                                        color: AppColors.of(context).white,
                                      ),
                                    )
                                  : Text(
                                      widget.editingTask != null
                                          ? l10n.updateTask
                                          : l10n.addToDay,
                                      style: AppTextStyle.button,
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
