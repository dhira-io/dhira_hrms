import 'dart:async';

import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/toast_utils.dart';
import 'package:dhira_hrms/features/attendance/domain/entities/regularization_constants.dart';
import 'package:dhira_hrms/features/attendance/presentation/bloc/attendance_regularization_bloc.dart';
import 'package:dhira_hrms/features/attendance/presentation/bloc/attendance_regularization_event.dart';
import 'package:dhira_hrms/features/attendance/presentation/bloc/attendance_regularization_state.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'attendance_regularization_empty_widget.dart';
import 'attendance_regularization_loading_widget.dart';

class AttendanceRegularizationBody extends StatefulWidget {
  const AttendanceRegularizationBody({super.key});

  @override
  State<AttendanceRegularizationBody> createState() =>
      _AttendanceRegularizationBodyState();
}

class _AttendanceRegularizationBodyState
    extends State<AttendanceRegularizationBody> {
  final TextEditingController _reasonController = TextEditingController();
  Timer? _reasonDebounce;

  @override
  void initState() {
    super.initState();
    _reasonController.addListener(_onReasonChanged);
  }

  @override
  void dispose() {
    _reasonDebounce?.cancel();
    _reasonController.dispose();
    super.dispose();
  }

  void _onReasonChanged() {
    _reasonDebounce?.cancel();
    _reasonDebounce = Timer(const Duration(milliseconds: 220), () {
      if (!mounted) return;
      context.read<AttendanceRegularizationBloc>().add(
        AttendanceRegularizationEvent.reasonChanged(_reasonController.text),
      );
    });
  }

  Future<void> _pickFile() async {
    FocusManager.instance.primaryFocus?.unfocus();
    final l10n = AppLocalizations.of(context)!;
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf', 'png', 'jpg', 'jpeg'],
    );
    if (!mounted || result == null) return;

    final file = result.files.first;
    if (file.path == null) return;
    if (file.size > AppConstants.maxAttachmentBytes) {
      ToastUtils.showError(l10n.fileSizeError(10));
      return;
    }

    context.read<AttendanceRegularizationBloc>().add(
      AttendanceRegularizationEvent.uploadFileRequested(
        filePath: file.path!,
        fileName: file.name,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceRegularizationBloc, AttendanceRegularizationState>(
      builder: (context, state) {
        final isSubmitting = state.maybeWhen(
          loading: (_, kind) => kind == RegularizationLoadingKind.submit,
          orElse: () => false,
        );
        final isUploading = state.maybeWhen(
          loading: (_, kind) => kind == RegularizationLoadingKind.upload,
          orElse: () => false,
        );

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 18.h),
                child: _RegularizationFormCard(
                  formData: state.formData,
                  reasonController: _reasonController,
                  isUploading: isUploading,
                  actions: _RegularizationFormActions(
                    onDateChanged: (date) => context
                        .read<AttendanceRegularizationBloc>()
                        .add(AttendanceRegularizationEvent.dateChanged(date)),
                    onRequestTypeChanged: (type) => context
                        .read<AttendanceRegularizationBloc>()
                        .add(
                          AttendanceRegularizationEvent.requestTypeChanged(type),
                        ),
                    onInTimeChanged: (time) => context
                        .read<AttendanceRegularizationBloc>()
                        .add(AttendanceRegularizationEvent.inTimeChanged(time)),
                    onOutTimeChanged: (time) => context
                        .read<AttendanceRegularizationBloc>()
                        .add(AttendanceRegularizationEvent.outTimeChanged(time)),
                    onRouteToHrChanged: (value) => context
                        .read<AttendanceRegularizationBloc>()
                        .add(
                          AttendanceRegularizationEvent.routeToHRChanged(value),
                        ),
                    onPickFile: _pickFile,
                    onRemoveFile: () => context
                        .read<AttendanceRegularizationBloc>()
                        .add(const AttendanceRegularizationEvent.fileRemoved()),
                  ),
                ),
              ),
            ),
            _BottomActionBar(
              enabled: state.formData.canContinue && !isSubmitting,
              isSubmitting: isSubmitting,
              onNext: () => context.read<AttendanceRegularizationBloc>().add(
                const AttendanceRegularizationEvent.submitRequested(),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _RegularizationFormActions {
  final ValueChanged<DateTime> onDateChanged;
  final ValueChanged<RegularizationRequestType> onRequestTypeChanged;
  final ValueChanged<TimeOfDay?> onInTimeChanged;
  final ValueChanged<TimeOfDay?> onOutTimeChanged;
  final ValueChanged<bool> onRouteToHrChanged;
  final VoidCallback onPickFile;
  final VoidCallback onRemoveFile;

  const _RegularizationFormActions({
    required this.onDateChanged,
    required this.onRequestTypeChanged,
    required this.onInTimeChanged,
    required this.onOutTimeChanged,
    required this.onRouteToHrChanged,
    required this.onPickFile,
    required this.onRemoveFile,
  });
}

class _RegularizationFormCard extends StatelessWidget {
  final RegularizationFormData formData;
  final TextEditingController reasonController;
  final bool isUploading;
  final _RegularizationFormActions actions;

  const _RegularizationFormCard({
    required this.formData,
    required this.reasonController,
    required this.isUploading,
    required this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: colors.slate100,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: colors.tableBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _DateField(value: formData.date, onChanged: actions.onDateChanged),
          SizedBox(height: 13.h),
          _ReasonTypeGrid(
            selectedType: formData.requestType,
            onChanged: actions.onRequestTypeChanged,
          ),
          SizedBox(height: 13.h),
          _TimeField(
            label: l10n.clockInTime,
            value: formData.inTime,
            onChanged: actions.onInTimeChanged,
          ),
          SizedBox(height: 13.h),
          _TimeField(
            label: l10n.clockOutTime,
            value: formData.outTime,
            onChanged: actions.onOutTimeChanged,
          ),
          SizedBox(height: 13.h),
          _HrRouteTile(
            value: formData.routeToHR,
            onChanged: actions.onRouteToHrChanged,
          ),
          SizedBox(height: 13.h),
          _ReasonField(controller: reasonController),
          SizedBox(height: 13.h),
          _DocumentPicker(
            fileName: formData.selectedFileName,
            isUploading: isUploading,
            onPickFile: actions.onPickFile,
            onRemoveFile: actions.onRemoveFile,
          ),
          if (formData.isPunchSummaryLoading) ...[
            SizedBox(height: 13.h),
            const AttendanceRegularizationLoadingWidget(),
          ] else if (formData.date != null && formData.punchSummary == null) ...[
            SizedBox(height: 13.h),
            const AttendanceRegularizationEmptyWidget(),
          ],
        ],
      ),
    );
  }
}

class _RequiredLabel extends StatelessWidget {
  final String label;

  const _RequiredLabel(this.label);

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: label,
        style: AppTextStyle.labelSmall.copyWith(
          color: AppColors.of(context).textPrimary,
          fontWeight: FontWeight.w500,
          height: 16.h / 12.sp,
        ),
        children: [
          TextSpan(
            text: '*',
            style: AppTextStyle.labelSmall.copyWith(
              color: AppColors.of(context).absentText,
            ),
          ),
        ],
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  final DateTime? value;
  final ValueChanged<DateTime> onChanged;

  const _DateField({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return _FieldShell(
      label: l10n.date,
      child: InkWell(
        onTap: () async {
          final date = await showDatePicker(
            context: context,
            initialDate: value ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
          );
          if (date != null) onChanged(date);
        },
        child: _InputBox(
          text: value == null
              ? 'DD/MM/YY'
              : '${value!.day.toString().padLeft(2, '0')}/${value!.month.toString().padLeft(2, '0')}/${value!.year.toString().substring(2)}',
          icon: Icons.calendar_today_outlined,
          muted: value == null,
        ),
      ),
    );
  }
}

class _FieldShell extends StatelessWidget {
  final String label;
  final Widget child;

  const _FieldShell({required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _RequiredLabel(label),
        SizedBox(height: 6.h),
        child,
      ],
    );
  }
}

class _InputBox extends StatelessWidget {
  final String text;
  final IconData icon;
  final bool muted;

  const _InputBox({
    required this.text,
    required this.icon,
    this.muted = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      height: 38.h,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: colors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(6.r),
        border: Border.all(color: colors.slate400),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: AppTextStyle.bodyMedium.copyWith(
                color: muted ? colors.slate500 : colors.slate700,
                fontWeight: FontWeight.w400,
                height: 20.h / 14.sp,
              ),
            ),
          ),
          Icon(icon, size: 14.r, color: colors.slate700),
        ],
      ),
    );
  }
}

