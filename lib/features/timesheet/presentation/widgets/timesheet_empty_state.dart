import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/widgets/common_button.dart';
import 'package:dhira_hrms/features/leave/presentation/widgets/dashed_border_painter.dart';
import 'package:dhira_hrms/features/timesheet/domain/constants/timesheet_constants.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';

class TimesheetEmptyState extends StatelessWidget {
  final VoidCallback onAddTask;

  const TimesheetEmptyState({
    super.key,
    required this.onAddTask,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return CustomPaint(
      foregroundPainter: DashedBorderPainter(
        color: AppColors.of(context).tableBorder,
        borderRadius: 12.r,
        strokeWidth: 2.0,
        dashWidth: 7,
        dashSpace: 3,
      ),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 12.h,
          horizontal: 16.w,
        ),
        decoration: BoxDecoration(
          color: AppColors.of(context).surfaceContainerLowest,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.of(context).slate100,
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: SvgPicture.asset(
                TimesheetConstants.clockSvgIcon,
                colorFilter: ColorFilter.mode(
                  AppColors.of(context).slate400,
                  BlendMode.srcIn,
                ),
                width: 24.w,
                height: 24.w,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              l10n.noTasksLogged,
              style: AppTextStyle.labelLarge.copyWith(
                color: AppColors.of(context).textPrimary,
              ),
            ),
            SizedBox(height: 6.h),
            Text(
              l10n.logWorkHoursPrompt,
              textAlign: TextAlign.center,
              style: AppTextStyle.bodySmall.copyWith(
                color: AppColors.of(context).textSecondary,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 16.h),
            SizedBox(
              height: 26.h,
              width: 100.w,
              child: CommonButton(
                fontWeight: FontWeight.w100,
                text: l10n.addTask,
                onPressed: onAddTask,
                icon: Icons.add,
                borderRadius: 8.r,
                padding: EdgeInsets.zero,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
