import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../l10n/app_localizations.dart';

class PunchHeader extends StatelessWidget {
  final bool isPunchedIn;
  final bool isOnBreak;
  final String? firstIn;
  final String timeFormatted;
  final String dateFormatted;

  const PunchHeader({
    super.key,
    required this.isPunchedIn,
    required this.isOnBreak,
    this.firstIn,
    required this.timeFormatted,
    required this.dateFormatted,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(AppConstants.p8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: AppConstants.p8),
        decoration: BoxDecoration(
          color: AppColors.clockCardBg,
          border: Border.all(color: AppColors.clockCardBorder, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(AppConstants.r16),
          ),
        ),
        child: Column(
          children: [
            if (isPunchedIn && firstIn != null)
              Text(
                l10n.startedDayAt(
                  DateTimeUtils.convertDateStringToTime(firstIn!),
                ),
                style: AppTextStyle.labelLargeOne.copyWith(
                  color: AppColors.of(context).slate550,
                ),
              )
            else if (!isPunchedIn)
              Text(
                l10n.notClockedIn,
                style: AppTextStyle.labelLargeOne.copyWith(
                  color: AppColors.of(context).slate550,
                ),
              ),

            SizedBox(height: 4.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  timeFormatted,
                  style: AppTextStyle.displaySmallSemiBold.copyWith(
                    color: isOnBreak
                        ? AppColors.of(context).warning
                        : AppColors.of(context).primary,
                  ),
                ),
                if (isOnBreak) ...[
                  SizedBox(width: 8.w),
                  Icon(
                    Icons.pause,
                    color: AppColors.of(context).warning,
                    size: AppConstants.iconXXSmall,
                  ),
                ],
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              !isPunchedIn 
                  ? l10n.readyToStartYourDay 
                  : (isOnBreak ? l10n.onBreak : l10n.timeElapsed),
              style: AppTextStyle.labelLarge.copyWith(
                color: AppColors.of(context).slate550,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
