import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../core/theme/app_colors.dart';
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  l10n.dailyProgress,
                  style: TextStyle(
                    color: AppColors.of(context).textPrimary,
                    fontSize: 13.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
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
              ],
            ),
            SizedBox(height: 6.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: days.map((day) {
                return Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 1.w),
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
            SizedBox(height: 14.h),
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
          style: TextStyle(
            color: AppColors.of(context).textSecondary,
            fontSize: 11.sp,
            fontFamily: 'Inter',
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
        : AppColors.of(context).border;

    final Color? dotColor = _getStatusColor(context, hours);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AspectRatio(
        aspectRatio: 0.83,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 1.w, vertical: 1.h),
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
                style: TextStyle(
                  color: AppColors.of(context).textSecondary,
                  fontSize: 8.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 1.h),
              Text(
                '${day.day}',
                style: TextStyle(
                  color: AppColors.of(context).textPrimary,
                  fontSize: 12.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (dotColor != null) ...[
                SizedBox(height: 1.h),
                Container(
                  width: 3.w,
                  height: 3.w,
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
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.of(context).surfaceContainerLowest,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.of(context).border),
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
                    style: TextStyle(
                      color: AppColors.of(context).textPrimary,
                      fontSize: 12.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    DateFormat('d MMM · yyyy').format(selectedDate),
                    style: TextStyle(
                      color: AppColors.of(context).textSecondary,
                      fontSize: 10.sp,
                      fontFamily: 'Inter',
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
                      width: 30.w,
                      height: 30.w,
                      child: CircularProgressIndicator(
                        value: percent,
                        backgroundColor: AppColors.colorNeutral200,
                        color: AppColors.of(context).primaryContainer,
                        strokeWidth: 3.w,
                      ),
                    ),
                    Text(
                      '$percentInt%',
                      style: TextStyle(
                        color: AppColors.of(context).textPrimary,
                        fontSize: 9.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
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
                style: TextStyle(
                  color: AppColors.of(context).textSecondary,
                  fontSize: 10.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${remaining.toStringAsFixed(remaining.truncateToDouble() == remaining ? 0 : 1)}h remaining',
                style: TextStyle(
                  color: AppColors.of(context).textSecondary,
                  fontSize: 10.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          ClipRRect(
            borderRadius: BorderRadius.circular(99.r),
            child: LinearProgressIndicator(
              value: percent,
              backgroundColor: AppColors.colorNeutral200,
              valueColor: AlwaysStoppedAnimation<Color>(
                AppColors.of(context).primaryContainer,
              ),
              minHeight: 4.h,
            ),
          ),
        ],
      ),
    );
  }
}
