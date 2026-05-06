import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';

class TimesheetStatusBadge extends StatelessWidget {
  final String status;

  const TimesheetStatusBadge({
    super.key,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final isPending = status.toLowerCase() == TimesheetStatus.pending.toLowerCase();
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isPending ? AppColors.pendingStatusBg : AppColors.approvedBg,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        status,
        style: AppTextStyle.bodySmall.copyWith(
          fontWeight: FontWeight.bold,
          color: isPending ? AppColors.pendingStatusText : AppColors.approvedText,
        ),
      ),
    );
  }
}
