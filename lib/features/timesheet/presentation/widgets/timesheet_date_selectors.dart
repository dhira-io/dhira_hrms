import 'package:flutter/material.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';

class TimesheetDateSelectors extends StatelessWidget {
  final DateTime? fromDate;
  final DateTime? toDate;
  final VoidCallback? onFromDateTap;
  final VoidCallback? onToDateTap;

  const TimesheetDateSelectors({
    super.key,
    this.fromDate,
    this.toDate,
    this.onFromDateTap,
    this.onToDateTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: onFromDateTap,
            child: _DateTile(label: l10n.fromDate, date: fromDate),
          ),
        ),
        const SizedBox(width: AppConstants.p15),
        Expanded(
          child: GestureDetector(
            onTap: onToDateTap,
            child: _DateTile(label: l10n.toDate, date: toDate),
          ),
        ),
      ],
    );
  }
}

class _DateTile extends StatelessWidget {
  final String label;
  final DateTime? date;

  const _DateTile({required this.label, this.date});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.bodySmall.copyWith(
            color: AppColors.textSecondary,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppConstants.p8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(AppConstants.r10),
            color: AppColors.background.withValues(alpha: 0.3),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date == null ? l10n.select : DateTimeUtils.formatDate(date!),
                style: AppTextStyle.bodyMedium.copyWith(
                  color: date == null ? AppColors.textSecondary : AppColors.textPrimary,
                  fontWeight: date == null ? FontWeight.normal : FontWeight.w500,
                ),
              ),
              const Icon(Icons.calendar_month_outlined, size: 20, color: AppColors.textSecondary),
            ],
          ),
        ),
      ],
    );
  }
}
