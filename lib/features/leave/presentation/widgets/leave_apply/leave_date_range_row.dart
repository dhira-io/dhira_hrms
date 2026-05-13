import 'package:flutter/material.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'leave_date_picker_field.dart';
import 'leave_form_elements.dart';

class LeaveDateRangeRow extends StatelessWidget {
  final DateTime? fromDate;
  final DateTime? toDate;
  final bool isHalfDay;
  final VoidCallback onFromDateTap;
  final VoidCallback? onToDateTap;
  final GlobalKey<FormFieldState<DateTime>>? toDateKey;

  const LeaveDateRangeRow({
    super.key,
    required this.fromDate,
    required this.toDate,
    required this.isHalfDay,
    required this.onFromDateTap,
    this.onToDateTap,
    this.toDateKey,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LeaveFormLabel(label: l10n.fromDate),
              FormField<DateTime>(
                initialValue: fromDate,
                validator: (val) => fromDate == null ? l10n.required : null,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                builder: (field) {
                  return LeaveDatePickerField(
                    text: fromDate == null ? "" : fromDate!.format(),
                    onTap: () {
                      onFromDateTap();
                      field.didChange(fromDate);
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
                key: toDateKey,
                initialValue: toDate,
                validator: (val) => (toDate == null && !isHalfDay) ? l10n.required : null,
                builder: (field) {
                  return LeaveDatePickerField(
                    text: toDate == null ? "" : toDate!.format(),
                    onTap: isHalfDay ? null : () {
                      if (onToDateTap != null) {
                        onToDateTap!();
                        field.didChange(toDate);
                      }
                    },
                    isReadOnly: isHalfDay,
                    errorText: field.errorText,
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
