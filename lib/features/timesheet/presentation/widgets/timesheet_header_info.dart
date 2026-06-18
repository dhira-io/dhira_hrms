import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

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
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.p20),
      decoration: BoxDecoration(
        color: AppColors.of(context).surface,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoBlock(label: l10n.employeeName, value: employeeName ?? "—"),
          const SizedBox(height: AppConstants.p16),
          _InfoBlock(label: l10n.department, value: department ?? "—"),
          const SizedBox(height: AppConstants.p16),
          _InfoBlock(label: l10n.approver, value: approver ?? "—"),
        ],
      ),
    );
  }
}

class _InfoBlock extends StatelessWidget {
  final String label;
  final String value;

  const _InfoBlock({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.bodySmall.copyWith(
            color: AppColors.of(context).textSecondary,
            fontSize: 13.sp,
          ),
        ),
              SizedBox(height: 4.h),
        Text(
          value,
          style: AppTextStyle.bodyLarge.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.of(context).textPrimary,
          ),
        ),
              SizedBox(height: 8.h),
              Divider(height: 1.h, color: AppColors.border),
      ],
    );
  }
}
