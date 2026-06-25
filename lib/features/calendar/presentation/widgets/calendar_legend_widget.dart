import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';

class CalendarLegendWidget extends StatelessWidget {
  const CalendarLegendWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.of(context).surface,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: AppColors.of(context).outlineVariant,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _LegendRowItem(
            color: AppColors.of(context).presentText,
            label: l10n.present,
          ),
          SizedBox(height: 4.h),
          _LegendRowItem(
            color: AppColors.of(context).absentText,
            label: l10n.absent,
          ),
          SizedBox(height: 4.h),
          _LegendRowItem(
            color: AppColors.of(context).leaveText,
            label: l10n.onLeave,
          ),
          SizedBox(height: 4.h),
          _LegendRowItem(
            color: AppColors.of(context).holidayText,
            label: l10n.holiday,
          ),
          SizedBox(height: 4.h),
          _LegendRowItem(
            color: AppColors.of(context).halfDayText,
            label: l10n.halfDay,
          ),
        ],
      ),
    );
  }
}

class _LegendRowItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendRowItem({
    required this.color,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 6.w),
          Text(
            label,
            style: AppTextStyle.bodySmall.copyWith(
              color: AppColors.of(context).onSurfaceVariant,
              fontWeight: FontWeight.w500,
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
