import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/features/leave/presentation/bloc/leave_bloc.dart';
import 'package:dhira_hrms/features/leave/presentation/bloc/leave_event.dart';
import 'package:dhira_hrms/features/leave/presentation/bloc/leave_state.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'leave_date_range_row.dart';
import 'leave_half_day_section.dart';
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
            if (val) toDateKey.currentState?.validate();
          },
        ),
        const SizedBox(height: AppConstants.p20),

        // Date Range
        LeaveDateRangeRow(
          fromDate: state.fromDate,
          toDate: state.toDate,
          isHalfDay: state.isHalfDay,
          toDateKey: toDateKey,
          onFromDateTap: () => onSelectDate(context, true),
          onToDateTap: () => onSelectDate(context, false),
        ),
        const SizedBox(height: AppConstants.p20),

        // Half Day Section
        LeaveHalfDaySection(
          fromDate: state.fromDate,
          toDate: state.toDate,
          halfDayDate: state.halfDayDate,
          daySegment: state.daySegment,
          isHalfDay: state.isHalfDay,
          onHalfDayDateTap: onSelectHalfDayDate,
          onDaySegmentChanged: (val) => bloc.add(LeaveEvent.daySegmentChanged(val)),
        ),

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
