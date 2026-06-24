import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_balance_entity.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class LeaveInlineBalanceBar extends StatelessWidget {
  final LeaveBalanceEntity balance;
  final String? selectedLeaveType;

  const LeaveInlineBalanceBar({
    super.key,
    required this.balance,
    required this.selectedLeaveType,
  });

  @override
  Widget build(BuildContext context) {
    if (selectedLeaveType == null) return const SizedBox.shrink();

    final l10n = AppLocalizations.of(context)!;

    LeaveDetailedBalanceEntity? detailedBalance;
    for (var detail in balance.details) {
      if (detail.leaveType == selectedLeaveType) {
        detailedBalance = detail;
        break;
      }
    }

    if (detailedBalance == null) return const SizedBox.shrink();

    final allocated = detailedBalance.allocated;
    final available = detailedBalance.available;
    final double progress = allocated > 0 ? (allocated - available) / allocated : 0.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppConstants.p16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.availableBalance,
              style: AppTextStyle.bodySmall.copyWith(
                color: AppColors.of(context).outline,
              ),
            ),
            Text(
              "${available.toStringAsFixed(0)}/${allocated.toStringAsFixed(0)}",
              style: AppTextStyle.labelLarge.copyWith(
                color: AppColors.of(context).onSurface,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppConstants.p8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: AppColors.of(context).outlineVariant.withValues(alpha: 0.5),
          color: AppColors.of(context).primary,
          minHeight: 8,
          borderRadius: BorderRadius.circular(4),
        ),
      ],
    );
  }
}
