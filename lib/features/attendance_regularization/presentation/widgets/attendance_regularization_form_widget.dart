import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/attendance_regularization/presentation/bloc/attendance_regularization_bloc.dart';
import 'package:dhira_hrms/features/attendance_regularization/presentation/bloc/attendance_regularization_event.dart';
import 'package:dhira_hrms/features/attendance_regularization/presentation/bloc/attendance_regularization_state.dart';
import 'package:dhira_hrms/features/attendance_regularization/domain/entities/attendance_regularization_constants.dart';
import 'package:dhira_hrms/core/widgets/shimmer_loading.dart';

class RegularizationFormConfig {
  final TextEditingController reasonController;
  final VoidCallback onPickFile;
  final VoidCallback onRemoveFile;

  const RegularizationFormConfig({
    required this.reasonController,
    required this.onPickFile,
    required this.onRemoveFile,
  });
}

class AttendanceRegularizationFormWidget extends StatelessWidget {
  final RegularizationFormConfig config;

  const AttendanceRegularizationFormWidget({super.key, required this.config});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeColors = AppColors.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: themeColors.slate100,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: themeColors.tableBorder, width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. Date Selector
          AttendanceRegularizationFormLabel(label: l10n.date, isRequired: true),
          SizedBox(height: 4.h),
          BlocSelector<
            AttendanceRegularizationBloc,
            AttendanceRegularizationState,
            DateTime?
          >(
            selector: (state) => state.formData.date,
            builder: (context, selectedDate) {
              final dateText = selectedDate != null
                  ? DateTimeUtils.formatDate(
                      selectedDate,
                      pattern: DateTimeUtils.patternDayMonthYearShortSlash,
                    )
                  : l10n.dateFormatPlaceholder;
              return InkWell(
                onTap: () => _selectDate(context, selectedDate),
                child: Container(
                  height: 34.h,
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: themeColors.white,
                    borderRadius: BorderRadius.circular(4.r),
                    border: Border.all(color: themeColors.slate300, width: 1.w),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          dateText,
                          style: AppTextStyle.bodyMedium.copyWith(
                            color: selectedDate != null
                                ? themeColors.textPrimary
                                : themeColors.slateText,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 14.r,
                        color: selectedDate != null
                            ? themeColors.textPrimary
                            : themeColors.slate400,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 10.h),

          // 2. Reason Type Buttons
          AttendanceRegularizationFormLabel(
            label: l10n.reasonType,
            isRequired: true,
          ),
          SizedBox(height: 4.h),
          BlocSelector<
            AttendanceRegularizationBloc,
            AttendanceRegularizationState,
            AttendanceRegularizationRequestType
          >(
            selector: (state) => state.formData.requestType,
            builder: (context, selectedType) {
              return AttendanceRegularizationReasonTypesSection(
                selectedType: selectedType,
              );
            },
          ),
          SizedBox(height: 10.h),

          // 3. Clock In Time (derived and editable)
          BlocSelector<
            AttendanceRegularizationBloc,
            AttendanceRegularizationState,
            (TimeOfDay?, bool)
          >(
            selector: (state) =>
                (state.formData.inTime, state.formData.isPunchSummaryLoading),
            builder: (context, data) {
              return AttendanceRegularizationTimeSelector(
                label: l10n.clockInTime,
                time: data.$1,
                isLoading: data.$2,
                isClockIn: true,
                onSelectTime: _selectTime,
              );
            },
          ),
          SizedBox(height: 10.h),

          // 4. Clock Out Time (derived and editable)
          BlocSelector<
            AttendanceRegularizationBloc,
            AttendanceRegularizationState,
            (TimeOfDay?, bool)
          >(
            selector: (state) =>
                (state.formData.outTime, state.formData.isPunchSummaryLoading),
            builder: (context, data) {
              return AttendanceRegularizationTimeSelector(
                label: l10n.clockOutTime,
                time: data.$1,
                isLoading: data.$2,
                isClockIn: false,
                onSelectTime: _selectTime,
              );
            },
          ),
          SizedBox(height: 10.h),

          // 5. Route to HR Checkbox Card
          BlocSelector<
            AttendanceRegularizationBloc,
            AttendanceRegularizationState,
            bool
          >(
            selector: (state) => state.formData.routeToHR,
            builder: (context, routeToHR) {
              return AttendanceRegularizationRouteToHRCard(
                routeToHR: routeToHR,
              );
            },
          ),
          SizedBox(height: 10.h),

          // 6. Reason input field
          AttendanceRegularizationFormLabel(
            label: l10n.reason,
            isRequired: true,
          ),
          SizedBox(height: 4.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: themeColors.white,
              borderRadius: BorderRadius.circular(4.r),
              border: Border.all(color: themeColors.slate300, width: 1.w),
            ),
            child: TextField(
              controller: config.reasonController,
              maxLines: 4,
              maxLength: 200,
              style: AppTextStyle.titleSmallOne.copyWith(
                color: themeColors.textPrimary,
              ),
              decoration: InputDecoration(
                filled: false,
                fillColor: Colors.transparent,
                hintText: l10n.reasonRegularizationHint,
                hintStyle: AppTextStyle.labelMedium.copyWith(
                  color: themeColors.slate500Confirmation,
                ),
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                counterText: '',
              ),
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            l10n.reasonMinCharacters,
            style: AppTextStyle.bodySmallTwo.copyWith(
              color: themeColors.textSecondary,
            ),
          ),
          SizedBox(height: 10.h),

          // 7. Supporting Document
          BlocSelector<
            AttendanceRegularizationBloc,
            AttendanceRegularizationState,
            (String?, String?, bool)
          >(
            selector: (state) => (
              state.formData.selectedFileName,
              state.formData.uploadedFileUrl,
              state.isUploading,
            ),
            builder: (context, data) {
              return AttendanceRegularizationAttachmentSection(
                fileName: data.$1,
                fileUrl: data.$2,
                isUploading: data.$3,
                onPickFile: config.onPickFile,
                onRemoveFile: config.onRemoveFile,
              );
            },
          ),
        ],
      ),
    );
  }
}

