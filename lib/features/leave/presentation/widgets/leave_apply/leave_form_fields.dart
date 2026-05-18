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
import 'leave_date_picker_field.dart';
import 'leave_type_dropdown.dart';
import 'half_day_toggle.dart';
import 'leave_reason_field.dart';
import 'leave_supporting_docs_upload.dart';
import 'leave_form_elements.dart';

class LeaveFormFields extends StatelessWidget {
  final LeaveState state;
  final String gender;
  final double totalDays;
  final bool requiresDocs;
  final TextEditingController reasonController;
  final GlobalKey<FormFieldState<DateTime>> toDateKey;
  final Future<void> Function(BuildContext, bool) onSelectDate;
  final Future<void> Function(BuildContext) onSelectHalfDayDate;
  final Future<void> Function() onPickAndUploadFile;

  const LeaveFormFields({
    super.key,
    required this.state,
    required this.gender,
    required this.totalDays,
    required this.requiresDocs,
    required this.reasonController,
    required this.toDateKey,
    required this.onSelectDate,
    required this.onSelectHalfDayDate,
    required this.onPickAndUploadFile,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final bloc = context.read<LeaveBloc>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Leave Type
        LeaveFormLabel(label: l10n.leaveType),
        LeaveTypeDropdown(
          value: state.selectedLeaveType,
          leaveTypes: state.leaveTypes,
          gender: gender,
          onChanged: (val) => bloc.add(LeaveEvent.leaveTypeChanged(val)),
          validator: (val) => val == null ? l10n.required : null,
        ),
        const SizedBox(height: AppConstants.p20),

        // Half Day Toggle
        HalfDayToggle(
          value: state.isHalfDay,
          onChanged: (val) {
            bloc.add(LeaveEvent.halfDayToggled(val));
          },
        ),
        const SizedBox(height: AppConstants.p20),

        // Date Range
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LeaveFormLabel(label: l10n.fromDate),
                  FormField<DateTime>(
                    key: ValueKey('fromDate_${state.isHalfDay}'),
                    initialValue: state.fromDate,
                    validator: (val) => state.fromDate == null ? l10n.required : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    builder: (field) {
                      return LeaveDatePickerField(
                        text: state.fromDate == null ? "" : state.fromDate!.format(),
                        onTap: () async {
                          await onSelectDate(context, true);
                          field.didChange(state.fromDate);
                        },
                        errorText: field.errorText,
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppConstants.p16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LeaveFormLabel(label: l10n.toDate),
                  FormField<DateTime>(
                    key: ValueKey('toDate_${state.isHalfDay}'),
                    initialValue: state.toDate,
                    validator: (val) => (state.toDate == null && !state.isHalfDay) ? l10n.required : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    builder: (field) {
                      return LeaveDatePickerField(
                        text: state.toDate == null ? "" : state.toDate!.format(),
                        onTap: state.isHalfDay ? null : () async {
                          await onSelectDate(context, false);
                          field.didChange(state.toDate);
                        },
                        isReadOnly: state.isHalfDay,
                        errorText: field.errorText,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.p20),

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
                          text: state.halfDayDate == null ? "" : state.halfDayDate!.format(),
                          onTap: (state.fromDate != null && state.toDate != null && state.fromDate == state.toDate)
                              ? null
                              : () async {
                                  await onSelectHalfDayDate(context);
                                  field.didChange(state.halfDayDate);
                                },
                          isReadOnly: (state.fromDate != null && state.toDate != null && state.fromDate == state.toDate),
                          errorText: field.errorText,
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppConstants.p16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    LeaveFormLabel(label: l10n.daySegment),
                    DropdownButtonFormField<String>(
                      value: state.daySegment,
                      items: [l10n.firstHalf, l10n.secondHalf].map((segment) {
                        return DropdownMenuItem<String>(
                          value: segment,
                          child: Text(segment, style: AppTextStyle.bodyMedium),
                        );
                      }).toList(),
                      onChanged: (val) => bloc.add(LeaveEvent.daySegmentChanged(val)),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.surfaceContainerHighest,
                        contentPadding: const EdgeInsets.symmetric(horizontal: AppConstants.p16, vertical: AppConstants.p18),
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppConstants.r12), borderSide: BorderSide.none),
                        errorStyle: AppTextStyle.bodySmall.copyWith(color: Colors.red),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      icon: const Icon(Icons.arrow_drop_down, color: AppColors.outline),
                      validator: (val) => val == null && state.isHalfDay ? l10n.required : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppConstants.p20),
        ],

        // Reason
        LeaveFormLabel(label: l10n.reasonForLeave),
        LeaveReasonField(
          controller: reasonController,
          validator: (val) => val == null || val.isEmpty ? l10n.required : null,
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
            onPickFile: onPickAndUploadFile,
          ),
          const SizedBox(height: AppConstants.p20),
        ],
      ],
    );
  }
}
