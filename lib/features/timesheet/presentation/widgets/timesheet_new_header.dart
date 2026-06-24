import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/timesheet/domain/constants/timesheet_constants.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_bloc.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_event.dart';
import 'package:dhira_hrms/features/timesheet/presentation/bloc/timesheet_state.dart';

class TimesheetNewHeader extends StatelessWidget {
  const TimesheetNewHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimesheetBloc, TimesheetState>(
      buildWhen: (previous, current) =>
          previous.selectedDate != current.selectedDate ||
          previous.currentWeekRangeText != current.currentWeekRangeText,
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;
        final selectedDate = state.selectedDate ?? DateTime.now();

        final rangeText = state.currentWeekRangeText.isNotEmpty
            ? state.currentWeekRangeText
            : DateTimeUtils.formatTimesheetWeekRange(selectedDate);

        final isThisWeek = state.isThisWeek;
        final woy = state.currentWeekOfYear;
        final year = state.currentWeekYear;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.of(context).surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.of(context).tableBorder),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ChevronButton(
                assetPath: TimesheetConstants.chevronLeftIcon,
                onTap: state.isPreviousWeekAllowed
                    ? () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        context.read<TimesheetBloc>().add(
                          const TimesheetEvent.previousWeekRequested(),
                        );
                      }
                    : null,
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        rangeText,
                        style: AppTextStyle.labelLarge.copyWith(
                          color: AppColors.of(context).textPrimary,
                        ),
                      ),
                      if (isThisWeek) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 1.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.colorBlue50,
                            borderRadius: BorderRadius.circular(12.r),
                            border: Border.all(
                              color: AppColors.of(context).surfaceContainerLow,
                            ),
                          ),
                          child: Text(
                            l10n.thisWeek,
                            style: AppTextStyle.bodyMedium.copyWith(
                              color: AppColors.colorBlue600,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    '${l10n.week} $woy · $year',
                    style: AppTextStyle.bodyMedium.copyWith(
                      color: AppColors.of(context).textSecondary,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              _ChevronButton(
                assetPath: TimesheetConstants.chevronRightIcon,
                onTap: state.isNextWeekAllowed
                    ? () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        context.read<TimesheetBloc>().add(
                          const TimesheetEvent.nextWeekRequested(),
                        );
                      }
                    : null,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ChevronButton extends StatelessWidget {
  final String assetPath;
  final VoidCallback? onTap;

  const _ChevronButton({required this.assetPath, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final themeColors = AppColors.of(context);
    final isEnabled = onTap != null;
    return Material(
      color: AppColors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(99.r),
        child: Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: isEnabled
                ? themeColors.slate100
                : themeColors.slate100.withValues(alpha: 0.5),
            shape: BoxShape.circle,
          ),
          child: Image.asset(
            assetPath,
            width: 16.w,
            height: 16.w,
            color: isEnabled ? themeColors.slate600 : themeColors.slate300,
          ),
        ),
      ),
    );
  }
}