Future<void> _selectDate(BuildContext context, DateTime? initialDate) async {
  final selected = await showDatePicker(
    context: context,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: DateTime.now().subtract(const Duration(days: 365)),
    lastDate: DateTime.now().add(const Duration(days: 365)),
  );
  if (selected != null && context.mounted) {
    context.read<AttendanceRegularizationBloc>().add(
      AttendanceRegularizationEvent.dateChanged(selected),
    );
  }
}

Future<void> _selectTime(
  BuildContext context,
  TimeOfDay? initialTime, {
  required bool isClockIn,
}) async {
  final selected = await showTimePicker(
    context: context,
    initialTime: initialTime ?? const TimeOfDay(hour: 9, minute: 0),
  );
  if (selected != null && context.mounted) {
    final bloc = context.read<AttendanceRegularizationBloc>();
    if (isClockIn) {
      bloc.add(AttendanceRegularizationEvent.inTimeChanged(selected));
    } else {
      bloc.add(AttendanceRegularizationEvent.outTimeChanged(selected));
    }
  }
}

class AttendanceRegularizationFormLabel extends StatelessWidget {
  final String label;
  final bool isRequired;

  const AttendanceRegularizationFormLabel({
    super.key,
    required this.label,
    this.isRequired = false,
  });

  @override
  Widget build(BuildContext context) {
    final themeColors = AppColors.of(context);
    return RichText(
      text: TextSpan(
        text: label,
        style: AppTextStyle.titleSmallOne.copyWith(
          color: themeColors.textPrimary,
        ),
        children: isRequired
            ? [
                TextSpan(
                  text: ' *',
                  style: AppTextStyle.headingSmallThree.copyWith(
                    color: themeColors.error,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ]
            : null,
      ),
    );
  }
}

class AttendanceRegularizationReasonTypeButton extends StatelessWidget {
  final AttendanceRegularizationRequestType type;
  final String label;
  final bool isSelected;

  const AttendanceRegularizationReasonTypeButton({
    super.key,
    required this.type,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final themeColors = AppColors.of(context);
    return InkWell(
      onTap: () {
        context.read<AttendanceRegularizationBloc>().add(
          AttendanceRegularizationEvent.requestTypeChanged(type),
        );
      },
      child: Container(
        height: 34.h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? themeColors.blue50 : themeColors.white,
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(
            color: isSelected ? themeColors.primary : themeColors.slateBorder,
            width: 1.w,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: AppTextStyle.titleSmallOne.copyWith(
            color: isSelected ? themeColors.primary : themeColors.textPrimary,
          ),
        ),
      ),
    );
  }
}

class AttendanceRegularizationReasonTypesSection extends StatelessWidget {
  final AttendanceRegularizationRequestType selectedType;

  const AttendanceRegularizationReasonTypesSection({
    super.key,
    required this.selectedType,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AttendanceRegularizationReasonTypeButton(
                type: AttendanceRegularizationRequestType.missedPunch,
                label: l10n.missedPunch,
                isSelected:
                    selectedType ==
                    AttendanceRegularizationRequestType.missedPunch,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: AttendanceRegularizationReasonTypeButton(
                type: AttendanceRegularizationRequestType.systemError,
                label: l10n.systemError,
                isSelected:
                    selectedType ==
                    AttendanceRegularizationRequestType.systemError,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: AttendanceRegularizationReasonTypeButton(
                type: AttendanceRegularizationRequestType.networkIssues,
                label: l10n.networkIssues,
                isSelected:
                    selectedType ==
                    AttendanceRegularizationRequestType.networkIssues,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: AttendanceRegularizationReasonTypeButton(
                type: AttendanceRegularizationRequestType.onFieldDuty,
                label: l10n.onFieldDuty,
                isSelected:
                    selectedType ==
                    AttendanceRegularizationRequestType.onFieldDuty,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class AttendanceRegularizationTimeSelector extends StatelessWidget {
  final String label;
  final TimeOfDay? time;
  final bool isLoading;
  final bool isClockIn;
  final Future<void> Function(
    BuildContext,
    TimeOfDay?, {
    required bool isClockIn,
  })
  onSelectTime;

  const AttendanceRegularizationTimeSelector({
    super.key,
    required this.label,
    required this.time,
    required this.isLoading,
    required this.isClockIn,
    required this.onSelectTime,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeColors = AppColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AttendanceRegularizationFormLabel(label: label, isRequired: true),
        SizedBox(height: 4.h),
        if (isLoading)
          ShimmerLoading(
            height: 34.h,
            width: double.infinity,
            borderRadius: 4.r,
          )
        else
          InkWell(
            onTap: () => onSelectTime(context, time, isClockIn: isClockIn),
            child: Container(
              height: 34.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: themeColors.white,
                borderRadius: BorderRadius.circular(4.r),
                border: Border.all(color: themeColors.slateBorder, width: 1.w),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      time != null
                          ? time!.format(context)
                          : l10n.timeFormatPlaceholder,
                      style: AppTextStyle.bodyMedium.copyWith(
                        color: time != null
                            ? themeColors.textPrimary
                            : themeColors.slate400,
                        fontWeight: time != null
                            ? FontWeight.w500
                            : FontWeight.w300,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.access_time_rounded,
                    size: 14.r,
                    color: themeColors.slate950,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class AttendanceRegularizationRouteToHRCard extends StatelessWidget {
  final bool routeToHR;

  const AttendanceRegularizationRouteToHRCard({
    super.key,
    required this.routeToHR,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeColors = AppColors.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: () {
        context.read<AttendanceRegularizationBloc>().add(
          AttendanceRegularizationEvent.routeToHRChanged(!routeToHR),
        );
      },
      child: Container(
        height: 40.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 3.h),
        decoration: BoxDecoration(
          color: isDark ? themeColors.infoBg : themeColors.blue50,
          borderRadius: BorderRadius.circular(4.r),
          border: Border.all(color: themeColors.tableBorder, width: 1.w),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 15.w,
              height: 15.w,
              decoration: BoxDecoration(
                color: routeToHR ? themeColors.primary : themeColors.white,
                borderRadius: BorderRadius.circular(2.r),
                border: Border.all(color: themeColors.primary, width: 1.w),
              ),
              child: routeToHR
                  ? Icon(Icons.check, size: 8.r, color: AppColors.white)
                  : null,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    l10n.routeToHRDepartment,
                    style: AppTextStyle.labelLarge.copyWith(
                      color: themeColors.textPrimary,
                    ),
                  ),
                  Text(
                    l10n.routeToHRDepartmentSub,
                    style: AppTextStyle.bodyMediumOne.copyWith(
                      color: isDark
                          ? themeColors.textSecondary
                          : themeColors.slate500Confirmation,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AttendanceRegularizationAttachmentSection extends StatelessWidget {
  final String? fileName;
  final String? fileUrl;
  final bool isUploading;
  final VoidCallback onPickFile;
  final VoidCallback onRemoveFile;

  const AttendanceRegularizationAttachmentSection({
    super.key,
    required this.fileName,
    required this.fileUrl,
    required this.isUploading,
    required this.onPickFile,
    required this.onRemoveFile,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final themeColors = AppColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.supportingDocOptional,
          style: AppTextStyle.titleSmallOne.copyWith(
            color: themeColors.textPrimary,
          ),
        ),
        SizedBox(height: 4.h),
        if (isUploading)
          ShimmerLoading(
            height: 34.h,
            width: double.infinity,
            borderRadius: 4.r,
          )
        else if (fileUrl != null)
          Container(
            height: 34.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: BoxDecoration(
              color: themeColors.white,
              borderRadius: BorderRadius.circular(6.r),
              border: Border.all(color: themeColors.slate300, width: 1.w),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.attach_file_rounded,
                  size: 14.r,
                  color: themeColors.primary,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    fileName ?? l10n.documentPdf,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.bodySmall.copyWith(
                      color: themeColors.primary,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onRemoveFile,
                  icon: Icon(
                    Icons.cancel_rounded,
                    size: 14.r,
                    color: themeColors.textSecondary,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
          )
        else
          InkWell(
            onTap: onPickFile,
            child: Container(
              height: 34.h,
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              decoration: BoxDecoration(
                color: themeColors.white,
                borderRadius: BorderRadius.circular(6.r),
                border: Border.all(color: themeColors.slate300, width: 1.w),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.attach_file_rounded,
                    size: 14.r,
                    color: themeColors.primary,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    l10n.attachDocument,
                    style: AppTextStyle.bodySmall.copyWith(
                      color: themeColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
