import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';

class TimesheetWeeklyTotalCard extends StatelessWidget {
  final double totalWeeklyHours;

  const TimesheetWeeklyTotalCard({
    super.key,
    required this.totalWeeklyHours,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    
    return Container(
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: AppColors.border.withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.timesheetWeekTotal,
                style: AppTextStyle.statsLabel.copyWith(
                  fontSize: 14,
                  color: AppColors.slate600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                l10n.timesheetHoursGoal(totalWeeklyHours.toStringAsFixed(1)),
                style: AppTextStyle.h1.copyWith(
                  color: AppColors.brandBlue,
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppConstants.r8),
              child: LinearProgressIndicator(
                value: (totalWeeklyHours / 48).clamp(0.0, 1.0),
                backgroundColor: AppColors.slate100,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.brandBlue),
                minHeight: 10,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
