import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/leave_balance_entity.dart';
import '../../../../l10n/app_localizations.dart';

class LeaveSummaryCard extends StatelessWidget {
  final LeaveBalanceEntity balance;

  const LeaveSummaryCard({
    super.key,
    required this.balance,
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
            Row(
              children: [
                Expanded(child: _buildSummaryTile(l10n.totalAllocated, balance.totalAllocated.toString(), false)),
                const SizedBox(width: AppConstants.p12),
                Expanded(child: _buildSummaryTile(l10n.used, balance.used.toString(), false)),
              ],
            ),
            const SizedBox(height: AppConstants.p12),
            Row(
              children: [
                Expanded(child: _buildSummaryTile(l10n.pending, balance.pending.toString(), false, isOrange: true)),
                const SizedBox(width: AppConstants.p12),
                Expanded(child: _buildSummaryTile(l10n.available, balance.available.toString(), true)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryTile(String label, String value, bool isHighlighted, {bool isOrange = false}) {
    final highlightBg = AppColors.iconbgblue; 
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.p16),
      decoration: BoxDecoration(
        color: isHighlighted ? highlightBg : AppColors.background,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        border: isHighlighted ? Border.all(color: AppColors.primaryBlue.withValues(alpha: 0.3)) : null,
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(color: isHighlighted ? AppColors.primaryBlue : AppColors.textSecondary, fontSize: 13)),
          const SizedBox(height: AppConstants.p8),
          Text(
            value,
            style: TextStyle(
              fontSize: AppConstants.p22,
              fontWeight: FontWeight.bold,
              color: isHighlighted 
                  ? AppColors.primaryBlue
                  : (isOrange ? AppColors.pending : AppColors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
