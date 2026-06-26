import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/core/error/failures.dart';
import 'package:dhira_hrms/core/services/local_storage_service.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/calendar_entity.dart';
import 'package:dhira_hrms/features/calendar/domain/usecases/get_calendar_events_usecase.dart';
import 'package:dhira_hrms/features/calendar/domain/usecases/get_calendar_summary_usecase.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/team_leave_entity.dart';
import 'package:dhira_hrms/features/calendar/domain/usecases/get_team_leaves_usecase.dart';
import 'package:dhira_hrms/features/calendar/domain/usecases/get_attendance_punch_summary_usecase.dart';
import 'package:dhira_hrms/features/calendar/domain/usecases/get_leave_history_usecase.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/attendance_punch_summary_entity.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/leave_history_entity.dart';
import 'calendar_event.dart';
import 'calendar_state.dart';

class CalendarBloc extends Bloc<CalendarEvent, CalendarState> {
  final GetCalendarMonthEventsUseCase getCalendarEventsUseCase;
  final GetCalendarSummaryUseCase getCalendarSummaryUseCase;
  final GetCalendarTeamLeavesUseCase getTeamLeavesUseCase;
  final LocalStorageService localStorageService;
  final GetCalendarPunchSummaryUseCase getAttendancePunchSummaryUseCase;
  final GetCalendarLeaveHistoryUseCase getLeaveHistoryUseCase;

  CalendarBloc({
    required this.getCalendarEventsUseCase,
    required this.getCalendarSummaryUseCase,
    required this.getTeamLeavesUseCase,
    required this.localStorageService,
    required this.getAttendancePunchSummaryUseCase,
    required this.getLeaveHistoryUseCase,
  }) : super(CalendarState.initial()) {
    on<CalendarStarted>(_onStarted);
    on<CalendarMonthChanged>(_onMonthChanged);
    on<CalendarDaySelected>(_onDaySelected);
  }

  Future<void> _onStarted(
    CalendarStarted event,
    Emitter<CalendarState> emit,
  ) async {
    final empid = localStorageService.getEmpId();
    if (empid == null || empid.isEmpty) {
      emit(state.copyWith(
        status: CalendarStatus.error,
        errorMessage: "Employee ID not found",
      ));
      return;
    }
    emit(state.copyWith(
      status: CalendarStatus.loading,
      employeeId: empid,
    ));
    await _fetchData(DateTime.now(), emit, employeeId: empid);
  }

  Future<void> _onMonthChanged(
    CalendarMonthChanged event,
    Emitter<CalendarState> emit,
  ) async {
    await _fetchData(event.month, emit, isMonthChange: true);
  }

  Future<void> _onDaySelected(
    CalendarDaySelected event,
    Emitter<CalendarState> emit,
  ) async {
    if (state.status == CalendarStatus.loaded) {
      LeaveHistoryEntity? matchingLeave;
      final history = state.leaveHistory;
      if (history != null) {
        final targetYMD = DateTime(event.day.year, event.day.month, event.day.day);
        for (final leave in history) {
          try {
            final start = leave.parsedFromDate;
            final end = leave.parsedToDate;
            final startYMD = DateTime(start.year, start.month, start.day);
            final endYMD = DateTime(end.year, end.month, end.day);
            if ((targetYMD.isAfter(startYMD) || targetYMD.isAtSameMomentAs(startYMD)) &&
                (targetYMD.isBefore(endYMD) || targetYMD.isAtSameMomentAs(endYMD))) {
              matchingLeave = leave;
              break;
            }
          } catch (_) {}
        }
      }

      emit(state.copyWith(
        selectedDay: event.day,
        selectedDayLeaveDetails: matchingLeave,
        isPunchSummaryLoading: true,
        selectedDayPunchSummary: null,
      ));

      final dateStr = DateTimeUtils.formatToYMD(event.day);
      final punchSummaryResult = await getAttendancePunchSummaryUseCase(attendanceDate: dateStr);

      if (state.status == CalendarStatus.loaded && state.selectedDay == event.day) {
        AttendancePunchSummaryEntity? punchSummary;
        punchSummaryResult.fold(
          (failure) => null,
          (summary) => punchSummary = summary,
        );
        emit(state.copyWith(
          selectedDayPunchSummary: punchSummary,
          isPunchSummaryLoading: false,
        ));
      }
    }
  }

