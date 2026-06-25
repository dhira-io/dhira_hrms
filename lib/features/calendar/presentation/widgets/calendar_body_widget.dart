import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:get/get.dart';
import 'package:dhira_hrms/core/theme/app_colors.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/core/widgets/common_app_bar.dart';
import 'package:dhira_hrms/core/widgets/shimmer_loading.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/core/services/local_storage_service.dart';
import 'package:dhira_hrms/core/routing/app_router.dart';
import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:dhira_hrms/features/calendar/presentation/bloc/calendar_bloc.dart';
import 'package:dhira_hrms/features/calendar/presentation/bloc/calendar_event.dart';
import 'package:dhira_hrms/features/calendar/presentation/bloc/calendar_state.dart';
import 'package:dhira_hrms/features/attendance/domain/entities/attendance_punch_summary_entity.dart';
import 'package:dhira_hrms/features/attendance/domain/entities/leave_history_entity.dart';
import 'calendar_view_widget.dart';
import 'calendar_summary_widget.dart';
import 'calendar_on_leave_today_widget.dart';
import 'calendar_skeleton_widget.dart';
import 'calendar_error_widget.dart';

class CalendarBodyWidget extends StatelessWidget {
  const CalendarBodyWidget({super.key});

  void _showAttendanceDetailsBottomSheet(BuildContext context, DateTime day) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: context.read<CalendarBloc>(),
        child: AttendanceDetailsBottomSheet(selectedDay: day),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: AppColors.of(context).background,
      appBar: CommonAppBar(
        title: l10n.calendar,
        subtitle: l10n.calendarSubtitle,
        showBackButton: false,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<CalendarBloc, CalendarState>(
                builder: (context, state) {
                  return state.when(
                    initial: () => const SizedBox.shrink(),
                    loading: () => const CalendarSkeletonWidget(),
                    error: (message) => CalendarErrorWidget(
                      message: message,
                      onRetry: () {
                        context.read<CalendarBloc>().add(
                          const CalendarEvent.started(),
                        );
                      },
                    ),
                    loaded: (events, summary, focusedMonth, selectedDay, teamLeaves,
                        selectedDayPunchSummary, isPunchSummaryLoading,
                        selectedDayLeaveDetails, leaveHistory) {
                      return RefreshIndicator(
                        onRefresh: () async {
                          context.read<CalendarBloc>().add(
                            CalendarEvent.monthChanged(focusedMonth),
                          );
                        },
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.all(AppConstants.p16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CalendarViewWidget(
                                  focusedMonth: focusedMonth,
                                  events: events,
                                  selectedDay: selectedDay,
                                  onMonthChanged: (newMonth) {
                                    context.read<CalendarBloc>().add(
                                      CalendarEvent.monthChanged(newMonth),
                                    );
                                  },
                                  onDaySelected: (day) {
                                    context.read<CalendarBloc>().add(
                                      CalendarEvent.daySelected(day),
                                    );
                                    _showAttendanceDetailsBottomSheet(context, day);
                                  },
                                ),
                                SizedBox(height: 16.h),
                                CalendarSummaryWidget(summary: summary),
                                SizedBox(height: 16.h),
                                CalendarOnLeaveTodayWidget(teamLeaves: teamLeaves),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AttendanceDetailsBottomSheet extends StatelessWidget {
  final DateTime selectedDay;

  const AttendanceDetailsBottomSheet({
    super.key,
    required this.selectedDay,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.of(context).surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 8.r,
            offset: Offset(4.w, -2.h),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: 24.h,
            bottom: 30.h,
            left: 16.w,
            right: 16.w,
          ),
          child: BlocBuilder<CalendarBloc, CalendarState>(
            builder: (context, state) {
              return state.maybeWhen(
                loaded: (events, summary, focusedMonth, selectedDayVal, teamLeaves,
                    selectedDayPunchSummary, isPunchSummaryLoading,
                    selectedDayLeaveDetails, leaveHistory) {
                  if (isPunchSummaryLoading) {
                    return _buildShimmerLoading(context);
                  }

                  final dateKey = DateTimeUtils.formatToYMD(selectedDay);
                  final statusStr = events[dateKey] ?? '';

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

                  return _buildContent(
                    context,
                    statusStr,
                    selectedDayPunchSummary,
                    selectedDayLeaveDetails,
                    holidayName,
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

  Widget _buildShimmerLoading(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ShimmerLoading(height: 20.h, width: 150.w, borderRadius: 4.r),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.close, size: 20.sp, color: const Color(0xFF020618)),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        ShimmerLoading(height: 22.h, width: 80.w, borderRadius: 9999.r),
        SizedBox(height: 18.h),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFCAD5E2), width: 1.w),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: ShimmerLoading(height: 20.h, width: 180.w, borderRadius: 4.r),
              ),
              Container(
                height: 1.26.h,
                color: const Color(0xFFCAD5E2),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h, bottom: 14.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShimmerLoading(height: 20.h, width: 80.w, borderRadius: 4.r),
                        ShimmerLoading(height: 20.h, width: 80.w, borderRadius: 4.r),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShimmerLoading(height: 20.h, width: 80.w, borderRadius: 4.r),
                        ShimmerLoading(height: 20.h, width: 80.w, borderRadius: 4.r),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ShimmerLoading(height: 20.h, width: 80.w, borderRadius: 4.r),
                        ShimmerLoading(height: 20.h, width: 80.w, borderRadius: 4.r),
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

  Widget _buildStatusBadge(BuildContext context, String statusStr) {
    final status = statusStr.toLowerCase();
    Color borderColor;
    Color dotColor;
    String labelText = statusStr;

    if (status == 'present') {
      borderColor = const Color(0xFF00A63E);
      dotColor = const Color(0xFF00A63E);
      labelText = 'Present';
    } else if (status == 'half day' || status == 'half-day') {
      borderColor = const Color(0xFFEFB100);
      dotColor = const Color(0xFFEFB100);
      labelText = 'Half Day';
    } else if (status == 'leave' || status == 'on leave') {
      borderColor = const Color(0xFF51A2FF);
      dotColor = const Color(0xFF51A2FF);
      labelText = 'Leave';
    } else if (status == 'holiday') {
      borderColor = const Color(0xFF8E51FF);
      dotColor = const Color(0xFF8E51FF);
      labelText = 'Holiday';
    } else if (status == 'weekend' || status == 'weekly off') {
      borderColor = const Color(0xFFA1A1A1);
      dotColor = const Color(0xFFA1A1A1);
      labelText = 'Weekend';
    } else {
      borderColor = const Color(0xFFFB2C36);
      dotColor = const Color(0xFFE7000B);
      labelText = 'Absent';
    }

    return Container(
      height: 22.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9999.r),
        border: Border.all(color: borderColor, width: 1.w),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8.w,
            height: 8.w,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 6.w),
          Text(
            labelText,
            style: TextStyle(
              color: const Color(0xFF314158),
              fontSize: 12.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    String statusStr,
    AttendancePunchSummaryEntity? punchSummary,
    LeaveHistoryEntity? leaveDetails,
    String? holidayName,
  ) {
    final status = statusStr.toLowerCase();
    final dateFormatted = DateTimeUtils.formatDate(
      selectedDay,
      pattern: 'EEEE, d MMMM yyyy',
    );

    Widget detailContent;
    List<Widget> actionButtons = [];

    if (status == 'present') {
      final checkIn = punchSummary?.firstIn ?? '--:--';
      final checkOut = punchSummary?.lastOut ?? '--:--';
      final totalHours = punchSummary != null
          ? '${punchSummary.workingHours.toStringAsFixed(2)}h'
          : '--:--';

      detailContent = _buildInfoRows([
        _InfoRowData(label: 'Clock In', value: checkIn),
        _InfoRowData(label: 'Clock Out', value: checkOut),
        _InfoRowData(label: 'Total Hours', value: totalHours),
      ]);
    } else if (status == 'half day' || status == 'half-day') {
      final checkIn = punchSummary?.firstIn ?? '--:--';
      final checkOut = punchSummary?.lastOut ?? '--:--';
      final totalHours = punchSummary != null
          ? '${punchSummary.workingHours.toStringAsFixed(2)}h'
          : '--:--';

      detailContent = _buildInfoRows([
        _InfoRowData(label: 'Clock In', value: checkIn),
        _InfoRowData(label: 'Clock Out', value: checkOut),
        _InfoRowData(label: 'Total Hours', value: totalHours),
      ]);

      actionButtons = _buildActionButtons(context);
    } else if (status == 'leave' || status == 'on leave') {
      final leaveType = leaveDetails?.leaveType ?? 'Sick Leave';
      final double days = leaveDetails?.totalLeaveDays ?? 1.0;
      final duration = days % 1 == 0 ? '${days.toInt()} day' : '$days days';

      detailContent = _buildInfoRows([
        _InfoRowData(label: 'Leave Type', value: leaveType),
        _InfoRowData(label: 'Duration', value: duration),
      ]);
    } else if (status == 'holiday') {
      detailContent = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRows([
            _InfoRowData(label: 'Holiday Name', value: holidayName ?? 'Public Holiday'),
          ]),
          SizedBox(height: 9.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFEDE9FE),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: const Color(0xFF8E51FF), width: 1.w),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.info_outline,
                  color: const Color(0xFF8E51FF),
                  size: 16.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Thi is public holidy. No attendance required.',
                    style: TextStyle(
                      color: const Color(0xFF8E51FF),
                      fontSize: 12.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
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
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              color: const Color(0xFFFEF2F2),
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(color: const Color(0xFFFB2C36), width: 1.w),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.error_outline,
                  color: const Color(0xFFE7000B),
                  size: 16.sp,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'No attendance record found for this day. Please regularize or Applyleave',
                    style: TextStyle(
                      color: const Color(0xFFE7000B),
                      fontSize: 12.sp,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );

      actionButtons = _buildActionButtons(context);
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Attendance Details',
              style: TextStyle(
                color: const Color(0xFF020618),
                fontSize: 14.sp,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
              ),
            ),
            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(
                Icons.close,
                color: const Color(0xFF020618),
                size: 20.sp,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
        SizedBox(height: 3.h),
        _buildStatusBadge(context, statusStr),
        SizedBox(height: 18.h),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFCAD5E2), width: 1.w),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Text(
                  dateFormatted,
                  style: TextStyle(
                    color: const Color(0xFF020618),
                    fontSize: 14.sp,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                height: 1.26.h,
                color: const Color(0xFFCAD5E2),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 12.h, bottom: 14.h),
                child: detailContent,
              ),
            ],
          ),
        ),
        if (actionButtons.isNotEmpty) ...[
          SizedBox(height: 18.h),
          ...actionButtons,
        ],
      ],
    );
  }

  Widget _buildInfoRows(List<_InfoRowData> rows) {
    return Column(
      children: rows.map((row) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 4.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                row.label,
                style: TextStyle(
                  color: const Color(0xFF62748E),
                  fontSize: 14.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                row.value,
                style: TextStyle(
                  color: const Color(0xFF020618),
                  fontSize: 14.sp,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  List<Widget> _buildActionButtons(BuildContext context) {
    return [
      GestureDetector(
        onTap: () {
          Navigator.pop(context);
          context.push(AppRouter.attendanceRegularizationPath);
        },
        child: Container(
          height: 40.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(color: const Color(0xFF99A1AF), width: 1.w),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 2.r,
                offset: Offset(0, 1.h),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Text(
            'Attendance Regularization',
            style: TextStyle(
              color: const Color(0xFF0F172B),
              fontSize: 14.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      SizedBox(height: 12.h),
      GestureDetector(
        onTap: () {
          Navigator.pop(context);
          final empId = Get.find<LocalStorageService>().getEmpId() ?? '';
          context.push(
            AppRouter.applyLeavePath,
            extra: {
              AppRouter.argEmployeeId: empId,
            },
          );
        },
        child: Container(
          height: 40.h,
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF155DFC),
            borderRadius: BorderRadius.circular(8.r),
          ),
          alignment: Alignment.center,
          child: Text(
            'Apply Leave',
            style: TextStyle(
              color: const Color(0xFFF8FAFC),
              fontSize: 14.sp,
              fontFamily: 'Inter',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    ];
  }
}

class _InfoRowData {
  final String label;
  final String value;
  const _InfoRowData({required this.label, required this.value});
}

