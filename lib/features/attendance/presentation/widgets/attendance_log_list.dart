import 'package:dhira_hrms/l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import '../bottom_sheets/holiday_list_bottom_sheet.dart';
import '../../../../core/widgets/collapsible_section.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _fetchInitialData();
      }
    });
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
    context.read<AttendanceBloc>().add(
      AttendanceEvent.pageChangedRequested(date: month),
    );
  }

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
              margin:       EdgeInsets.only(
                left: AppConstants.p20,
                right: AppConstants.p20,
                top: 8.h,
              ),
              padding: const EdgeInsets.all(AppConstants.p20),
              decoration: BoxDecoration(
                color: AppColors.of(context).surface,
                borderRadius: BorderRadius.circular(AppConstants.r20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: _CalendarView(
                calendarEvents: calendarEvents,
                focusedDay: _focusedDay,
                calendarFormat: _calendarFormat,
                onPageChanged: _updateMonth,
                onFormatChanged: (format) =>
                    setState(() => _calendarFormat = format),
                onDayBuild:
                    (day, events, {isToday = false, isOutside = false}) =>
                        _CalendarDay(
                          day: day,
                          calendarEvents: events,
                          isToday: isToday,
                          isOutside: isOutside,
                        ),
                fetchCalendarEvents: _fetchCalendarEvents,
              ),
            ),
            const SizedBox(height: AppConstants.p24),
            _MonthSummary(summary: state.monthSummary),
            const SizedBox(height: AppConstants.p24),
          ],
        );
      },
    );
  }
}

class _CalendarView extends StatelessWidget {
  final Map<String, String> calendarEvents;
  final DateTime focusedDay;
  final CalendarFormat calendarFormat;
  final Function(DateTime) onPageChanged;
  final Function(CalendarFormat) onFormatChanged;
  final Widget Function(
    DateTime,
    Map<String, String>, {
    bool isToday,
    bool isOutside,
  })
  onDayBuild;
  final Function(DateTime) fetchCalendarEvents;

