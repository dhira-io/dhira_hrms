import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../l10n/app_localizations.dart';

class LeaveEmployeeDetailsCard extends StatelessWidget {
  final String empName;
  final String department;
  final String approver;

  const LeaveEmployeeDetailsCard({
    super.key,
    required this.empName,
    required this.department,
    required this.approver,
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
          children: [
            _buildDetailRow(l10n.employeeName, empName),
            Divider(height: AppConstants.p24, color: AppColors.bordergrey),
            _buildDetailRow(l10n.department, department),
            Divider(height: AppConstants.p24, color: AppColors.bordergrey),
            _buildDetailRow(l10n.approver, approver),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyle.bodySmall.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: AppConstants.p4),
          Text(
            value,
            style: AppTextStyle.bodyLarge.copyWith(fontWeight: FontWeight.w600, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }
}
