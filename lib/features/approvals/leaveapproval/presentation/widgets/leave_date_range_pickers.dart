import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'leave_form_elements.dart';

class LeaveDateRangePickers extends StatelessWidget {
  final AppLocalizations l10n;
  final DateTime? fromDate;
  final DateTime? toDate;
  final VoidCallback onFromDateTap;
  final VoidCallback onToDateTap;
  final bool isToDateReadOnly;

  const LeaveDateRangePickers({
    super.key,
    required this.l10n,
    this.fromDate,
    this.toDate,
    required this.onFromDateTap,
    required this.onToDateTap,
    this.isToDateReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LeaveLabel(label: l10n.fromDate),
              LeaveDatePickerField(
                text: fromDate == null ? "" : fromDate!.format(),
                onTap: onFromDateTap,
              ),
            ],
          ),
        ),
        const SizedBox(width: AppConstants.p16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LeaveLabel(label: l10n.toDate),
              LeaveDatePickerField(
                text: toDate == null ? "" : toDate!.format(),
                onTap: isToDateReadOnly ? null : onToDateTap,
                isReadOnly: isToDateReadOnly,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