  const _CalendarView({
    required this.calendarEvents,
    required this.focusedDay,
    required this.calendarFormat,
    required this.onPageChanged,
    required this.onFormatChanged,
    required this.onDayBuild,
    required this.fetchCalendarEvents,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: _MonthWeekToggle(
            calendarFormat: calendarFormat,
            onFormatChanged: onFormatChanged,
          ),
        ),
              SizedBox(height: 24.h),
        _CalendarHeader(
          focusedDay: focusedDay,
          calendarFormat: calendarFormat,
          onPrevious: () {
            DateTime newDate;
            if (calendarFormat == CalendarFormat.month) {
              newDate = DateTime(focusedDay.year, focusedDay.month - 1, 1);
            } else {
              newDate = focusedDay.subtract(const Duration(days: 7));
            }
            onPageChanged(newDate);
          },
          onNext: () {
            DateTime newDate;
            if (calendarFormat == CalendarFormat.month) {
              newDate = DateTime(focusedDay.year, focusedDay.month + 1, 1);
            } else {
              newDate = focusedDay.add(const Duration(days: 7));
            }
            onPageChanged(newDate);
          },
        ),
              SizedBox(height: 24.h),
        TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: focusedDay,
          calendarFormat: calendarFormat,
          startingDayOfWeek: StartingDayOfWeek.sunday,
          availableGestures: AvailableGestures.horizontalSwipe,
          headerVisible: false,
          daysOfWeekHeight: 30,
          rowHeight: 48,
          onPageChanged: onPageChanged,
          calendarStyle: const CalendarStyle(outsideDaysVisible: true),
          calendarBuilders: CalendarBuilders(
            outsideBuilder: (context, day, focusedDay) {
              return onDayBuild(day, calendarEvents, isOutside: true);
            },
            dowBuilder: (context, day) {
              final text = calendarFormat == CalendarFormat.month
                  ? DateTimeUtils.formatTo1LetterDay(day)
                  : DateTimeUtils.formatToDayAbbrFull(day);

              return Center(
                child: Text(
                  text,
                  style: AppTextStyle.bodySmall.copyWith(
                    color: AppColors.of(context).calendarDayLabel,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
            defaultBuilder: (context, day, focusedDay) {
              return onDayBuild(day, calendarEvents);
            },
            todayBuilder: (context, day, focusedDay) {
              return onDayBuild(day, calendarEvents, isToday: true);
            },
          ),
        ),
              SizedBox(height: 10.h),
        Divider(height: 0.5.h),
        const _Legend(),
      ],
    );
  }
}

class _CalendarHeader extends StatelessWidget {
  final DateTime focusedDay;
  final CalendarFormat calendarFormat;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  const _CalendarHeader({
    required this.focusedDay,
    required this.calendarFormat,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    String headerText = '';

    if (calendarFormat == CalendarFormat.month) {
      headerText = '${DateTimeUtils.formatToMonthName(focusedDay)} ';
    } else {
      final firstDayOfWeek = focusedDay.subtract(
        Duration(days: focusedDay.weekday % 7),
      );
      final lastDayOfWeek = firstDayOfWeek.add(const Duration(days: 6));

      if (firstDayOfWeek.month != lastDayOfWeek.month) {
        final startMonth = DateTimeUtils.formatToMonthAbbr(firstDayOfWeek);
        final endMonth = DateTimeUtils.formatToMonthAbbr(lastDayOfWeek);
        headerText =
            '${firstDayOfWeek.day.toString().padLeft(2, '0')} $startMonth - ${lastDayOfWeek.day.toString().padLeft(2, '0')} $endMonth ';
      } else {
        final month = DateTimeUtils.formatToMonthAbbr(focusedDay);
        headerText =
            '${firstDayOfWeek.day.toString().padLeft(2, '0')} - ${lastDayOfWeek.day.toString().padLeft(2, '0')} $month ';
      }
    }

    return Row(
      children: [
        Expanded(
          child: Text(
            l10n.attendanceCalendar,
            style: AppTextStyle.h3.copyWith(
              fontWeight: FontWeight.w800,
              color: AppColors.of(context).darkSlate,
              height: 1.1.h,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Row(
          children: [
            IconButton(
              onPressed: onPrevious,
              icon: Icon(
                Icons.chevron_left,
                color: AppColors.of(context).blueIcon,
                size: AppConstants.iconXXSmall,
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
            Text(
              headerText,
              style: AppTextStyle.bodySmall.copyWith(
                fontWeight: FontWeight.w800,
                color: AppColors.of(context).darkSlate,
              ),
            ),
            IconButton(
              onPressed: onNext,
              icon: Icon(
                Icons.chevron_right,
                color: AppColors.of(context).blueIcon,
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
}

class _MonthWeekToggle extends StatelessWidget {
  final CalendarFormat calendarFormat;
  final Function(CalendarFormat) onFormatChanged;

  const _MonthWeekToggle({
    required this.calendarFormat,
    required this.onFormatChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      width: double.infinity,
      padding:       EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppColors.of(context).slateBg,
        borderRadius: BorderRadius.circular(AppConstants.r12),
      ),
      child: Row(
        children: [
          Expanded(
            child: _ToggleItem(
              label: l10n.month,
              isActive: calendarFormat == CalendarFormat.month,
              onTap: () => onFormatChanged(CalendarFormat.month),
            ),
          ),
          Expanded(
            child: _ToggleItem(
              label: l10n.week,
              isActive: calendarFormat == CalendarFormat.week,
              onTap: () => onFormatChanged(CalendarFormat.week),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _ToggleItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppConstants.p10),
        decoration: BoxDecoration(
          color: isActive ? AppColors.of(context).surface : Colors.transparent,
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
              fontSize: AppConstants.fs14,
              fontWeight: FontWeight.w700,
              color: isActive
                  ? AppColors.of(context).blueIcon
                  : AppColors.of(context).placeholdergrey,
            ),
          ),
        ),
      ),
    );
  }
}

class _CalendarDay extends StatelessWidget {
  final DateTime day;
  final Map<String, String> calendarEvents;
  final bool isToday;
  final bool isOutside;

  const _CalendarDay({
    required this.day,
    required this.calendarEvents,
    this.isToday = false,
    this.isOutside = false,
  });

  @override
  Widget build(BuildContext context) {
    final localDay = DateTime(day.year, day.month, day.day);
    final dateKey = DateTimeUtils.formatToYMD(localDay);
    final status = calendarEvents[dateKey];

    final isWeekend =
        day.weekday == DateTime.saturday || day.weekday == DateTime.sunday;

    Color backgroundColor = AppColors.of(context).calendarDefaultBg;
    Color textColor = AppColors.of(context).calendarDefaultText;
    Border? border;

    if (isToday) {
      border = Border.all(
        color: AppColors.of(context).calendarTodayBorder,
        width: 1.5.w,
      );
    }

    if (status != null) {
      final s = status.toLowerCase();
      if (s == AttendanceStatus.present) {
        backgroundColor = AppColors.of(context).presentBg;
        textColor = AppColors.of(context).presentText;
      } else if (s == AttendanceStatus.holiday) {
        backgroundColor = AppColors.of(context).holidayBg;
        textColor = AppColors.of(context).holidayText;
      } else if (s == AttendanceStatus.onLeave || s == AttendanceStatus.leave) {
        backgroundColor = AppColors.of(context).leaveBg;
        textColor = AppColors.of(context).leaveText;
      } else if (s == AttendanceStatus.absent) {
        backgroundColor = AppColors.of(context).absentBg;
        textColor = AppColors.of(context).absentText;
      } else if (s == AttendanceStatus.weekend) {
        backgroundColor = AppColors.of(context).weekendBg;
        textColor = AppColors.of(context).weekendText;
      } else if (s == AttendanceStatus.halfDay ||
          s == AttendanceStatus.halfDayAlt) {
        backgroundColor = AppColors.of(context).halfDayBg;
        textColor = AppColors.of(context).halfDayText;
      }
    } else if (isWeekend) {
      backgroundColor = AppColors.of(context).weekendBg;
      textColor = AppColors.of(context).weekendText;
    }

    if (isToday) {
      textColor = AppColors.of(context).calendarTodayBorder;
    }

    return Container(
      margin: const EdgeInsets.all(AppConstants.p4),
      decoration: BoxDecoration(
        color: isToday
            ? AppColors.of(context).surfaceContainerLowest
            : backgroundColor,
        borderRadius: BorderRadius.circular(AppConstants.r8),
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
}

class _Legend extends StatelessWidget {
  const _Legend();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Column(
      children: [
              SizedBox(height: 16.h),
        Wrap(
          spacing: 16,
          runSpacing: 10,
          children: [
            _LegendItem(
              color: AppColors.of(context).presentBg,
              label: l10n.present,
            ),
            _LegendItem(
              color: AppColors.of(context).absentBg,
              label: l10n.absent,
            ),
            _LegendItem(
              color: AppColors.of(context).leaveBg,
              label: l10n.onLeave,
            ),
            _LegendItem(
              color: AppColors.of(context).weekendBg,
              label: l10n.weekend,
            ),
            _LegendItem(
              color: AppColors.of(context).holidayBg,
              label: l10n.holiday,
            ),
            _LegendItem(
              color: AppColors.of(context).halfDayBg,
              label: l10n.halfDay,
            ),
            _LegendItem(
              color: AppColors.of(context).surfaceContainerLowest,
              label: l10n.today,
              border: Border.all(
                color: AppColors.of(context).calendarTodayBorder,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MonthSummary extends StatelessWidget {
  final AttendanceMonthSummaryEntity? summary;

  const _MonthSummary({this.summary});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    String formatValue(double value) {
      return value % 1 == 0 ? value.toInt().toString() : value.toString();
    }

    return CollapsibleSection(
      initiallyExpanded: false,
      title: Row(
        children: [
          Text(
            l10n.monthSummary,
            style: AppTextStyle.h3.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
              fontSize: AppConstants.f15.sp
            ),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppConstants.p20,
          0,
          AppConstants.p20,
          AppConstants.p8,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
                  SizedBox(height: 20.h),
            Row(
              children: [
                Expanded(
                  child: _SummaryItem(
                    title: l10n.presentDays,
                    value: summary != null
                        ? formatValue(summary!.presentDays)
                        : "0",
                    color: AppColors.of(context).monthSummaryPresentBg,
                    textColor: AppColors.of(context).monthSummaryPresentText,
                  ),
                ),
                      SizedBox(width: 16.w),
                Expanded(
                  child: _SummaryItem(
                    title: l10n.absentDays,
                    value: summary != null
                        ? formatValue(summary!.absentDays)
                        : "0",
                    color: AppColors.of(context).monthSummaryAbsentBg,
                    textColor: AppColors.of(context).monthSummaryAbsentText,
                  ),
                ),
              ],
            ),
                  SizedBox(height: 16.h),
            Row(
              children: [
                Expanded(
                  child: _SummaryItem(
                    title: l10n.onLeave,
                    value: summary != null
                        ? formatValue(summary!.onLeaveDays)
                        : "0",
                    color: AppColors.of(context).monthSummaryLeaveBg,
                    textColor: AppColors.of(context).monthSummaryLeaveText,
                  ),
                ),
                      SizedBox(width: 16.w),
                Expanded(
                  child: _HolidaySummaryItem(
                    title: l10n.holidays,
                    value: summary?.holidays.toString() ?? "0",
                    color: AppColors.of(context).monthSummaryHolidayBg,
                    textColor: AppColors.of(context).monthSummaryHolidayText,
                    holidays: summary?.holidayDetails ?? [],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final Color textColor;

  const _SummaryItem({
    required this.title,
    required this.value,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppConstants.p20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(AppConstants.r16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyle.bodySmall.copyWith(
              color: AppColors.of(context).textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
                SizedBox(height: 8.h),
          Text(
            value,
            style: AppTextStyle.h2.copyWith(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _HolidaySummaryItem extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final Color textColor;
  final List<HolidayDetailEntity> holidays;

  const _HolidaySummaryItem({
    required this.title,
    required this.value,
    required this.color,
    required this.textColor,
    required this.holidays,
  });

  @override
  Widget build(BuildContext context) {
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
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: AppColors.of(context).black,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              if (holidays.length > 1)
                GestureDetector(
                  onTap: () =>
                      HolidayListBottomSheet.showMonthly(context, holidays),
                  child: Icon(
                    Icons.calendar_month_outlined,
                    color: AppColors.of(context).accent,
                    size: AppConstants.iconXSmall,
                  ),
                ),
            ],
          ),
                SizedBox(height: 8.h),
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
                      SizedBox(width: 8.w),
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
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final Border? border;

  const _LegendItem({required this.color, required this.label, this.border});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12.w,
          height: 12.h,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4.r),
            border: border,
          ),
        ),
              SizedBox(width: 8.w),
        Text(
          label,
          style: AppTextStyle.bodySmall.copyWith(
            color: AppColors.of(context).slateText,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
