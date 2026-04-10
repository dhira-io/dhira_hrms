import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import '../../../../core/theme/app_text_style.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/constants/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/storage_constants.dart';
import '../bloc/attendance_bloc.dart';
import '../bloc/attendance_event.dart';
import '../../domain/entities/attendance_entities.dart';

class AttendanceLogList extends StatefulWidget {
  const AttendanceLogList({super.key});

  @override
  State<AttendanceLogList> createState() => _AttendanceLogListState();
}

class _AttendanceLogListState extends State<AttendanceLogList> {
  bool _isCalendarView = true;
  late DateTime _focusedDay;
  late List<AttendanceLogEntity> _dummyLogs;
  String? _empid;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _dummyLogs = _generateDummyLogs(_focusedDay);
    _loadEmpId();
  }

  Future<void> _loadEmpId() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _empid = prefs.getString(StorageConstants.empId);
    });
  }

  void _updateMonth(DateTime date) {
    setState(() {
      _focusedDay = date;
      _dummyLogs = _generateDummyLogs(date);
    });
  }

  List<AttendanceLogEntity> _generateDummyLogs(DateTime month) {
    final logs = <AttendanceLogEntity>[];
    final now = DateTime.now();
    final todayStr = DateFormat('yyyy-MM-dd').format(now);
    final daysInMonth = DateTime(month.year, month.month + 1, 0).day;

    for (var i = 1; i <= daysInMonth; i++) {
      final current = DateTime(month.year, month.month, i);
      final dateStr = DateFormat('yyyy-MM-dd').format(current);

      if (current.isAfter(now)) break;

      final isWeekend =
          current.weekday == DateTime.saturday ||
          current.weekday == DateTime.sunday;

      String status = 'Present';
      double? hours = 9.2;
      String inTime = '09:00 AM';
      String? outTime = '06:12 PM';

      if (isWeekend) {
        status = 'Weekend';
        hours = 0.0;
        inTime = '-';
        outTime = '-';
      } else if (i % 7 == 0) {
        status = 'Leave';
        hours = 0.0;
        inTime = '-';
        outTime = '-';
      } else if (i % 11 == 0) {
        status = 'Holiday';
        hours = 0.0;
        inTime = '-';
        outTime = '-';
      }

      if (dateStr == todayStr) {
        status = 'Present';
        inTime = '09:05 AM';
        outTime = null;
        hours = null;
      }

      logs.add(
        AttendanceLogEntity(
          date: dateStr,
          dayName: DateFormat('EEEE').format(current),
          inTime: inTime,
          outTime: outTime,
          workingHours: hours,
          status: status,
        ),
      );
    }
    return logs.reversed.toList();
  }

  AttendanceLogEntity? _getLogForDate(DateTime dt) {
    final dateStr = DateFormat('yyyy-MM-dd').format(dt);
    try {
      return _dummyLogs.firstWhere((log) => log.date == dateStr);
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header outside the white card
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppConstants.p15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                  children: [
                    Text(
                      'Attendance Log',
                      style: AppTextStyle.h3.copyWith(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9), // Subtle blue-grey background
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.border.withValues(alpha: 0.3),
                  ),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => _isCalendarView = true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: _isCalendarView
                              ? AppColors.surface
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: _isCalendarView
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.08),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : [],
                        ),
                        child: Icon(
                          Icons.calendar_month,
                          size: 16,
                          color: _isCalendarView
                              ? AppColors.primary
                              : Colors.grey.shade500,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _isCalendarView = false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: !_isCalendarView
                              ? AppColors.surface
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: !_isCalendarView
                              ? [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.08),
                                    blurRadius: 4,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : [],
                        ),
                        child: Icon(
                          Icons.list,
                          size: 16,
                          color: !_isCalendarView
                              ? AppColors.primary
                              : Colors.grey.shade500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        // Switch between views
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              if (_empid != null) {
                context.read<AttendanceBloc>().add(
                  AttendanceEvent.logRequested(_empid!),
                );
                context.read<AttendanceBloc>().add(
                  AttendanceEvent.checkStatusRequested(_empid!),
                );
              }
            },
            child: _isCalendarView
                ? SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Container(
                      margin: const EdgeInsets.only(
                        left: AppConstants.p15,
                        right: AppConstants.p15,
                        top: 4,
                        bottom: AppConstants.p10,
                      ),
                      padding: const EdgeInsets.fromLTRB(
                        AppConstants.p20,
                        AppConstants.p12,
                        AppConstants.p20,
                        AppConstants.p20,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppConstants.r20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: _buildCalendarView(),
                    ),
                  )
                : _buildListView(),
          ),
        ),
      ],
    );
  }

  Widget _buildCalendarView() {
    return Column(
      children: [
        // Custom Month Title
        Text(
          DateFormat('MMMM').format(_focusedDay),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        TableCalendar(
          firstDay: DateTime.utc(2020, 1, 1),
          lastDay: DateTime.utc(2030, 12, 31),
          focusedDay: _focusedDay,
          calendarFormat: CalendarFormat.month,
          headerVisible: false,
          daysOfWeekHeight: 20,
          rowHeight: 40,
          onPageChanged: (focusedDay) {
            _updateMonth(focusedDay);
          },
          calendarStyle: const CalendarStyle(outsideDaysVisible: false),

          calendarBuilders: CalendarBuilders(
            dowBuilder: (context, day) {
              final text = DateFormat.E().format(day).substring(0, 2);
              return Center(
                child: Text(
                  text,
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
            defaultBuilder: (context, day, focusedDay) {
              return _buildCalendarDay(day);
            },
            todayBuilder: (context, day, focusedDay) {
              return _buildCalendarDay(day, isToday: true);
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegendItem(
              const Color(0xFF65D2A5),
              'Present',
            ), // Green outline
            const SizedBox(width: 15),
            _buildLegendItem(
              const Color(0xFFFFC043),
              'Holiday',
            ), // Yellow outline
            const SizedBox(width: 15),
            _buildLegendItem(const Color(0xFFF984A1), 'Leave'), // Pink outline
          ],
        ),
      ],
    );
  }

  Widget _buildCalendarDay(DateTime day, {bool isToday = false}) {
    final log = _getLogForDate(day);
    BoxDecoration? decoration;
    Color textColor = Colors.black87;

    // Default transparent decoration so layout shifts don't happen
    decoration = const BoxDecoration(
      color: Colors.transparent,
      shape: BoxShape.circle,
    );

    if (log != null) {
      if (log.status == 'Present') {
        decoration = const BoxDecoration(
          color: Color(0xFFD1FAE5),
          shape: BoxShape.circle,
        ); // Light green
        textColor = const Color(0xFF0F766E); // Dark teal text
      } else if (log.status == 'Holiday') {
        decoration = const BoxDecoration(
          color: Color(0xFFFEF3C7),
          shape: BoxShape.circle,
        ); // Light yellow
        textColor = const Color(0xFF92400E); // Dark orange/brown text
      } else if (log.status == 'Leave') {
        decoration = const BoxDecoration(
          color: Color(0xFFFCE7F3),
          shape: BoxShape.circle,
        ); // Light pink
        textColor = const Color(0xFF9D174D); // Dark pink text
      }
    }

    if (isToday) {
      decoration = const BoxDecoration(
        color: Color(0xFFD1FAE5),
        shape: BoxShape.circle,
      );
      textColor = const Color(0xFF0F766E);
    }

    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: decoration,
      alignment: Alignment.center,
      child: Text(
        '${day.day}',
        style: TextStyle(
          color: textColor,
          fontWeight: isToday ? FontWeight.bold : FontWeight.w600,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildLegendItem(Color ringColor, String label) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(color: ringColor, width: 2),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildListView() {
    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.p15,
        vertical: 8,
      ),
      itemCount: _dummyLogs.length,
      itemBuilder: (context, index) {
        final log = _dummyLogs[index];
        final dt = DateTime.parse(log.date);
        final monthStr = DateFormat('MMM').format(dt).toUpperCase();
        final dayStr = DateFormat('dd').format(dt);
        final isWeekend = log.status == 'Weekend';
        final isLeave = log.status == 'Leave';

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
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      dayStr,
                      style: const TextStyle(
                        fontSize: 18,
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
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (isWeekend)
                      const Text(
                        'Weekend',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      )
                    else if (isLeave)
                      const Text(
                        'Leave',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      )
                    else
                      Text(
                        '${log.inTime} - ${log.outTime ?? "-"}',
                        style: const TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
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
                    const Text(
                      '-',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  else
                    Text(
                      '${log.workingHours!.floor()}h ${((log.workingHours! % 1) * 60).floor()}m',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
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
}
