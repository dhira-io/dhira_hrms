import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class TimesheetErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const TimesheetErrorView({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.p24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(AppConstants.p16),
              decoration: BoxDecoration(
                color: AppColors.of(context).absentText.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.error_outline_rounded,
                color: AppColors.of(context).absentText,
                size: 48,
              ),
            ),
            const SizedBox(height: AppConstants.p20),
            Text(
              l10n.somethingWentWrong,
              style: AppTextStyle.h3.copyWith(
                color: AppColors.of(context).textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
                  SizedBox(height: 8.h),
            Text(
              message,
              style: AppTextStyle.bodyMedium.copyWith(
                color: AppColors.of(context).textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.p24),
            ElevatedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded, size: 20),
              label: Text(l10n.retry, style: AppTextStyle.button),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.of(context).primary,
                foregroundColor: AppColors.of(context).white,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.p24,
                  vertical: AppConstants.p12,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.r12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
