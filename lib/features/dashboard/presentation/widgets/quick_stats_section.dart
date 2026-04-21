import 'package:flutter/material.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';

class QuickStatsSection extends StatelessWidget {
  const QuickStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Row(
      children: [
        _buildStatCard(
          context,
          value: '24',
          label: l10n.daysPresent,
          valueColor: AppColors.primary,
        ),
        const SizedBox(width: AppConstants.p12),
        _buildStatCard(
          context,
          value: '09',
          label: l10n.leaveBalance,
          valueColor: AppColors.tertiary,
        ),
        const SizedBox(width: AppConstants.p12),
        _buildStatCard(
          context,
          value: '14 Sep',
          label: l10n.upcomingHoliday,
          valueColor: AppColors.textPrimary,
          isSmallValue: true,
        ),
      ],
    );
  }

  Widget _buildStatCard(
    BuildContext context, {
    required String value,
    required String label,
    required Color valueColor,
    bool isSmallValue = false,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: AppConstants.p16,
          horizontal: AppConstants.p8,
        ),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(AppConstants.r12),
        ),
        child: Column(
          children: [
            Text(
              value,
              textAlign: TextAlign.center,
              style: AppTextStyle.h1.copyWith(
                color: valueColor,
                fontSize: isSmallValue ? AppConstants.iconSmall : AppConstants.iconMedium,
                height: 1.2,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTextStyle.labelSmall.copyWith(
                color: AppColors.onSurfaceVariant,
                fontWeight: FontWeight.w600,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
