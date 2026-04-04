import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';

class TimesheetDateSelectors extends StatelessWidget {
  final DateTime? fromDate;
  final DateTime? toDate;

  const TimesheetDateSelectors({
    super.key,
    this.fromDate,
    this.toDate,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(child: _DateTile(label: l10n.fromDate, date: fromDate)),
        const SizedBox(width: AppConstants.p15),
        Expanded(child: _DateTile(label: l10n.toDate, date: toDate)),
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
        Text(label, style: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary)),
        const SizedBox(height: AppConstants.p4),
        Container(
          padding: const EdgeInsets.all(AppConstants.p12),
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border), 
            borderRadius: BorderRadius.circular(AppConstants.r8),
          ),
          child: Text(
            date == null ? l10n.select : DateFormat('dd MMM yyyy').format(date!),
            style: AppTextStyle.bodySmall,
          ),
        ),
      ],
    );
  }
}