  Future<void> _fetchData(
    DateTime month,
    Emitter<CalendarState> emit, {
    bool isMonthChange = false,
    String? employeeId,
  }) async {
    final empid = employeeId ?? state.employeeId ?? localStorageService.getEmpId();
    if (empid == null || empid.isEmpty) {
      emit(state.copyWith(
        status: CalendarStatus.error,
        errorMessage: "Employee ID not found",
      ));
      return;
    }

    List<TeamLeaveEntity>? existingLeaves;
    List<LeaveHistoryEntity>? existingLeaveHistory;

    if (isMonthChange && state.status == CalendarStatus.loaded) {
      existingLeaves = state.teamLeaves;
      existingLeaveHistory = state.leaveHistory;
      emit(state.copyWith(
        status: CalendarStatus.loading,
        focusedMonth: month,
        events: const {},
        summary: const CalendarSummaryEntity(
          presentDays: 0.0,
          absentDays: 0.0,
          onLeaveDays: 0.0,
          holidays: 0,
          weekendDays: 0,
          totalWorkingDays: 0,
          attendancePercentage: 0.0,
          holidayDetails: [],
        ),
        selectedDay: null,
        selectedDayPunchSummary: null,
        selectedDayLeaveDetails: null,
      ));
    } else {
      emit(state.copyWith(
        status: CalendarStatus.loading,
        employeeId: empid,
      ));
    }

    final fromDate = DateTimeUtils.formatToYMD(month.firstDayOfMonth);
    final toDate = DateTimeUtils.formatToYMD(month.lastDayOfMonth);
    final todayStr = DateTimeUtils.formatToYMD(DateTime.now());

    final results = await Future.wait([
      getCalendarEventsUseCase(GetCalendarMonthEventsParams(
        employee: empid,
        fromDate: fromDate,
        toDate: toDate,
      )),
      getCalendarSummaryUseCase(GetCalendarSummaryParams(
        employee: empid,
        month: month.month,
        year: month.year,
      )),
      existingLeaves != null
          ? Future.value(right<Failure, List<TeamLeaveEntity>>(existingLeaves))
          : getTeamLeavesUseCase(GetCalendarTeamLeavesParams(
              employee: empid,
              fromDate: todayStr,
              toDate: todayStr,
            )),
      existingLeaveHistory != null
          ? Future.value(right<Failure, List<LeaveHistoryEntity>>(existingLeaveHistory))
          : getLeaveHistoryUseCase(GetCalendarLeaveHistoryParams(employee: empid)),
    ]);

    final eventsResult = results[0] as Either<Failure, Map<String, String>>;
    final summaryResult = results[1] as Either<Failure, CalendarSummaryEntity>;
    final teamLeavesResult = results[2] as Either<Failure, List<TeamLeaveEntity>>;
    final leaveHistoryResult = results[3] as Either<Failure, List<LeaveHistoryEntity>>;

    if (eventsResult.isLeft()) {
      eventsResult.fold(
        (failure) => emit(state.copyWith(
          status: CalendarStatus.error,
          errorMessage: failure.message,
        )),
        (_) {},
      );
      return;
    }

    if (summaryResult.isLeft()) {
      summaryResult.fold(
        (failure) => emit(state.copyWith(
          status: CalendarStatus.error,
          errorMessage: failure.message,
        )),
        (_) {},
      );
      return;
    }

    final events = eventsResult.getOrElse(() => const {});
    final summary = summaryResult.getOrElse(() => throw Exception("Unexpected state"));
    final teamLeaves = teamLeavesResult.getOrElse(() => const []);
    final leaveHistory = leaveHistoryResult.getOrElse(() => const []);

    emit(state.copyWith(
      status: CalendarStatus.loaded,
      events: events,
      summary: summary,
      focusedMonth: month,
      selectedDay: (month.year == DateTime.now().year && month.month == DateTime.now().month)
          ? DateTime.now()
          : null,
      teamLeaves: teamLeaves,
      leaveHistory: leaveHistory,
    ));
  }
}