class _ReasonTypeGrid extends StatelessWidget {
  final RegularizationRequestType selectedType;
  final ValueChanged<RegularizationRequestType> onChanged;

  const _ReasonTypeGrid({
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final items = [
      (RegularizationRequestType.missedPunch, l10n.missedPunch),
      (RegularizationRequestType.systemError, l10n.systemError),
      (RegularizationRequestType.networkIssues, l10n.networkIssues),
      (RegularizationRequestType.onFieldDuty, l10n.onFieldDuty),
    ];

    return _FieldShell(
      label: l10n.reasonType,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
          mainAxisExtent: 38.h,
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          final selected = item.$1 == selectedType;
          return _ReasonTypeButton(
            label: item.$2,
            selected: selected,
            onTap: () => onChanged(item.$1),
          );
        },
      ),
    );
  }
}

class _ReasonTypeButton extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _ReasonTypeButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: selected
              ? colors.primary.withValues(alpha: 0.08)
              : colors.surfaceContainerLowest,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: selected ? colors.primary : colors.slate400,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyle.labelLarge.copyWith(
            color: colors.slate900,
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            height: 18.h / 12.sp,
          ),
        ),
      ),
    );
  }
}

class _TimeField extends StatelessWidget {
  final String label;
  final TimeOfDay? value;
  final ValueChanged<TimeOfDay?> onChanged;

