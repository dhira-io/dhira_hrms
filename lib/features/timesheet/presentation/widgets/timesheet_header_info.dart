import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../l10n/app_localizations.dart';

class TimesheetHeaderInfo extends StatelessWidget {
  final String? employeeName;
  final String? department;
  final String? approver;

  const TimesheetHeaderInfo({
    super.key,
    this.employeeName,
    this.department,
    this.approver,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.p12),
        child: Column(
          children: [
            _InfoRow(label: l10n.employee, value: employeeName ?? ""),
            _InfoRow(label: l10n.department, value: department ?? ""),
            _InfoRow(label: l10n.approver, value: approver ?? ""),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary)),
          Text(value, style: AppTextStyle.bodySmall.copyWith(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
