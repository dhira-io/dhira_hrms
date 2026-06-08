import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../l10n/app_localizations.dart';

class RegularizationSystemRecord extends StatelessWidget {
  final DateTime? selectedDate;

  const RegularizationSystemRecord({super.key, this.selectedDate});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final displayDate = selectedDate != null
        ? DateTimeUtils.formatDate(
            selectedDate!,
            pattern: AppConstants.dateDisplayFormat,
          )
        : l10n.noRecord;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppConstants.p20),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(AppConstants.r16),
        boxShadow: [
          BoxShadow(
            color: AppColors.of(context).onSurface.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.systemRecord.toUpperCase(),
                    style: AppTextStyle.labelSmall.copyWith(
                      fontWeight: FontWeight.w500,
                      color: AppColors.of(context).onSurfaceVariant,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    displayDate,
                    style: AppTextStyle.h3.copyWith(
                      color: AppColors.of(context).onSurface,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.p20,
                  vertical: AppConstants.p4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.of(context).errorContainer,
                  borderRadius: BorderRadius.circular(AppConstants.r20),
                ),
                child: Text(
                  l10n.incomplete.toUpperCase(),
                  style: AppTextStyle.labelSmall.copyWith(
                    color: AppColors.of(context).onErrorContainer,
                    fontWeight: FontWeight.bold,
                    fontSize: AppConstants.fs9.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Row(
            children: [
              Expanded(
                child: _buildTimeBox(
                  context,
                  l10n.punchIn,
                  AppConstants
                      .timePlaceholder, // Hardcoded as per figma screenshot
                  AppColors.of(context).onSurfaceVariant,
                  false,
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _buildTimeBox(
                  context,
                  l10n.punchOut,
                  AppConstants.timePlaceholder,
                  AppColors.of(context).onSurfaceVariant,
                  true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTimeBox(
    BuildContext context,
    String label,
    String value,
    Color valueColor,
    bool isDashed,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.p16),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLow,
        borderRadius: BorderRadius.circular(AppConstants.r8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyle.labelSmall.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.of(context).onSurfaceVariant,
              fontSize: AppConstants.fs9.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            value,
            style: AppTextStyle.h3.copyWith(
              fontWeight: FontWeight.w900,
              color: valueColor,
              fontSize: AppConstants.fs18.sp,
            ),
          ),
        ],
      ),
    );
  }
}
