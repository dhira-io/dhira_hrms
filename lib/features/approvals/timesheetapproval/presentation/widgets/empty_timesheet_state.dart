import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class EmptyTimesheetState extends StatelessWidget {
  const EmptyTimesheetState({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppConstants.p60),
      child: Center(
        child: Column(
          children: [
            const Icon(Icons.description_outlined, size: AppConstants.iconXLarge, color: AppColors.slate300),
            const SizedBox(height: AppConstants.p16),
            Text(l10n.noTimesheetEntriesFound, style: AppTextStyle.bodyMedium.copyWith(color: AppColors.slate500)),
          ],
        ),
      ),
    );
  }
}
