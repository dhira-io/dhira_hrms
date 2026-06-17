import 'package:dhira_hrms/features/attendance/presentation/bloc/attendance_state.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/widgets/common_button.dart';
import '../../../../l10n/app_localizations.dart';

class PunchActionButtonRow extends StatelessWidget {
  final bool isPunchedIn;
  final bool isOnBreak;
  final AttendanceActionType? loadingType;
  final VoidCallback onPunchIn;
  final VoidCallback onTakeBreak;
  final VoidCallback onPunchOut;
  final VoidCallback onEndBreak;
  final EdgeInsets? padding;

  const PunchActionButtonRow({
    super.key,
    required this.isPunchedIn,
    required this.isOnBreak,
    this.loadingType,
    required this.onPunchIn,
    required this.onTakeBreak,
    required this.onPunchOut,
    required this.onEndBreak,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isAnyLoading = loadingType != null;

    return Padding(
      padding:
          padding ??
          const EdgeInsets.fromLTRB(
            AppConstants.p8,
            0,
            AppConstants.p8,
            AppConstants.p8,
          ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              if (!isPunchedIn)
                Expanded(
                  child: CommonButton(
                    text: l10n.letsGoStartYourDay,
                    icon: Icons.login_rounded,
                    backgroundColor: AppColors.of(context).primary,
                    onPressed: isAnyLoading ? null : onPunchIn,
                    isLoading: loadingType == AttendanceActionType.punchIn,
                    padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
                  ),
                )
              else if (!isOnBreak) ...[
                Expanded(
                  flex: 2,
                  child: CommonButton(
                    text: l10n.takeABreak,
                    icon: Icons.pause_rounded,
                    backgroundColor: AppColors.of(context).punchBreak,
                    onPressed: isAnyLoading ? null : onTakeBreak,
                    isLoading: loadingType == AttendanceActionType.takeBreak,
                    borderRadius: 8.r,
                    padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  flex: 3,
                  child: CommonButton(
                    text: l10n.thatsAllForToday,
                    icon: Icons.access_time_rounded,
                    backgroundColor: AppColors.of(context).punchOut,
                    onPressed: isAnyLoading ? null : onPunchOut,
                    isLoading: loadingType == AttendanceActionType.punchOut,
                    borderRadius: 8.r,
                    padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
                  ),
                ),
              ] else ...[
                Expanded(
                  flex: 2,
                  child: CommonButton(
                    text: l10n.resume,
                    icon: Icons.stop_rounded,
                    backgroundColor: AppColors.of(context).punchBreak,
                    onPressed: isAnyLoading ? null : onEndBreak,
                    isLoading: loadingType == AttendanceActionType.endBreak,
                    borderRadius: 8.r,
                    padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
                  ),
                ),
                SizedBox(width: 8.w),
                Expanded(
                  flex: 3,
                  child: CommonButton(
                    text: l10n.thatsAllForToday,
                    icon: Icons.access_time_rounded,
                    backgroundColor: AppColors.of(context).punchOut,
                    onPressed: isAnyLoading ? null : onPunchOut,
                    isLoading: loadingType == AttendanceActionType.punchOut,
                    borderRadius: 8.r,
                    padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
