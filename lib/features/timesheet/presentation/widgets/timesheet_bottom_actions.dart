import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class TimesheetBottomActions extends StatelessWidget {
  final bool isLoading;
  final VoidCallback? onSubmit;

  const TimesheetBottomActions({
    super.key,
    required this.isLoading,
    this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onSubmit,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.of(context).primary,
          padding: const EdgeInsets.symmetric(vertical: AppConstants.p16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.r12),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.of(context).white,
                ),
              )
            : Text(l10n.submitWeeklyTimesheet, style: AppTextStyle.button),
      ),
    );
  }
}
