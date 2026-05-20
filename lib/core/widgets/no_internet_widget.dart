import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';
import '../constants/app_constants.dart';
import '../../l10n/app_localizations.dart';

class NoInternetWidget extends StatelessWidget {
  final VoidCallback onReload;
  final String? message;

  const NoInternetWidget({
    super.key,
    required this.onReload,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppConstants.p16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(AppConstants.p24),
              decoration: BoxDecoration(
                color: AppColors.of(context).errorBg,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.wifi_off_rounded,
                size: 64,
                color: AppColors.of(context).error,
              ),
            ),
            const SizedBox(height: AppConstants.p12),
            Text(
              l10n.somethingWentWrong,
              style: AppTextStyle.h3,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.p4),
            Text(
              message ?? l10n.pleaseCheckYourInternetConnection,
              style: AppTextStyle.bodyMedium.copyWith(
                color: AppColors.of(context).textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.p32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onReload,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.of(context).primary,
                  foregroundColor: AppColors.of(context).white,
                  padding: const EdgeInsets.symmetric(vertical: AppConstants.p16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppConstants.r12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  l10n.reload,
                  style: AppTextStyle.labelLarge.copyWith(color: AppColors.of(context).white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
