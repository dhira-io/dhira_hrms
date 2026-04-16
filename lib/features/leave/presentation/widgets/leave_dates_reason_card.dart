import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/leave_type_entity.dart';
import 'leave_type_dropdown.dart';

class LeaveDatesReasonCard extends StatelessWidget {
  final DateTime? fromDate;
  final DateTime? toDate;
  final bool isHalfDay;
  final DateTime? halfDayDate;
  final String? leaveType;
  final List<LeaveTypeEntity> leaveTypes;
  final TextEditingController reasonController;
  final Function(bool isFromDate) onSelectDate;
  final VoidCallback onToggleHalfDay;
  final VoidCallback onSelectHalfDayDate;
  final Function(String?) onLeaveTypeChanged;

  const LeaveDatesReasonCard({
    super.key,
    required this.fromDate,
    required this.toDate,
    required this.isHalfDay,
    required this.halfDayDate,
    required this.leaveType,
    required this.leaveTypes,
    required this.reasonController,
    required this.onSelectDate,
    required this.onToggleHalfDay,
    required this.onSelectHalfDayDate,
    required this.onLeaveTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      elevation: 0.1,
      color: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppConstants.r16)),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.p20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDateRangeFields(l10n, context),
            const SizedBox(height: AppConstants.p20),
            _buildHalfDayToggle(l10n),
            if (isHalfDay) ...[
              const SizedBox(height: AppConstants.p12),
              Text(l10n.halfDayDate, style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: AppConstants.p8),
              _DatePickerField(
                selectedDate: halfDayDate,
                onTap: onSelectHalfDayDate,
              ),
            ],
            const SizedBox(height: AppConstants.p20),
            LeaveTypeDropdown(
              value: leaveType,
              leaveTypes: leaveTypes,
              onChanged: onLeaveTypeChanged,
            ),
            const SizedBox(height: AppConstants.p20),
            Text(l10n.reason, style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: AppConstants.p8),
            TextFormField(
              controller: reasonController,
              maxLines: 4,
              style: AppTextStyle.bodyMedium,
              decoration: InputDecoration(
                hintText: l10n.pleaseProvideReason,
                hintStyle: const TextStyle(color: AppColors.placeholdergrey),
                filled: true,
                fillColor: AppColors.background,
                contentPadding: const EdgeInsets.all(AppConstants.p16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConstants.r12),
                  borderSide: const BorderSide(color: AppColors.bordergrey),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppConstants.r12),
                  borderSide: const BorderSide(color: AppColors.bordergrey),
                ),
              ),
              validator: (val) => val == null || val.isEmpty ? l10n.required : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHalfDayToggle(AppLocalizations l10n) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(l10n.halfDay, style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
        Switch(
          value: isHalfDay,
          onChanged: (val) => onToggleHalfDay(),
          activeThumbColor: AppColors.white,
          activeTrackColor: AppColors.primaryBlue,
          inactiveThumbColor: AppColors.white,
          inactiveTrackColor: AppColors.bordergrey,
        ),
      ],
    );
  }

  Widget _buildDateRangeFields(AppLocalizations l10n, BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.fromDate, style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: AppConstants.p8),
              _DatePickerField(
                selectedDate: fromDate,
                onTap: () => onSelectDate(true),
              ),
            ],
          ),
        ),
        const SizedBox(width: AppConstants.p16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(l10n.toDate, style: AppTextStyle.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
              const SizedBox(height: AppConstants.p8),
              _DatePickerField(
                selectedDate: toDate,
                onTap: () => onSelectDate(false),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DatePickerField extends StatelessWidget {
  final DateTime? selectedDate;
  final VoidCallback onTap;

  const _DatePickerField({
    required this.selectedDate,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.p12, vertical: AppConstants.p12),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.bordergrey),
          borderRadius: BorderRadius.circular(AppConstants.r8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              selectedDate == null ? l10n.selectDate : DateFormat('yyyy-MM-dd').format(selectedDate!),
              style: AppTextStyle.bodyMedium,
            ),
            const Icon(Icons.calendar_today, size: AppConstants.p20, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
