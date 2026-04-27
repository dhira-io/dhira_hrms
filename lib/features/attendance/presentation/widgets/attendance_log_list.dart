import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:dhira_hrms/features/attendance/presentation/bloc/attendance_state.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/attendance_bloc.dart';
import '../bloc/attendance_event.dart';
import '../../domain/entities/attendance_entities.dart';
import 'leave_details_section.dart';

class AttendanceLogList extends StatefulWidget {
  const AttendanceLogList({super.key});

  @override
  State<AttendanceLogList> createState() => _AttendanceLogListState();
}

class _AttendanceLogListState extends State<AttendanceLogList> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _focusedDay = DateTime.now();
    _fetchInitialData();
  }

  Future<void> _fetchInitialData() async {
    if (mounted) {
      // Fetch calendar events
      _fetchCalendarEvents(_focusedDay);
    }
  }

  void _updateMonth(DateTime date) {
    setState(() {
      _focusedDay = date;
    });
    _fetchCalendarEvents(date);
  }

  void _fetchCalendarEvents(DateTime month) {
    final firstDay = DateTime(month.year, month.month, 1);
    final lastDay = DateTime(month.year, month.month + 1, 0);

    context.read<AttendanceBloc>().add(
      AttendanceEvent.calendarEventsRequested(
        fromDate: DateTimeUtils.formatToDMYShort(firstDay),
        toDate: DateTimeUtils.formatToDMYShort(lastDay),
      ),
    );

    context.read<AttendanceBloc>().add(
      AttendanceEvent.monthSummaryRequested(
        month: month.month,
        year: month.year,
      ),
    );

    context.read<AttendanceBloc>().add(
      AttendanceEvent.leaveDetailsRequested(
        date: DateTimeUtils.formatToYMD(month),
      ),
    );
  }

  List<AttendanceLogEntity> _currentLogs = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceBloc, AttendanceState>(
      builder: (context, state) {
        final Map<String, String> calendarEvents = state.calendarEvents ?? {};

        // Update local logs only if new data is available
        state.maybeWhen(orElse: () {});

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: AppConstants.p15,
                vertical: 8,
              ),
              padding: const EdgeInsets.all(AppConstants.p20),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppConstants.r20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: _buildCalendarView(calendarEvents),
            ),
            _buildMonthSummary(state.monthSummary),
            const SizedBox(height: 10),
          ],
        );
      },
    );
  }

  Widget _buildCalendarView(Map<String, String> calendarEvents) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: _buildMonthWeekToggle()),
        const SizedBox(height: 24),
        _buildCalendarHeader(),
        const SizedBox(height: 24),
        TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          availableGestures: AvailableGestures.horizontalSwipe,
          headerVisible: false,
          daysOfWeekHeight: 30,
          rowHeight: 48,
          onPageChanged: (focusedDay) {
            _updateMonth(focusedDay);
          },
          calendarStyle: const CalendarStyle(outsideDaysVisible: false),
          calendarBuilders: CalendarBuilders(
            dowBuilder: (context, day) {
              final isWeekend =
                  day.weekday == DateTime.saturday ||
                      day.weekday == DateTime.sunday;
              final text = _calendarFormat == CalendarFormat.month
                  ? DateFormat.E().format(day).substring(0, 1)
                  : DateFormat.E().format(day).toUpperCase();

              return Center(
                child: Text(
                  text,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: (isWeekend && _calendarFormat == CalendarFormat.week)
                        ? AppColors.error
                        : AppColors.placeholdergrey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
            defaultBuilder: (context, day, focusedDay) {
              return _buildCalendarDay(day, calendarEvents);
            },
            todayBuilder: (context, day, focusedDay) {
              return _buildCalendarDay(day, calendarEvents, isToday: true);
            },
          ),
        ),
        const SizedBox(height: 10),
        const Divider(height: 0.5),
        _buildLegend(),
      ],
    );
  }

  Widget _buildCalendarHeader() {
    final l10n = AppLocalizations.of(context)!;
    String headerText = '';

    if (_calendarFormat == CalendarFormat.month) {
      headerText = '${DateTimeUtils.formatToMonthName(_focusedDay)} ';
    } else {
      final firstDayOfWeek = _focusedDay.subtract(
        Duration(days: _focusedDay.weekday - 1),
      );
      final lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 6));
      final month = DateFormat('MMM').format(_focusedDay);
      headerText =
      '${firstDayOfWeek.day.toString().padLeft(2, '0')} - ${lastDayOfWeek.day.toString().padLeft(2, '0')} $month ';
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          l10n.attendanceCalendar,
          style: AppTextStyle.h3.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.darkSlate,
            height: 1.1,
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  if (_calendarFormat == CalendarFormat.month) {
                    _focusedDay = DateTime(
                      _focusedDay.year,
                      _focusedDay.month - 1,
                      1,
                    );
                  } else {
                    _focusedDay = _focusedDay.subtract(const Duration(days: 7));
                  }
                  _fetchCalendarEvents(_focusedDay);
                });
              },
              icon: const Icon(
                Icons.chevron_left,
                color: AppColors.blueIcon,
                size: 28,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            const SizedBox(width: 4),
            Text(
              headerText,
              style: AppTextStyle.bodyMedium.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.darkSlate,
              ),
            ),
            const SizedBox(width: 4),
            IconButton(
              onPressed: () {
                setState(() {
                  if (_calendarFormat == CalendarFormat.month) {
                    _focusedDay = DateTime(
                      _focusedDay.year,
                      _focusedDay.month + 1,
                      1,
                    );
                  } else {
                    _focusedDay = _focusedDay.add(const Duration(days: 7));
                  }
                  _fetchCalendarEvents(_focusedDay);
                });
              },
              icon: const Icon(
                Icons.chevron_right,
                color: AppColors.blueIcon,
                size: 28,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMonthWeekToggle() {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.slateBg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildToggleItem(
              l10n.month,
              _calendarFormat == CalendarFormat.month,
                  () => setState(() => _calendarFormat = CalendarFormat.month),
            ),
          ),
          Expanded(
            child: _buildToggleItem(
              l10n.week,
              _calendarFormat == CalendarFormat.week,
                  () => setState(() => _calendarFormat = CalendarFormat.week),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleItem(String label, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? AppColors.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          boxShadow: isActive
              ? [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ]
              : [],
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyle.bodyMedium.copyWith(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: isActive ? AppColors.blueIcon : AppColors.placeholdergrey,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCalendarDay(
      DateTime day,
      Map<String, String> calendarEvents, {
        bool isToday = false,
      }) {
    final localDay = DateTime(day.year, day.month, day.day);
    final dateKey = DateTimeUtils.formatToYMD(localDay);
    final status = calendarEvents[dateKey];

    final isWeekend =
        day.weekday == DateTime.saturday || day.weekday == DateTime.sunday;

    Color backgroundColor = AppColors.slateBg; // Default slate grey
    Color textColor = AppColors.slateText;

    if (status != null) {
      final s = status.toLowerCase();
      if (s == 'present') {
        backgroundColor = AppColors.presentBg; // bg-green-50
        textColor = AppColors.presentText; // text-green-800
      } else if (s == 'holiday') {
        backgroundColor = AppColors.holidayBg; // bg-purple-50
        textColor = AppColors.holidayText; // text-purple-800
      } else if (s == 'on leave' || s == 'leave') {
        backgroundColor = AppColors.leaveBg; // bg-blue-50
        textColor = AppColors.leaveText; // text-blue-800
      } else if (s == 'absent') {
        backgroundColor = AppColors.absentBg; // bg-red-50
        textColor = AppColors.absentText; // text-red-800
      } else if (s == 'weekend') {
        backgroundColor = AppColors.weekendBg;
        textColor = AppColors.weekendText;
      }
    } else if (isWeekend) {
      backgroundColor = AppColors.weekendBg;
      textColor = AppColors.weekendText;
    }

    return Container(
      margin: const EdgeInsets.all(3.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
        border: isToday
            ? Border.all(color: AppColors.blueIcon, width: 2)
            : null,
      ),
      child: Text(
        '${day.day}',
        style: AppTextStyle.bodyMedium.copyWith(
          color: textColor,
          fontWeight: FontWeight.w700,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildLegend() {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 10,
          children: [
            _buildLegendItem(AppColors.presentText, l10n.present),
            _buildLegendItem(AppColors.absentText, l10n.absent),
            _buildLegendItem(AppColors.leaveText, l10n.leave),
            _buildLegendItem(AppColors.holidayText, l10n.holiday),
            _buildLegendItem(AppColors.weekendText, l10n.weekend),
          ],
        ),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: AppTextStyle.bodySmall.copyWith(
            color: AppColors.slateText,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildListView(List<AttendanceLogEntity> logs) {
    final l10n = AppLocalizations.of(context)!;
    if (logs.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.only(top: 50),
          child: Text(l10n.noLogsFound),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.p15,
        vertical: 8,
      ),
      itemCount: logs.length,
      itemBuilder: (context, index) {
        final log = logs[index];
        final monthStr = log.monthAbbr.toUpperCase();
        final dayStr = log.dayNumber;
        final isWeekend = log.status == 'Weekend';
        final isLeave = log.status == 'Leave' || log.status == 'On Leave';

        final inTimeStr =
        (log.inTime == null || log.inTime == 'null' || log.inTime == '')
            ? ' '
            : log.inTime;
        final outTimeStr =
        (log.outTime == null || log.outTime == 'null' || log.outTime == '')
            ? ' '
            : log.outTime;
        final displayTime = (inTimeStr == ' ' && outTimeStr == ' ')
            ? ' '
            : '$inTimeStr - $outTimeStr';

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(AppConstants.p15),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppConstants.r16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              // Date Column
              Container(
                width: 35,
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 2),
                decoration: BoxDecoration(
                  color: AppColors.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      monthStr,
                      style: AppTextStyle.bodySmall.copyWith(
                        fontSize: 10,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      dayStr,
                      style: AppTextStyle.h3.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              // Day and Time Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      log.dayName,
                      style: AppTextStyle.label.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (isWeekend)
                      Text(
                        l10n.weekend,
                        style: AppTextStyle.bodySmall.copyWith(
                          color: AppColors.error,
                        ),
                      )
                    else if (isLeave)
                      Text(
                        l10n.leave,
                        style: AppTextStyle.bodySmall.copyWith(
                          color: AppColors.error,
                        ),
                      )
                    else
                      Text(
                        displayTime,
                        style: AppTextStyle.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                  ],
                ),
              ),
              // Hours Column
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (isWeekend || isLeave || log.workingHours == null)
                    Text(
                      '-',
                      style: AppTextStyle.bodyMedium.copyWith(
                        color: AppColors.error,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  else
                    Text(
                      log.workingHours ?? '-',
                      style: AppTextStyle.bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMonthSummary(AttendanceMonthSummaryEntity? summary) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.p15,
        24,
        AppConstants.p15,
        8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: 4, height: 20),
              const SizedBox(width: 10),
              Text(
                l10n.monthSummary,
                style: AppTextStyle.h3.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  l10n.presentDays,
                  summary?.presentDays.toString() ?? "0",
                  AppColors.primary,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildSummaryItem(
                  l10n.absentDays,
                  summary?.absentDays.toString().padLeft(2, '0') ?? "00",
                  AppColors.absentText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildSummaryItem(
                  l10n.onLeave,
                  summary?.onLeaveDays.toString() ?? "0",
                  AppColors.leaveText,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildSummaryItem(
                  l10n.holidays,
                  summary?.holidays.toString().padLeft(2, '0') ?? "00",
                  AppColors.holidayText,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildSummaryItem(
            l10n.weekendDays,
            summary?.weekendDays.toString().padLeft(2, '0') ?? "00",
            AppColors.weekendText,
            isFullWidth: true,
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
      String title,
      String value,
      Color color, {
        bool isFullWidth = false,
      }) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.p20),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppConstants.r16),
      ),
      child: isFullWidth
          ? Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: AppTextStyle.bodyMedium.copyWith(
              color: color.withValues(alpha: 0.8),
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            value,
            style: AppTextStyle.h1.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.bodyMedium.copyWith(
              color: color.withValues(alpha: 0.8),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: AppTextStyle.h1.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}