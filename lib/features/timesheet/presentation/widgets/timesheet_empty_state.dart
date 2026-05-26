import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class TimesheetEmptyState extends StatelessWidget {
  const TimesheetEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppConstants.p24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment_turned_in_outlined,
              color: AppColors.of(context).textSecondary.withValues(alpha: 0.4),
              size: 40,
            ),
            const SizedBox(height: AppConstants.p12),
            Text(
              l10n.timesheetNoTasksForDay,
              style: AppTextStyle.bodySmall.copyWith(
                color: AppColors.of(context).textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
