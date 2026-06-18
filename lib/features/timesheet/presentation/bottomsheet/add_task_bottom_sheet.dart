import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/widgets/common_button.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:intl/intl.dart';
import 'package:dhira_hrms/features/timesheet/domain/entities/project_assignment_entity.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_bloc.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_event.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_state.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_status.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_success_type.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/core/widgets/shimmer_loading.dart';
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
            onEditComplete:
                onEditComplete ??
                () => timesheetBloc.add(const TimesheetEvent.editTaskCleared()),
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
            borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
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
                    margin: EdgeInsets.only(top: 12.h, bottom: 8.h),
                    width: 36.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: AppColors.of(
                        context,
                      ).outlineVariant.withValues(alpha: 0.4),
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                    child: BlocBuilder<TimesheetBloc, TimesheetState>(
                      buildWhen: (previous, current) =>
                          previous.projects != current.projects ||
                          previous.status != current.status ||
                          previous.selectedDate != current.selectedDate ||
                          previous.uploadedFileUrl != current.uploadedFileUrl ||
                          previous.formSelectedProject !=
                              current.formSelectedProject ||
                          previous.assignmentsForSelectedDay !=
                              current.assignmentsForSelectedDay,
                      builder: (context, state) {
                        final l10n = AppLocalizations.of(context)!;
                        final projects = state.projects;
                        final isLoadingProjects =
                            projects.isEmpty &&
                            state.status == TimesheetStateStatus.loading;

                        final selectedDate =
                            state.selectedDate ?? DateTime.now();
                        final isFutureDay = DateTimeUtils.isFutureDay(
                          selectedDate,
                        );

                        final attachment =
                            state.uploadedFileUrl ??
                            widget.editingTask?.attachments;
                        final selectedProjectName =
                            state.formSelectedProject?.projectName;

                        final int taskNumber;
                        if (widget.editingTask != null) {
                          final indexInSelectedDay = state
                              .assignmentsForSelectedDay
                              .indexOf(widget.editingTask!);
                          if (indexInSelectedDay != -1) {
                            taskNumber = indexInSelectedDay + 1;
                          } else if (widget.editingIndex != null) {
                            taskNumber = widget.editingIndex! + 1;
                          } else {
                            taskNumber = 1;
                          }
                        } else {
                          taskNumber =
                              state.assignmentsForSelectedDay.length + 1;
                        }

                        final formattedDate = DateFormat(
                          'dd EEEE, MMMM',
                        ).format(selectedDate);

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.editingTask != null
                                            ? l10n.updateTask
                                            : l10n.addingNewTask,
                                        style: AppTextStyle.h3.copyWith(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.of(context).slate900,
                                        ),
                                      ),
                                      SizedBox(height: 2.h),
                                      Text(
                                        'Task $taskNumber, $formattedDate',
                                        style: AppTextStyle.bodySmall.copyWith(
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w400,
                                          color: AppColors.of(context).slate500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: AppColors.of(context).slate900,
                                    size: 20,
                                  ),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(),
                                  onPressed: () => Navigator.of(context).pop(),
                                ),
                              ],
                            ),
                            SizedBox(height: 12.h),
                            StatLabel(text: l10n.project, isMandatory: true),
                            Container(
                              height: 40.h,
                              padding: EdgeInsets.symmetric(horizontal: 12.w),
                              decoration: BoxDecoration(
                                color: AppColors.of(context).white,
                                borderRadius: BorderRadius.circular(6.r),
                                border: Border.all(
                                  color: AppColors.of(context).tableBorder,
                                  width: 1.w,
                                ),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value:
                                      projects.any(
                                        (p) =>
                                            p.projectName ==
                                            selectedProjectName,
                                      )
                                      ? selectedProjectName
                                      : null,
                                  isExpanded: true,
                                  icon: isLoadingProjects
                                      ? SizedBox(
                                          width: 16.w,
                                          height: 16.h,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 1.5,
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                                  AppColors.of(
                                                    context,
                                                  ).slate500,
                                                ),
                                          ),
                                        )
                                      : Icon(
                                          Icons.expand_more,
                                          color: AppColors.of(context).slate900,
                                          size: 16,
                                        ),
                                  hint: Text(
                                    isLoadingProjects
                                        ? l10n.loadingProjects
                                        : l10n.selectProject,
                                    style: AppTextStyle.bodyMedium.copyWith(
                                      fontSize: 12.sp,
                                      color: AppColors.of(
                                        context,
                                      ).slate500.withValues(alpha: 0.5),
                                    ),
                                  ),
                                  items: projects.map((p) {
                                    return DropdownMenuItem(
                                      value: p.projectName,
                                      child: Text(
                                        p.projectName,
                                        style: AppTextStyle.bodyMedium.copyWith(
                                          fontSize: 12.sp,
                                          color: AppColors.of(context).slate900,
                                        ),
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
                            SizedBox(height: 12.h),
                            StatLabel(text: l10n.taskLabel, isMandatory: true),
                            TimesheetTextField(
                              controller: _taskController,
                              hint: l10n.enterTaskName,
                            ),
                            SizedBox(height: 12.h),
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      StatLabel(
                                        text: l10n.expectedHrsLabel,
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
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      StatLabel(
                                        text: l10n.actualHrsLabel,
                                        isMandatory: !isFutureDay,
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
                            SizedBox(height: 12.h),
                            StatLabel(
                              text: l10n.descriptionLabel,
                              isMandatory: true,
                            ),
                            TimesheetTextField(
                              controller: _descriptionController,
                              hint: l10n.brieflyDescribeWhatYouWorkedOn,
                              maxLines: 3,
                            ),
                            SizedBox(height: 12.h),
                            StatLabel(text: l10n.supportingDocumentLabel),
                            BlocSelector<TimesheetBloc, TimesheetState, bool>(
                              selector: (state) => state.isUploading,
                              builder: (context, isUploading) {
                                return isUploading
                                    ? ShimmerLoading(
                                        height: 60.h,
                                        width: double.infinity,
                                        borderRadius: 14.r,
                                      )
                                    : TimesheetUploadCard(
                                        onTap: () {
                                          context.read<TimesheetBloc>().add(
                                            const TimesheetEvent.pickAndUploadFileRequested(),
                                          );
                                        },
                                      );
                              },
                            ),
                            if ((attachment ?? "").isNotEmpty) ...[
                              SizedBox(height: 8.h),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.w,
                                  vertical: 10.h,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  color: AppColors.of(
                                    context,
                                  ).surfaceContainerLow,
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.attach_file, size: 18),
                                    SizedBox(width: 8.w),
                                    Expanded(
                                      child: Text(
                                        attachment!.split('/').last,
                                        overflow: TextOverflow.ellipsis,
                                        style: AppTextStyle.bodySmall.copyWith(
                                          color: AppColors.of(context).slate900,
                                        ),
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
                            SizedBox(height: 24.h),
                            Row(
                              children: [
                                Expanded(
                                  child: SizedBox(
                                    height: 40.h,
                                    child: CommonButton(
                                      text: l10n.cancel,
                                      variant: ButtonVariant.outlined,
                                      backgroundColor: AppColors.of(
                                        context,
                                      ).white,
                                      foregroundColor: AppColors.of(
                                        context,
                                      ).slate900,
                                      borderRadius: 8.r,
                                      padding: EdgeInsets.symmetric(
                                        vertical: 10.h,
                                      ),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: SizedBox(
                                    height: 40.h,
                                    child:
                                        BlocSelector<
                                          TimesheetBloc,
                                          TimesheetState,
                                          bool
                                        >(
                                          selector: (state) =>
                                              state.isActionLoading,
                                          builder: (context, isActionLoading) {
                                            return CommonButton(
                                              text: l10n.save,
                                              variant: ButtonVariant.primary,
                                              backgroundColor: AppColors.of(
                                                context,
                                              ).primaryContainer,
                                              foregroundColor: AppColors.of(
                                                context,
                                              ).slate50,
                                              borderRadius: 8.r,
                                              padding: EdgeInsets.symmetric(
                                                vertical: 10.h,
                                              ),
                                              isLoading: isActionLoading,
                                              onPressed: () {
                                                FocusScope.of(
                                                  context,
                                                ).unfocus();
                                                context.read<TimesheetBloc>().add(
                                                  TimesheetEvent.saveTaskRequested(
                                                    timesheetId:
                                                        widget.timesheetId,
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                  ),
                                ),
                              ],
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
      padding: EdgeInsets.only(left: 4.w, bottom: 4.h),
      child: RichText(
        text: TextSpan(
          text: text,
          style: AppTextStyle.bodySmall.copyWith(
            fontSize: 11.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.of(context).slate900,
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
      style: AppTextStyle.bodyMedium.copyWith(
        fontSize: 12.sp,
        color: AppColors.of(context).slate900,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyle.bodySmall.copyWith(
          fontSize: 12.sp,
          color: AppColors.of(context).slate500.withValues(alpha: 0.5),
        ),
        filled: true,
        fillColor: AppColors.of(context).white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: BorderSide(
            color: AppColors.of(context).tableBorder,
            width: 1.w,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: BorderSide(
            color: AppColors.of(context).primaryContainer,
            width: 1.w,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6.r),
          borderSide: BorderSide(
            color: AppColors.of(context).tableBorder,
            width: 1.w,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
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
      child: CustomPaint(
        painter: _DashedRectPainter(
          color: AppColors.of(context).tableBorder,
          fillColor: AppColors.of(context).white,
          strokeWidth: 1.w,
          radius: 14.r,
          dashWidth: 4.w,
          dashSpace: 4.w,
        ),
        child: Container(
          width: double.infinity,
          height: 100.h,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(color: AppColors.of(context).transparent),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.attach_file,
                color: AppColors.of(context).slate500,
                size: 20,
              ),
              SizedBox(height: 8.h),
              Text(
                l10n.selectAnyFileToUpload,
                style: AppTextStyle.bodySmall.copyWith(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.of(context).slate500,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                l10n.pdfJpgPngLimit,
                style: AppTextStyle.bodySmall.copyWith(
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.of(context).slate500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DashedRectPainter extends CustomPainter {
  final Color color;
  final Color fillColor;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double radius;

  _DashedRectPainter({
    required this.color,
    required this.fillColor,
    this.strokeWidth = 1,
    this.dashWidth = 4,
    this.dashSpace = 4,
    this.radius = 14,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final fillPaint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(radius),
    );

    // 1. Draw fill background first
    canvas.drawRRect(rrect, fillPaint);

    // 2. Draw dashed outline
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.addRRect(rrect);

    final dashPath = Path();
    double distance = 0.0;
    for (final pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        final double len = dashWidth;
        final double nextDistance = distance + len;
        final double drawLength = nextDistance < pathMetric.length
            ? len
            : pathMetric.length - distance;
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + drawLength),
          Offset.zero,
        );
        distance += len + dashSpace;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
