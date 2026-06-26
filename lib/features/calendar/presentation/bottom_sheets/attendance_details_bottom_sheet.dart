import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/theme/app_text_style.dart';
import 'package:dhira_hrms/core/widgets/shimmer_loading.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/core/services/local_storage_service.dart';
import 'package:dhira_hrms/core/routing/app_router.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:dhira_hrms/features/calendar/presentation/bloc/calendar_state.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/attendance_punch_summary_entity.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/leave_history_entity.dart';

class AttendanceDetailsBottomSheet extends StatelessWidget {
  final DateTime selectedDay;

  const AttendanceDetailsBottomSheet({super.key, required this.selectedDay});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        boxShadow: [
          BoxShadow(
            color: colors.black.withValues(alpha: 0.12),
            blurRadius: 8.r,
            offset: Offset(4.w, -2.h),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 10.h,
            bottom: 20.h,
            left: 16.w,
            right: 16.w,
          ),
          child: BlocBuilder<CalendarBloc, CalendarState>(
            builder: (context, state) {
              return state.maybeWhen(
                loaded:
                    (
                      events,
                      summary,
                      focusedMonth,
                      selectedDayVal,
                      teamLeaves,
                      selectedDayPunchSummary,
                      isPunchSummaryLoading,
                      selectedDayLeaveDetails,
                      leaveHistory,
                    ) {
                      if (isPunchSummaryLoading) {
                        return const _ShimmerLoadingView();
                      }

                      final dateKey = DateTimeUtils.formatToYMD(selectedDay);
                      final rawStatus = events[dateKey] ?? '';
                      final isWeekend = DateTimeUtils.isWeekend(selectedDay);

                      String statusStr = rawStatus;
                      if (isWeekend) {
                        if (rawStatus.isEmpty ||
                            rawStatus.toLowerCase() == 'holiday' ||
                            rawStatus.toLowerCase() == 'weekend' ||
                            rawStatus.toLowerCase() == 'weekly off') {
                          statusStr = 'weekend';
                        }
                      }

                      // Find holiday name
                      String? holidayName;
                      if (statusStr.toLowerCase() == 'holiday') {
                        for (final h in summary.holidayDetails) {
                          if (h.date == dateKey) {
                            holidayName = h.name;
                            break;
                          }
                        }
                        holidayName ??= 'Public Holiday';
                      }

                      return _ContentArea(
                        selectedDay: selectedDay,
                        statusStr: statusStr,
                        punchSummary: selectedDayPunchSummary,
                        leaveDetails: selectedDayLeaveDetails,
                        holidayName: holidayName,
                      );
                    },
                orElse: () => const SizedBox.shrink(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ShimmerLoadingView extends StatelessWidget {
  const _ShimmerLoadingView();

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShimmerLoading(height: 18.h, width: 130.w, borderRadius: 4.r),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.close, size: 18.sp, color: colors.textSecondary),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        SizedBox(height: 6.h),
        ShimmerLoading(height: 20.h, width: 70.w, borderRadius: 9999.r),
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: colors.tableBorder, width: 1.w),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: ShimmerLoading(
                  height: 18.h,
                  width: 150.w,
                  borderRadius: 4.r,
                ),
              ),
              Container(height: 1.h, color: colors.tableBorder),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShimmerLoading(
                          height: 18.h,
                          width: 70.w,
                          borderRadius: 4.r,
                        ),
                        ShimmerLoading(
                          height: 18.h,
                          width: 70.w,
                          borderRadius: 4.r,
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShimmerLoading(
                          height: 18.h,
                          width: 70.w,
                          borderRadius: 4.r,
                        ),
                        ShimmerLoading(
                          height: 18.h,
                          width: 70.w,
                          borderRadius: 4.r,
                        ),
                      ],
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShimmerLoading(
                          height: 18.h,
                          width: 70.w,
                          borderRadius: 4.r,
                        ),
                        ShimmerLoading(
                          height: 18.h,
                          width: 70.w,
                          borderRadius: 4.r,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  final String statusStr;

  const _StatusBadge({required this.statusStr});

  @override
  Widget build(BuildContext context) {
    final status = statusStr.toLowerCase();
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);

    Color borderColor;
    Color dotColor;
    String labelText = statusStr;

    if (status == 'present') {
      borderColor = colors.presentText;
      dotColor = colors.presentText;
      labelText = l10n.present;
    } else if (status == 'half day' || status == 'half-day') {
      borderColor = colors.halfDayText;
      dotColor = colors.halfDayText;
      labelText = l10n.halfDay;
    } else if (status == 'leave' || status == 'on leave') {
      borderColor = colors.leaveText;
      dotColor = colors.leaveText;
      labelText = l10n.leave;
    } else if (status == 'holiday') {
      borderColor = colors.holidayText;
      dotColor = colors.holidayText;
      labelText = l10n.holiday;
    } else if (status == 'weekend' || status == 'weekly off') {
      borderColor = colors.weekendText;
      dotColor = colors.weekendText;
      labelText = l10n.weekend;
    } else {
      borderColor = colors.absentText;
      dotColor = colors.absentText;
      labelText = l10n.absent;
    }

    return Container(
      height: 20.h,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(9999.r),
        border: Border.all(color: borderColor, width: 1.w),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6.w,
            height: 6.w,
            decoration: BoxDecoration(color: dotColor, shape: BoxShape.circle),
          ),
          SizedBox(width: 4.w),
          Text(
            labelText,
            style: AppTextStyle.labelMediumOne.copyWith(
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

class _ContentArea extends StatelessWidget {
  final DateTime selectedDay;
  final String statusStr;
  final AttendancePunchSummaryEntity? punchSummary;
  final LeaveHistoryEntity? leaveDetails;
  final String? holidayName;

  const _ContentArea({
    required this.selectedDay,
    required this.statusStr,
    this.punchSummary,
    this.leaveDetails,
    this.holidayName,
  });

  String _formatWorkingHours(double hours) {
    final int h = hours.floor();
    final int m = ((hours - h) * 60).round();
    final String minutesStr = m.toString().padLeft(2, '0');
    return '$h.${minutesStr}h';
  }

  String _formatOnlyTime(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty || timeStr == '--:--') {
      return '--:--';
    }
    try {
      final lower = timeStr.toLowerCase();
      if (lower.contains('am') || lower.contains('pm')) {
        final parts = timeStr.trim().split(RegExp(r'\s+'));
        if (parts.length >= 2) {
          if (parts.last.toLowerCase() == 'am' ||
              parts.last.toLowerCase() == 'pm') {
            return '${parts[parts.length - 2]} ${parts.last.toUpperCase()}';
          }
        }
        return timeStr.toUpperCase();
      }

      final DateTime? dt =
          DateTime.tryParse(timeStr) ??
          DateTime.tryParse('2020-01-01 $timeStr');

      if (dt != null) {
        return DateFormat('hh:mm a').format(dt);
      }
    } catch (_) {}
    return timeStr;
  }

  @override
  Widget build(BuildContext context) {
    final status = statusStr.toLowerCase();
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);
    final dateFormatted = DateTimeUtils.formatDate(
      selectedDay,
      pattern: 'EEEE, d MMMM yyyy',
    );

    Widget detailContent;
    bool showActionButtons = false;
    final summary = punchSummary;

    if (status == 'present') {
      final checkIn = _formatOnlyTime(summary?.firstIn);
      final checkOut = _formatOnlyTime(summary?.lastOut);
      final totalHours = summary != null
          ? _formatWorkingHours(summary.workingHours)
          : '--:--';

      detailContent = _InfoRows(
        rows: [
          _InfoRowData(label: l10n.clockIn, value: checkIn),
          _InfoRowData(label: l10n.clockOut, value: checkOut),
          _InfoRowData(label: l10n.totalHoursLabel, value: totalHours),
        ],
      );
    } else if (status == 'half day' || status == 'half-day') {
      final checkIn = _formatOnlyTime(summary?.firstIn);
      final checkOut = _formatOnlyTime(summary?.lastOut);
      final totalHours = summary != null
          ? _formatWorkingHours(summary.workingHours)
          : '--:--';

      detailContent = _InfoRows(
        rows: [
          _InfoRowData(label: l10n.clockIn, value: checkIn),
          _InfoRowData(label: l10n.clockOut, value: checkOut),
          _InfoRowData(label: l10n.totalHoursLabel, value: totalHours),
        ],
      );

      showActionButtons = true;
    } else if (status == 'leave' || status == 'on leave') {
      final leaveType = leaveDetails?.leaveType ?? 'Sick Leave';
      final double days = leaveDetails?.totalLeaveDays ?? 1.0;
      final duration = days % 1 == 0 ? '${days.toInt()} day' : '$days days';

      detailContent = _InfoRows(
        rows: [
          _InfoRowData(label: l10n.leaveType, value: leaveType),
          _InfoRowData(label: l10n.duration, value: duration),
        ],
      );
    } else if (status == 'holiday') {
      detailContent = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _InfoRows(
            rows: [
              _InfoRowData(
                label: l10n.holidayName,
                value: holidayName ?? 'Public Holiday',
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: colors.attendancebg,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: colors.holidayText, width: 1.w),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: colors.holidayText,
                  size: 14.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    l10n.publicHolidayNoAttendance,
                    style: AppTextStyle.labelMedium.copyWith(
                      color: colors.holidayText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else if (status == 'weekend' || status == 'weekly off') {
      detailContent = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: colors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: colors.weekendText, width: 1.w),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: colors.weekendText,
                  size: 14.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    l10n.weekendNoAttendance,
                    style: AppTextStyle.labelMedium.copyWith(
                      color: colors.weekendText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      detailContent = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: colors.errorBg,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: colors.absentText, width: 1.w),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.error_outline,
                  color: colors.absentText,
                  size: 14.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    l10n.noAttendanceRecordFound,
                    style: AppTextStyle.labelMedium.copyWith(
                      color: colors.absentText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );

      showActionButtons = true;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              l10n.attendanceDetails,
              style: AppTextStyle.labelLarge.copyWith(
                color: colors.textSecondary,
              ),
            ),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.close, color: colors.textSecondary, size: 18.sp),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),

        _StatusBadge(statusStr: statusStr),
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: colors.tableBorder, width: 1.w),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                child: Text(
                  dateFormatted,
                  style: AppTextStyle.labelMedium.copyWith(
                    color: colors.textSecondary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Container(height: 1.h, color: colors.tableBorder),
              Padding(
                padding: EdgeInsets.only(
                  left: 16.w,
                  right: 16.w,
                  top: 8.h,
                  bottom: 10.h,
                ),
                child: detailContent,
              ),
            ],
          ),
        ),
        if (showActionButtons) ...[
          SizedBox(height: 12.h),
          const _ActionButtonsArea(),
        ],
      ],
    );
  }
}

class _InfoRows extends StatelessWidget {
  final List<_InfoRowData> rows;

  const _InfoRows({required this.rows});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    return Column(
      children: rows.map((row) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 3.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                row.label,
                style: AppTextStyle.labelMedium.copyWith(
                  color: colors.onSurfaceVariant,
                ),
              ),
              Text(
                row.value,
                style: AppTextStyle.labelMedium.copyWith(
                  color: colors.textSecondary,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _ActionButtonsArea extends StatelessWidget {
  const _ActionButtonsArea();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            context.push(AppRouter.attendanceRegularizationPath);
          },
          child: Container(
            height: 36.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: colors.tableBorder, width: 1.w),
              boxShadow: [
                BoxShadow(
                  color: colors.black.withValues(alpha: 0.05),
                  blurRadius: 2.r,
                  offset: Offset(0, 1.h),
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(
              l10n.attendanceRegularization,
              style: AppTextStyle.labelLarge.copyWith(
                color: colors.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
            final empId = Get.find<LocalStorageService>().getEmpId() ?? '';
            context.push(
              AppRouter.applyLeavePath,
              extra: {AppRouter.argEmployeeId: empId},
            );
          },
          child: Container(
            height: 36.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colors.primaryContainer,
              borderRadius: BorderRadius.circular(8.r),
            ),
            alignment: Alignment.center,
            child: Text(
              l10n.applyLeaveBtn,
              style: AppTextStyle.labelLarge.copyWith(
                color: colors.surfaceContainerLowest,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoRowData {
  final String label;
  final String value;
  const _InfoRowData({required this.label, required this.value});
}
