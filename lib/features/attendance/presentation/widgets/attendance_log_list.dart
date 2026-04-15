import 'package:dhira_hrms/features/attendance/presentation/bloc/attendance_state.dart';
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
  String? _empid;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
    _focusedDay = DateTime.now();
    _loadEmpId();
  }

  Future<void> _loadEmpId() async {
    final prefs = await SharedPreferences.getInstance();
    // setState(() {
    //   _empid = prefs.getString(StorageConstants.empId);
    // });
    _empid = "EMP-00045";
    if (_empid != null) {
      // Fetch status and logs
      context.read<AttendanceBloc>().add(AttendanceEvent.logRequested(_empid!));

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
    if (_empid == null) return;
    final firstDay = DateTime(month.year, month.month, 1);
    final lastDay = DateTime(month.year, month.month + 1, 0);

    context.read<AttendanceBloc>().add(
      AttendanceEvent.calendarEventsRequested(
        empid: _empid!,
        fromDate: DateFormat('yyyy-MM-dd').format(firstDay),
        toDate: DateFormat('yyyy-MM-dd').format(lastDay),
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
        state.maybeWhen(
          loaded: (status, logs, events) {
            _currentLogs = logs;
          },
          orElse: () {},
        );

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
                      color: const Color(
                        0xFFF1F5F9,
                      ), // Subtle blue-grey background
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
                                        color: Colors.black.withValues(
                                          alpha: 0.08,
                                        ),
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
                                        color: Colors.black.withValues(
                                          alpha: 0.08,
                                        ),
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
                    _fetchCalendarEvents(_focusedDay);
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
                            borderRadius: BorderRadius.circular(
                              AppConstants.r20,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: _buildCalendarView(calendarEvents),
                        ),
                      )
                    : _buildListView(_currentLogs),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildCalendarView(Map<String, String> calendarEvents) {
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
              return _buildCalendarDay(day, calendarEvents);
            },
            todayBuilder: (context, day, focusedDay) {
              return _buildCalendarDay(day, calendarEvents, isToday: true);
            },
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildLegendItem(const Color(0xFF00A63E), 'Present'),
            const SizedBox(width: 10),
            _buildLegendItem(const Color(0xFF9810FA), 'Holiday'),
            const SizedBox(width: 10),
            _buildLegendItem(const Color(0xFF0084D1), 'On Leave'),
            const SizedBox(width: 10),
            _buildLegendItem(const Color(0xFFE7000B), 'Absent'),
          ],
        ),
      ],
    );
  }

  Widget _buildCalendarDay(
    DateTime day,
    Map<String, String> calendarEvents, {
    bool isToday = false,
  }) {
    final localDay = DateTime(day.year, day.month, day.day);
    final dateKey = DateFormat('yyyy-MM-dd').format(localDay);
    final status = calendarEvents[dateKey];
    BoxDecoration? decoration;
    Color textColor = Colors.black87;

    decoration = const BoxDecoration(
      color: Colors.transparent,
      shape: BoxShape.circle,
    );

    if (status != null) {
      if (status == 'Present') {
        decoration = const BoxDecoration(
          color: Color(0xFF00A63E),
          shape: BoxShape.circle,
        );
        textColor = Colors.white;
      } else if (status == 'Holiday') {
        decoration = const BoxDecoration(
          color: Color(0xFF9810FA),
          shape: BoxShape.circle,
        );
        textColor = Colors.white;
      } else if (status == 'On Leave' || status == 'Leave') {
        decoration = const BoxDecoration(
          color: Color(0xFF0084D1),
          shape: BoxShape.circle,
        );
        textColor = Colors.white;
      } else if (status == 'Absent') {
        decoration = const BoxDecoration(
          color: Color(0xFFE7000B),
          shape: BoxShape.circle,
        );
        textColor = Colors.white;
      }
    }

    if (isToday) {
      // If there's no status yet but it's today, we might want a special highlight
      // but if the stast Color(0xFF9D174D);tus is already 'Present', we keep it green.
      if (status == null) {
        decoration = BoxDecoration(
          color: Colors.blue.shade50,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.primary, width: 1),
        );
        textColor = AppColors.primary;
      }
    }

    return Container(
      margin: const EdgeInsets.all(4.0),
      decoration: decoration,
      alignment: Alignment.center,
      child: Text(
        '${day.day}',
        style: TextStyle(
          color: textColor,
          fontWeight: (isToday || status != null)
              ? FontWeight.bold
              : FontWeight.w500,
          fontSize: 13,
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

  Widget _buildListView(List<AttendanceLogEntity> logs) {
    if (logs.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.only(top: 50),
          child: Text('No logs found for the last 5 days'),
        ),
      );
    }

    return ListView.builder(
      physics: const AlwaysScrollableScrollPhysics(),
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
        final isAbsent = log.status == 'Absent';

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
                      log.workingHours ?? '-',
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
