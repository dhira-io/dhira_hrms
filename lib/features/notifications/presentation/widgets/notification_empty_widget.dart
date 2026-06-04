import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../l10n/app_localizations.dart';

class NotificationEmptyWidget extends StatelessWidget {
  const NotificationEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(AppConstants.p24),
            decoration: BoxDecoration(
              color: AppColors.of(context).primary.withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.notifications_none_outlined,
              size: 64,
              color: AppColors.of(
                context,
              ).primaryContainer.withValues(alpha: 0.5),
            ),
          ),
                SizedBox(height: 24.h),
          Text(
            l10n.noNotificationsYet,
            style: AppTextStyle.h3.copyWith(
              color: AppColors.of(context).onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
                SizedBox(height: 12.h),
          Padding(
            padding:       EdgeInsets.symmetric(horizontal: 48.w),
            child: Text(
              l10n.noNotificationsDesc,
              textAlign: TextAlign.center,
              style: AppTextStyle.bodyMedium.copyWith(
                color: AppColors.of(context).onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
