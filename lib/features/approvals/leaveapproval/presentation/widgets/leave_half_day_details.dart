import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'leave_form_elements.dart';

class LeaveHalfDayDetails extends StatelessWidget {
  final AppLocalizations l10n;
  final String? daySegment;
  final ValueChanged<String?> onSegmentChanged;
  final DateTime? halfDayDate;
  final VoidCallback onDateTap;
  final bool isDateReadOnly;

  const LeaveHalfDayDetails({
    super.key,
    required this.l10n,
    this.daySegment,
    required this.onSegmentChanged,
    this.halfDayDate,
    required this.onDateTap,
    this.isDateReadOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LeaveLabel(label: l10n.halfDayDate),
              LeaveDatePickerField(
                text: halfDayDate == null ? "" : halfDayDate!.format(),
                onTap: isDateReadOnly ? null : onDateTap,
                isReadOnly: isDateReadOnly,
              ),
            ],
          ),
        ),
        const SizedBox(width: AppConstants.p16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LeaveLabel(label: l10n.daySegment),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppConstants.p16),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(AppConstants.r12),
                  border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButtonFormField<String>(
                    value: daySegment,
                    items: [l10n.firstHalf, l10n.secondHalf].map((segment) {
                      return DropdownMenuItem(
                        value: segment,
                        child: Text(segment, style: AppTextStyle.bodyMedium),
                      );
                    }).toList(),
                    onChanged: onSegmentChanged,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.zero,
                    ),
                    icon: const Icon(Icons.arrow_drop_down, color: AppColors.primary),
                    validator: (val) => val == null ? l10n.required : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
