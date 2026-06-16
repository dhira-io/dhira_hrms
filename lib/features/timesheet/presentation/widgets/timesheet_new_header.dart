import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../bloc/timesheet_bloc.dart';
import '../bloc/timesheet_event.dart';
import '../bloc/timesheet_state.dart';

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
        final startOfWeek = DateTimeUtils.getStartOfWeek(selectedDate);
        final endOfWeek = startOfWeek.add(const Duration(days: 6));

        final String rangeText;
        if (startOfWeek.month == endOfWeek.month) {
          rangeText =
              '${DateFormat('MMM d').format(startOfWeek)} – ${endOfWeek.day}';
        } else {
          rangeText =
              '${DateFormat('MMM d').format(startOfWeek)} – ${DateFormat('MMM d').format(endOfWeek)}';
        }

        final isThisWeek = DateTimeUtils.isSameDay(
          startOfWeek,
          DateTimeUtils.getStartOfWeek(DateTime.now()),
        );

        int dayOfYear = int.parse(DateFormat('D').format(startOfWeek));
        int woy = ((dayOfYear - startOfWeek.weekday + 10) / 7).floor();

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: AppColors.of(context).surfaceContainerLowest,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.of(context).border),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _ChevronButton(
                assetPath: 'assets/icons/chevron_left.png',
                onTap:
                    DateTimeUtils.isWeekAllowed(
                      startOfWeek.subtract(const Duration(days: 7)),
                    )
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
                        style: TextStyle(
                          color: AppColors.of(context).textPrimary,
                          fontSize: 12.sp,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
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
                            style: TextStyle(
                              color: AppColors.colorBlue600,
                              fontSize: 10.sp,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    'Week $woy · ${startOfWeek.year}',
                    style: TextStyle(
                      color: AppColors.of(context).textSecondary,
                      fontSize: 12.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              _ChevronButton(
                assetPath: 'assets/icons/chevron_right.png',
                onTap:
                    DateTimeUtils.isWeekAllowed(
                      startOfWeek.add(const Duration(days: 7)),
                    )
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
      color: Colors.transparent,
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
