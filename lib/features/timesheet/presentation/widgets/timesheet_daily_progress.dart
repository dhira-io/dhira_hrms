import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/project_assignment_entity.dart';
import '../bloc/timesheet_bloc.dart';
import '../bloc/timesheet_event.dart';
import '../bloc/timesheet_state.dart';

class TimesheetDailyProgress extends StatelessWidget {
  const TimesheetDailyProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TimesheetBloc, TimesheetState>(
      buildWhen: (previous, current) =>
          previous.selectedDate != current.selectedDate ||
          previous.editAssignments != current.editAssignments,
      builder: (context, state) {
        final l10n = AppLocalizations.of(context)!;
        final selectedDate = state.selectedDate ?? DateTime.now();
        final startOfWeek = DateTimeUtils.getStartOfWeek(selectedDate);
        final days = List.generate(
          7,
          (index) => startOfWeek.add(Duration(days: index)),
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.dailyProgress,
                  style: AppTextStyle.labelLarge.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.of(context).textPrimary,
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: EdgeInsets.only(right: 5.w),
                  child: Row(
                    children: [
                      _LegendItem(
                        color: AppColors.colorEmerald500,
                        label: l10n.logged,
                      ),
                      SizedBox(width: 8.w),
                      _LegendItem(
                        color: AppColors.colorRed500,
                        label: l10n.missing,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: days.map((day) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 5.w),
                    child: _DayButton(
                      day: day,
                      isSelected: DateTimeUtils.isSameDay(selectedDate, day),
                      assignments: state.editAssignments,
                      onTap: () {
                        context.read<TimesheetBloc>().add(
                          TimesheetEvent.daySelected(day),
                        );
                      },
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 8.h),
            _SelectedDayCard(
              selectedDate: selectedDate,
              assignments: state.editAssignments,
              l10n: l10n,
            ),
          ],
        );
      },
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6.w,
          height: 6.w,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 4.w),
        Text(
          label,
          style: AppTextStyle.labelMedium.copyWith(
            color: AppColors.of(context).textSecondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _DayButton extends StatelessWidget {
  final DateTime day;
  final bool isSelected;
  final List<ProjectAssignmentEntity> assignments;
  final VoidCallback onTap;

  const _DayButton({
    required this.day,
    required this.isSelected,
    required this.assignments,
    required this.onTap,
  });

  Color? _getStatusColor(BuildContext context, double hours) {
    if (hours >= 9.5) {
      return AppColors.colorEmerald500;
    }
    if (hours > 0 || !DateTimeUtils.isWeekend(day)) {
      return AppColors.colorRed500;
    }
    return null; // No dot for weekends with 0 hours
  }

  @override
  Widget build(BuildContext context) {
    final hours = assignments
        .where(
          (e) =>
              e.date != null &&
              DateTimeUtils.isSameDay(DateTime.parse(e.date!), day),
        )
        .fold(0.0, (sum, e) => sum + e.spentHours);

    final bool isWeekend = DateTimeUtils.isWeekend(day);
    final Color bgColor = isSelected
        ? AppColors.colorBlue50
        : isWeekend
        ? AppColors.colorNeutral100
        : AppColors.of(context).surfaceContainerLowest;

    final Color borderColor = isSelected
        ? AppColors.of(context).primaryContainer
        : AppColors.of(context).tableBorder;

    final Color? dotColor = _getStatusColor(context, hours);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AspectRatio(
        aspectRatio: 0.8,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: borderColor, width: 0.67),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat('EEE').format(day).toUpperCase(),
                style: AppTextStyle.dateDay.copyWith(
                  fontSize: 8.sp,
                  color: AppColors.of(context).textSecondary,
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                '${day.day}',
                style: AppTextStyle.dateNumber.copyWith(
                  fontSize: 12.sp,
                  color: AppColors.of(context).textPrimary,
                ),
              ),
              if (dotColor != null) ...[
                SizedBox(height: 1.h),
                Container(
                  width: 5.w,
                  height: 5.w,
                  decoration: BoxDecoration(
                    color: dotColor,
                    shape: BoxShape.circle,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectedDayCard extends StatelessWidget {
  final DateTime selectedDate;
  final List<ProjectAssignmentEntity> assignments;
  final AppLocalizations l10n;

  const _SelectedDayCard({
    required this.selectedDate,
    required this.assignments,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    final hours = assignments
        .where(
          (e) =>
              e.date != null &&
              DateTimeUtils.isSameDay(DateTime.parse(e.date!), selectedDate),
        )
        .fold(0.0, (sum, e) => sum + e.spentHours);

    const targetHours = 9.5;
    final remaining = (targetHours - hours).clamp(0.0, targetHours);
    final percent = (hours / targetHours).clamp(0.0, 1.0);
    final int percentInt = (percent * 100).toInt();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.of(context).tableBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('EEEE').format(selectedDate),
                    style: AppTextStyle.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppColors.of(context).textPrimary,
                    ),
                  ),
                  Text(
                    DateFormat('d MMM · yyyy').format(selectedDate),
                    style: AppTextStyle.bodySmall.copyWith(
                      color: AppColors.of(context).textSecondary,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 34.w,
                height: 32.h,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 27.w,
                      height: 27.w,
                      child: CircularProgressIndicator(
                        value: percent,
                        backgroundColor: AppColors.colorNeutral200,
                        color: AppColors.of(context).primaryContainer,
                        strokeWidth: 3.w,
                      ),
                    ),
                    Text(
                      '$percentInt%',
                      style: AppTextStyle.bodySmall.copyWith(
                        fontSize: percentInt == 100 ? 8.sp : 9.sp,
                        color: AppColors.of(context).textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.dailyTarget(
                  targetHours.toStringAsFixed(
                    targetHours.truncateToDouble() == targetHours ? 0 : 1,
                  ),
                ),
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.of(context).textSecondary,
                ),
              ),
              Text(
                l10n.hoursRemaining(
                  remaining.toStringAsFixed(
                    remaining.truncateToDouble() == remaining ? 0 : 1,
                  ),
                ),
                style: AppTextStyle.bodySmall.copyWith(
                  color: AppColors.of(context).textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 5.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(99.r),
            child: LinearProgressIndicator(
              value: percent,
              backgroundColor: AppColors.colorNeutral200,
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.of(context).primaryContainer,
              ),
              minHeight: 5.h,
            ),
          ),
        ],
      ),
    );
  }
}
