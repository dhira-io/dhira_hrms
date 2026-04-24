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
import '../bottom_sheets/holiday_list_bottom_sheet.dart';

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
          startingDayOfWeek: StartingDayOfWeek.sunday,
          availableGestures: AvailableGestures.horizontalSwipe,
          headerVisible: false,
          daysOfWeekHeight: 30,
          rowHeight: 48,
          onPageChanged: (focusedDay) {
            _updateMonth(focusedDay);
          },
          calendarStyle: const CalendarStyle(outsideDaysVisible: true),
          calendarBuilders: CalendarBuilders(
            outsideBuilder: (context, day, focusedDay) {
              return _buildCalendarDay(day, calendarEvents, isOutside: true);
            },
            dowBuilder: (context, day) {
              final text = _calendarFormat == CalendarFormat.month
                  ? DateFormat.E().format(day).substring(0, 1)
                  : DateFormat.E().format(day).toUpperCase();

              return Center(
                child: Text(
                  text,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.calendarDayLabel,
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
        Duration(days: _focusedDay.weekday % 7),
      );
      final lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 6));

      if (firstDayOfWeek.month != lastDayOfWeek.month) {
        final startMonth = DateFormat('MMM').format(firstDayOfWeek);
        final endMonth = DateFormat('MMM').format(lastDayOfWeek);
        headerText =
            '${firstDayOfWeek.day.toString().padLeft(2, '0')} $startMonth - ${lastDayOfWeek.day.toString().padLeft(2, '0')} $endMonth ';
      } else {
        final month = DateFormat('MMM').format(_focusedDay);
        headerText =
            '${firstDayOfWeek.day.toString().padLeft(2, '0')} - ${lastDayOfWeek.day.toString().padLeft(2, '0')} $month ';
      }
    }

    return Row(
      //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          l10n.attendanceCalendar,
          style: AppTextStyle.h3.copyWith(
            fontWeight: FontWeight.w800,
            color: AppColors.darkSlate,
            height: 1.1,
          ),
        ),
        Spacer(),
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
                size: AppConstants.iconXXSmall,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            // const SizedBox(width: 4),
            Text(
              headerText,
              style: AppTextStyle.bodySmall.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.darkSlate,
              ),
            ),
            //   const SizedBox(width: 4),
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
                size: AppConstants.iconXXSmall,
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
        borderRadius: BorderRadius.circular(AppConstants.r12),
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
        padding: const EdgeInsets.symmetric(vertical: AppConstants.p10),
        decoration: BoxDecoration(
          color: isActive ? AppColors.surface : Colors.transparent,
          borderRadius: BorderRadius.circular(AppConstants.r10),
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
    bool isOutside = false,
  }) {
    final localDay = DateTime(day.year, day.month, day.day);
    final dateKey = DateTimeUtils.formatToYMD(localDay);
    final status = calendarEvents[dateKey];

    final isWeekend =
        day.weekday == DateTime.saturday || day.weekday == DateTime.sunday;

    Color backgroundColor = AppColors.calendarDefaultBg;
    Color textColor = AppColors.calendarDefaultText;
    Border? border;

    if (isToday) {
      border = Border.all(color: AppColors.calendarTodayBorder, width: 1.5);
    }

    if (status != null) {
      final s = status.toLowerCase();
      if (s == 'present') {
        backgroundColor = AppColors.presentBg;
        textColor = AppColors.presentText;
      } else if (s == 'holiday') {
        backgroundColor = AppColors.holidayBg;
        textColor = AppColors.holidayText;
      } else if (s == 'on leave' || s == 'leave') {
        backgroundColor = AppColors.leaveBg;
        textColor = AppColors.leaveText;
      } else if (s == 'absent') {
        backgroundColor = AppColors.absentBg;
        textColor = AppColors.absentText;
      } else if (s == 'weekend') {
        backgroundColor = AppColors.weekendBg;
        textColor = AppColors.weekendText;
      } else if (s == 'half day' || s == 'half-day') {
        backgroundColor = AppColors.halfDayBg;
        textColor = AppColors.halfDayText;
      }
    } else if (isWeekend) {
      backgroundColor = AppColors.weekendBg;
      textColor = AppColors.weekendText;
    }

    return Container(
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isToday ? AppColors.white : backgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: border,
      ),
      child: Center(
        child: Text(
          day.day.toString(),
          style: AppTextStyle.bodySmall.copyWith(
            color: isOutside ? textColor.withValues(alpha: 0.3) : textColor,
            fontWeight: FontWeight.bold,
          ),
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
            _buildLegendItem(AppColors.presentBg, l10n.present),
            _buildLegendItem(AppColors.absentBg, l10n.absent),
            _buildLegendItem(AppColors.leaveBg, l10n.onLeave),
            _buildLegendItem(AppColors.weekendBg, l10n.weekend),
            _buildLegendItem(AppColors.holidayBg, l10n.holiday),
            _buildLegendItem(AppColors.halfDayBg, l10n.halfDay),
            _buildLegendItem(
              AppColors.white,
              l10n.today,
              border: Border.all(color: AppColors.calendarTodayBorder),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLegendItem(Color color, String label, {Border? border}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
            border: border,
          ),
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

  Widget _buildMonthSummary(AttendanceMonthSummaryEntity? summary) {
    final l10n = AppLocalizations.of(context)!;

    String formatValue(double value) {
      return value % 1 == 0 ? value.toInt().toString() : value.toString();
    }

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppConstants.p15,
        AppConstants.p24,
        AppConstants.p15,
        AppConstants.p8,
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
                  summary != null ? formatValue(summary.presentDays) : "0",
                  AppColors.monthSummaryPresentBg,
                  AppColors.monthSummaryPresentText,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildSummaryItem(
                  l10n.absentDays,
                  summary != null ? formatValue(summary.absentDays) : "0",
                  AppColors.monthSummaryAbsentBg,
                  AppColors.monthSummaryAbsentText,
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
                  summary != null ? formatValue(summary.onLeaveDays) : "0",
                  AppColors.monthSummaryLeaveBg,
                  AppColors.monthSummaryLeaveText,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildHolidaySummaryItem(
                  l10n.holidays,
                  summary?.holidays.toString() ?? "0",
                  AppColors.monthSummaryHolidayBg,
                  AppColors.monthSummaryHolidayText,
                  summary?.holidayDetails ?? [],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHolidaySummaryItem(
    String title,
    String value,
    Color color,
    Color textColor,
    List<HolidayDetailEntity> holidays,
  ) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.p20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppConstants.r16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppTextStyle.bodyMedium.copyWith(
                  color: AppColors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (holidays.length > 1)
                GestureDetector(
                  onTap: () =>
                      HolidayListBottomSheet.showMonthly(context, holidays),
                  child: Icon(
                    Icons.calendar_month_outlined,
                    color: color,
                    size: AppConstants.iconXSmall,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                value,
                style: AppTextStyle.h1.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (holidays.length == 1) ...[
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    "(${holidays.first.name} - ${DateTimeUtils.formatHolidayDate(holidays.first.date)})",
                    style: AppTextStyle.bodySmall.copyWith(
                      color: color.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(
    String title,
    String value,
    Color color,
    Color textColor, {
    bool isFullWidth = false,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.p20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppConstants.r16),
      ),
      child: isFullWidth
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  value,
                  style: AppTextStyle.h1.copyWith(
                    color: textColor,
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
                    color: AppColors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  value,
                  style: AppTextStyle.h1.copyWith(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
    );
  }
}
