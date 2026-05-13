import 'package:flutter/material.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'leave_date_picker_field.dart';
import 'leave_form_elements.dart';

class LeaveHalfDaySection extends StatelessWidget {
  final DateTime? fromDate;
  final DateTime? toDate;
  final DateTime? halfDayDate;
  final String? daySegment;
  final bool isHalfDay;
  final Future<void> Function(BuildContext) onHalfDayDateTap;
  final ValueChanged<String?> onDaySegmentChanged;

  const LeaveHalfDaySection({
    super.key,
    required this.fromDate,
    required this.toDate,
    required this.halfDayDate,
    required this.daySegment,
    required this.isHalfDay,
    required this.onHalfDayDateTap,
    required this.onDaySegmentChanged,
  });

  @override
  Widget build(BuildContext context) {
    if (!isHalfDay) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context)!;
    final isDateReadOnly = (fromDate != null && toDate != null && fromDate == toDate);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LeaveFormLabel(label: l10n.halfDayDate),
                  FormField<DateTime>(
                    initialValue: halfDayDate,
                    builder: (field) {
                      return LeaveDatePickerField(
                        text: halfDayDate == null ? "" : halfDayDate!.format(),
                        onTap: isDateReadOnly
                            ? null
                            : () async {
                                await onHalfDayDateTap(context);
                                field.didChange(halfDayDate);
                              },
                        isReadOnly: isDateReadOnly,
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
                    value: daySegment,
                    items: [l10n.firstHalf, l10n.secondHalf].map((segment) {
                      return DropdownMenuItem<String>(
                        value: segment,
                        child: Text(segment, style: AppTextStyle.bodyMedium),
                      );
                    }).toList(),
                    onChanged: onDaySegmentChanged,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.surfaceContainerHighest,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppConstants.p16,
                        vertical: AppConstants.p18,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppConstants.r12),
                        borderSide: BorderSide.none,
                      ),
                      errorStyle: AppTextStyle.bodySmall.copyWith(color: Colors.red),
                    ),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    icon: const Icon(Icons.arrow_drop_down, color: AppColors.outline),
                    validator: (val) => val == null && isHalfDay ? l10n.required : null,
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.p20),
      ],
    );
  }
}
