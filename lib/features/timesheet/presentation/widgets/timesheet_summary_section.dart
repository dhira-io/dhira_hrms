import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class TimesheetSummarySection extends StatelessWidget {
  final double totalExpected;
  final double totalSpent;

  const TimesheetSummarySection({
    super.key,
    required this.totalExpected,
    required this.totalSpent,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      color: AppColors.of(context).primary.withValues(alpha: 0.1),
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.p12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _SummaryItem(
              label: l10n.totalExpected,
              value: totalExpected.toStringAsFixed(1),
            ),
            _SummaryItem(
              label: l10n.totalSpent,
              value: totalSpent.toStringAsFixed(1),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: AppTextStyle.h3),
        Text(
          label,
          style: AppTextStyle.bodySmall.copyWith(
            color: AppColors.of(context).textSecondary,
            fontSize: 10,
          ),
        ),
      ],
    );
  }
}
