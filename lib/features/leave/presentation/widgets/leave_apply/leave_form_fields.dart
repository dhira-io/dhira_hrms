import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/features/leave/presentation/bloc/leave_bloc.dart';
import 'package:dhira_hrms/features/leave/presentation/bloc/leave_event.dart';
import 'package:dhira_hrms/features/leave/presentation/bloc/leave_state.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'leave_date_picker_field.dart';
import 'leave_type_selection_grid.dart';
import 'half_day_toggle.dart';
import 'leave_reason_field.dart';
import 'leave_supporting_docs_upload.dart';
import 'leave_form_elements.dart';

class LeaveFormCallbacks {
  final Future<void> Function(BuildContext, bool) onSelectDate;
  final Future<void> Function(BuildContext) onSelectHalfDayDate;
  final Future<void> Function() onPickAndUploadFile;

  LeaveFormCallbacks({
    required this.onSelectDate,
    required this.onSelectHalfDayDate,
    required this.onPickAndUploadFile,
  });
}

class LeaveFormFields extends StatelessWidget {
  final LeaveState state;
  final String gender;
  final double totalDays;
  final bool requiresDocs;
  final TextEditingController reasonController;
  final GlobalKey<FormFieldState<DateTime>> toDateKey;
  final LeaveFormCallbacks callbacks;

  const LeaveFormFields({
    super.key,
    required this.state,
    required this.gender,
    required this.totalDays,
    required this.requiresDocs,
    required this.reasonController,
    required this.toDateKey,
    required this.callbacks,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<LeaveBloc>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Leave Type
        LeaveFormLabel(label: l10n.leaveType, isRequired: true),
        LeaveTypeSelectionGrid(
          selectedLeaveType: state.selectedLeaveType,
          leaveTypes: state.leaveTypes,
          balance: state.balance,
          gender: gender,
          onChanged: (val) => bloc.add(LeaveEvent.leaveTypeChanged(val)),
          validator: (val) => val == null ? l10n.required : null,
        ),
        SizedBox(height: AppConstants.p20.h),

        // Half Day Toggle
        HalfDayToggle(
          value: state.isHalfDay,
          onChanged: (val) {
            bloc.add(LeaveEvent.halfDayToggled(val));
          },
        ),
        const SizedBox(height: AppConstants.p20),

        // Date Range
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LeaveFormLabel(label: l10n.fromDate, isRequired: true),
                FormField<DateTime>(
                  key: ValueKey('fromDate_${state.isHalfDay}'),
                  initialValue: state.fromDate,
                  validator: (val) =>
                      state.fromDate == null ? l10n.required : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  builder: (field) {
                    return LeaveDatePickerField(
                      text: state.fromDate == null
                          ? "dd/MM/yyyy"
                          : state.fromDate!.format(DateTimeUtils.patternDDMMYYYY),
                      onTap: () async {
                        await callbacks.onSelectDate(context, true);
                        field.didChange(state.fromDate);
                      },
                      errorText: field.errorText,
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: AppConstants.p20.h),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LeaveFormLabel(label: l10n.toDate, isRequired: !state.isHalfDay),
                FormField<DateTime>(
                  key: ValueKey('toDate_${state.isHalfDay}'),
                  initialValue: state.toDate,
                  validator: (val) =>
                      (state.toDate == null && !state.isHalfDay)
                      ? l10n.required
                      : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  builder: (field) {
                    return LeaveDatePickerField(
                      text: state.toDate == null
                          ? "dd/MM/yyyy"
                          : state.toDate!.format(DateTimeUtils.patternDDMMYYYY),
                      onTap: state.isHalfDay
                          ? null
                          : () async {
                              await callbacks.onSelectDate(context, false);
                              field.didChange(state.toDate);
                            },
                      isReadOnly: state.isHalfDay,
                      errorText: field.errorText,
                    );
                  },
                ),
              ],
            ),
            if (state.fromDate != null && (state.toDate != null || state.isHalfDay) && totalDays > 0)
              Padding(
                padding: EdgeInsets.only(top: AppConstants.p8.h),
                child: Text(
                  'Duration: ${totalDays % 1 == 0 ? totalDays.toInt() : totalDays} ${totalDays <= 1 ? 'day' : 'days'}',
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: AppColors.of(context).primary,
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: AppConstants.p20.h),

        if (state.isHalfDay) ...[
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LeaveFormLabel(label: l10n.halfDayDate),
                    FormField<DateTime>(
                      initialValue: state.halfDayDate,
                      builder: (field) {
                        return LeaveDatePickerField(
                          text: state.halfDayDate == null
                              ? ""
                              : state.halfDayDate!.format(),
                          onTap:
                              (state.fromDate != null &&
                                  state.toDate != null &&
                                  state.fromDate == state.toDate)
                              ? null
                              : () async {
                                  await callbacks.onSelectHalfDayDate(context);
                                  field.didChange(state.halfDayDate);
                                },
                          isReadOnly:
                              (state.fromDate != null &&
                              state.toDate != null &&
                              state.fromDate == state.toDate),
                          errorText: field.errorText,
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(width: AppConstants.p16.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LeaveFormLabel(label: l10n.daySegment),
                    DropdownButtonFormField<String>(
                      initialValue: state.daySegment,
                      dropdownColor: AppColors.of(
                        context,
                      ).surfaceContainerHighest,
                      style: AppTextStyle.bodyMedium.copyWith(
                        color: AppColors.of(context).onSurface,
                      ),
                      items: [l10n.firstHalf, l10n.secondHalf].map((segment) {
                        return DropdownMenuItem<String>(
                          value: segment,
                          child: Text(
                            segment,
                            style: AppTextStyle.bodyMedium.copyWith(
                              color: AppColors.of(context).onSurface,
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (val) =>
                          bloc.add(LeaveEvent.daySegmentChanged(val)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppConstants.p16,
                          vertical: AppConstants.p18,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstants.r12),
                          borderSide: const BorderSide(color: Color(0xFF90A1B9), width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstants.r12),
                          borderSide: const BorderSide(color: Color(0xFF90A1B9), width: 1.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppConstants.r12),
                          borderSide: BorderSide(color: AppColors.of(context).primary, width: 1.0),
                        ),
                        errorStyle: AppTextStyle.bodySmall.copyWith(
                          color: Colors.red,
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: AppColors.of(context).outline,
                      ),
                      validator: (val) =>
                          val == null && state.isHalfDay ? l10n.required : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: AppConstants.p20.h),
        ],

        // Reason
        LeaveFormLabel(label: 'Reason', isRequired: true),
        LeaveReasonField(
          controller: reasonController,
          validator: (val) {
            if (val == null || val.isEmpty) return l10n.required;
            if (val.trim().length < 10) return 'Minimum 10 characters required';
            return null;
          },
        ),
        Padding(
          padding: EdgeInsets.only(top: AppConstants.p4.h),
          child: Text(
            'Min 10 characters',
            style: AppTextStyle.bodySmall.copyWith(
              color: AppColors.of(context).slateText,
            ),
          ),
        ),
        const SizedBox(height: AppConstants.p20),

        // Supporting Docs
        if (requiresDocs) ...[
          LeaveFormLabel(label: l10n.supportingDocuments),
          LeaveSupportingDocsUpload(
            isUploading: state.isUploading,
            uploadedFileUrl: state.uploadedFileUrl,
            uploadError: state.uploadError,
            selectedFileName: state.selectedFileName,
            onPickFile: callbacks.onPickAndUploadFile,
          ),
          const SizedBox(height: AppConstants.p20),
        ],


      ],
    );
  }
}
