import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_style.dart';
import '../constants/app_constants.dart';
import '../../l10n/app_localizations.dart';

class GenericErrorWidget extends StatelessWidget {
  final VoidCallback onRetry;
  final String? title;
  final String? message;

  const GenericErrorWidget({
    super.key,
    required this.onRetry,
    this.title,
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
            const Icon(
              Icons.error_outline_rounded,
              size: 32,
              color: AppColors.error,
            ),
            const SizedBox(height: AppConstants.p12),
            Text(
              title ?? l10n.somethingWentWrong,
              style: AppTextStyle.h3,
              textAlign: TextAlign.center,
            ),
            if (message != null) ...[
              const SizedBox(height: AppConstants.p4),
              Text(
                message!,
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: AppConstants.p16),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded, size: 16),
              label: Text(l10n.retry),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.p16,
                  vertical: AppConstants.p8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppConstants.r8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
