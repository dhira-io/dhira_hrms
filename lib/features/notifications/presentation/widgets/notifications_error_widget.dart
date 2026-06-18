import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

import '../../../../l10n/app_localizations.dart';

class NotificationsErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const NotificationsErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 48,
            color: AppColors.of(context).error,
          ),
                SizedBox(height: 16.h),
          Text(
            message,
            style: AppTextStyle.bodyMedium,
            textAlign: TextAlign.center,
          ),
                SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: onRetry,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.of(context).primary,
              foregroundColor: Colors.white,
              padding:       EdgeInsets.symmetric(
                horizontal: 32.w,
                vertical: 12.h,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(l10n.retry),
          ),
        ],
      ),
    );
  }
}