  const _TimeField({
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return _FieldShell(
      label: label,
      child: InkWell(
        onTap: () async {
          final time = await showTimePicker(
            context: context,
            initialTime: value ?? TimeOfDay.now(),
            initialEntryMode: TimePickerEntryMode.dialOnly,
          );
          onChanged(time);
        },
        child: _InputBox(
          text: value?.format(context) ?? '--:-- --',
          icon: Icons.schedule_outlined,
          muted: value == null,
        ),
      ),
    );
  }
}

class _HrRouteTile extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const _HrRouteTile({required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;
    return InkWell(
      onTap: () => onChanged(!value),
      borderRadius: BorderRadius.circular(6.r),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: colors.leaveBg,
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: colors.tableBorder),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 14.r,
              height: 14.r,
              child: Checkbox(
                value: value,
                onChanged: (next) => onChanged(next ?? false),
                activeColor: colors.primary,
                side: BorderSide(color: colors.primary),
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.routeToHRDepartment,
                    style: AppTextStyle.labelLarge.copyWith(
                      color: colors.slate950,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    l10n.routeToHRDepartmentSub,
                    style: AppTextStyle.labelSmall.copyWith(
                      color: colors.slate500,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.w500,
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

class _ReasonField extends StatelessWidget {
  final TextEditingController controller;

  const _ReasonField({required this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;
    return _FieldShell(
      label: l10n.reason,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: controller,
            minLines: 3,
            maxLines: 4,
            style: AppTextStyle.bodySmall.copyWith(
              color: colors.textPrimary,
              fontSize: 12.sp,
            ),
            decoration: InputDecoration(
              hintText: l10n.reasonRegularizationHint,
              hintStyle: AppTextStyle.bodySmall.copyWith(
                color: colors.slate500,
                fontSize: 12.sp,
              ),
              filled: true,
              fillColor: colors.surfaceContainerLowest,
              contentPadding: EdgeInsets.all(10.r),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.r),
                borderSide: BorderSide(color: colors.slate400),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.r),
                borderSide: BorderSide(color: colors.slate400),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.r),
                borderSide: BorderSide(color: colors.primary),
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            l10n.reasonMinCharacters,
            style: AppTextStyle.labelSmall.copyWith(
              color: colors.slate500,
              fontSize: 8.sp,
              height: 16.h / 8.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _DocumentPicker extends StatelessWidget {
  final String? fileName;
  final bool isUploading;
  final VoidCallback onPickFile;
  final VoidCallback onRemoveFile;

  const _DocumentPicker({
    required this.fileName,
    required this.isUploading,
    required this.onPickFile,
    required this.onRemoveFile,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.supportingDocsOptional,
          style: AppTextStyle.labelLarge.copyWith(
            color: colors.slate600,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 6.h),
        InkWell(
          onTap: isUploading ? null : onPickFile,
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            height: 38.h,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLowest,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: colors.slate400),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (isUploading)
                  SizedBox(
                    width: 14.r,
                    height: 14.r,
                    child: CircularProgressIndicator(strokeWidth: 2.r),
                  )
                else
                  Icon(
                    Icons.attach_file,
                    size: 14.r,
                    color: colors.primary,
                  ),
                SizedBox(width: 8.w),
                Flexible(
                  child: Text(
                    fileName ?? l10n.attachDocument,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyle.bodySmall.copyWith(
                      color: colors.primary,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                if (fileName != null) ...[
                  SizedBox(width: 4.w),
                  GestureDetector(
                    onTap: onRemoveFile,
                    child: Icon(
                      Icons.close,
                      size: 14.r,
                      color: colors.absentText,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _BottomActionBar extends StatelessWidget {
  final bool enabled;
  final bool isSubmitting;
  final VoidCallback onNext;

  const _BottomActionBar({
    required this.enabled,
    required this.isSubmitting,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;
    return SafeArea(
      top: false,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.surfaceContainerLowest,
          border: Border(top: BorderSide(color: colors.slate200)),
          boxShadow: [
            BoxShadow(
              color: colors.black.withValues(alpha: 0.10),
              offset: Offset(0, -4.h),
              blurRadius: 5.r,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: SizedBox(
            width: double.infinity,
            height: 38.h,
            child: ElevatedButton(
              onPressed: enabled ? onNext : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.primary,
                disabledBackgroundColor: colors.primary.withValues(alpha: 0.50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
              child: isSubmitting
                  ? SizedBox(
                      width: 16.r,
                      height: 16.r,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.r,
                        color: colors.surfaceContainerLowest,
                      ),
                    )
                  : Text(
                      l10n.nextText,
                      style: AppTextStyle.button.copyWith(
                        fontSize: 12.sp,
                        color: colors.surfaceContainerLowest,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
