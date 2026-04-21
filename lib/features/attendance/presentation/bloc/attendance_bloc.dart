import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/features/attendance/domain/entities/attendance_log_entity.dart';
import 'package:dhira_hrms/features/attendance/domain/usecases/end_break_usecase.dart';
import 'package:dhira_hrms/features/attendance/domain/usecases/get_work_durations_usecase.dart';
import 'package:dhira_hrms/features/attendance/domain/usecases/get_attendance_month_summary_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_attendance_logs_usecase.dart';
import '../../domain/usecases/get_calendar_events_usecase.dart';
import '../../domain/usecases/get_checkin_status_usecase.dart';
import '../../domain/usecases/punch_in_usecase.dart';
import '../../domain/usecases/punch_out_usecase.dart';
import '../../domain/usecases/start_break_usecase.dart';
import 'dart:async';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/storage_constants.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final PunchInUseCase punchInUseCase;
  final PunchOutUseCase punchOutUseCase;
  final GetCheckinStatusUseCase getCheckinStatusUseCase;
  final GetAttendanceLogsUseCase getAttendanceLogsUseCase;
  final GetCalendarEventsUseCase getCalendarEventsUseCase;
  final StartBreakUseCase startBreakUseCase;
  final EndBreakUseCase endBreakUseCase;
  final GetWorkDurationsUseCase getWorkDurationsUseCase;
  final GetAttendanceMonthSummaryUseCase getAttendanceMonthSummaryUseCase;

  List<AttendanceLogEntity> _cachedLogs = [];

  AttendanceBloc({
    required this.punchInUseCase,
    required this.punchOutUseCase,
    required this.getCheckinStatusUseCase,
    required this.getAttendanceLogsUseCase,
    required this.getCalendarEventsUseCase,
    required this.startBreakUseCase,
    required this.endBreakUseCase,
    required this.getWorkDurationsUseCase,
    required this.getAttendanceMonthSummaryUseCase,
  }) : super(const AttendanceState.initial()) {
    on<Started>((event, emit) => _onStarted(emit));
    on<PunchInRequested>(
      (event, emit) => _onPunchInRequested(emit),
    );
    on<PunchOutRequested>(
      (event, emit) => _onPunchOutRequested(emit),
    );
    on<CheckStatusRequested>(
      (event, emit) => _loadAttendanceData(emit, useCache: true),
    );
    on<CalendarEventsRequested>(
      (event, emit) => _onCalendarEventsRequested(
        event.fromDate,
        event.toDate,
        emit,
      ),
    );
    on<LogRequested>((event, emit) => _loadAttendanceData(emit));
    on<TakeBreakRequested>(
      (event, emit) => _onTakeBreakRequested(emit),
    );
    on<EndBreakRequested>(
      (event, emit) => _onEndBreakRequested(emit),
    );
    on<WorkDurationsRequested>(
      (event, emit) => _loadAttendanceData(emit, useCache: true),
    );
    on<MonthSummaryRequested>(
      (event, emit) => _onMonthSummaryRequested(
        event.month,
        event.year,
        emit,
      ),
    );
  }

  Future<String?> _getEmpId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(StorageConstants.empId);
  }

  Future<void> _onStarted(Emitter<AttendanceState> emit) async {
    final empid = await _getEmpId();
    if (empid == null) return;
    emit(
      AttendanceState.loading(
        calendarEvents: state.calendarEvents,
        actionType: AttendanceActionType.checkStatus,
      ),
    );
    await _loadAttendanceData(emit);
  }

  Future<void> _onPunchInRequested(
    Emitter<AttendanceState> emit,
  ) async {
    final empid = await _getEmpId();
    if (empid == null) return;
    emit(
      AttendanceState.loading(
        calendarEvents: state.calendarEvents,
        actionType: AttendanceActionType.punchIn,
        monthSummary: state.monthSummary,
      ),
    );
    final result = await punchInUseCase(empid);
    await result.fold(
      (failure) async {
        emit(
          AttendanceState.error(
            failure.message,
            calendarEvents: state.calendarEvents,
            monthSummary: state.monthSummary,
          ),
        );
        await _loadAttendanceData(
          emit,
          useCache: true,
        ); // Reload last known state without logs
      },
      (status) async {
        // Only refresh status and durations
        await _loadAttendanceData(
          emit,
          useCache: true,
          messageOverride: status.message,
        );
      },
    );
  }

  Future<void> _onPunchOutRequested(
    Emitter<AttendanceState> emit,
  ) async {
    final empid = await _getEmpId();
    if (empid == null) return;
    emit(
      AttendanceState.loading(
        calendarEvents: state.calendarEvents,
        actionType: AttendanceActionType.punchOut,
        monthSummary: state.monthSummary,
      ),
    );
    final result = await punchOutUseCase(empid);
    await result.fold(
      (failure) async {
        emit(
          AttendanceState.error(
            failure.message,
            calendarEvents: state.calendarEvents,
            monthSummary: state.monthSummary,
          ),
        );
        await _loadAttendanceData(
          emit,
          useCache: true,
        ); // Reload last known state without logs
      },
      (status) async {
        // Only refresh status and durations
        await _loadAttendanceData(
          emit,
          useCache: true,
          messageOverride: status.message,
        );
      },
    );
  }

  Future<void> _onCalendarEventsRequested(
    String fromDate,
    String toDate,
    Emitter<AttendanceState> emit,
  ) async {
    final empid = await _getEmpId();
    if (empid == null) return;
    final currentState = state;

    final result = await getCalendarEventsUseCase(
      employee: empid,
      fromDate: fromDate,
      toDate: toDate,
    );

    result.fold(
      (failure) {
        emit(
          AttendanceState.error(
            failure.message,
            calendarEvents: currentState.calendarEvents,
            monthSummary: currentState.monthSummary,
            userName: _userName,
            profileImage: _profileImage,
          ),
        );
      },
      (events) {
        // Use map to safely update calendarEvents regardless of state subclass
        emit(
          state.map(
            initial: (s) => s.copyWith(calendarEvents: events),
            loading: (s) => s.copyWith(calendarEvents: events),
            loaded: (s) => s.copyWith(calendarEvents: events),
            error: (s) => s.copyWith(calendarEvents: events),
          ),
        );
      },
    );
  }

  Future<void> _onMonthSummaryRequested(
    int month,
    int year,
    Emitter<AttendanceState> emit,
  ) async {
    final empid = await _getEmpId();
    if (empid == null) return;
    final currentState = state;

    final result = await getAttendanceMonthSummaryUseCase(
      employee: empid,
      month: month,
      year: year,
    );

    result.fold(
      (failure) {
        emit(
          AttendanceState.error(
            failure.message,
            calendarEvents: currentState.calendarEvents,
            monthSummary: currentState.monthSummary,
            userName: _userName,
            profileImage: _profileImage,
          ),
        );
      },
      (summary) {
        emit(
          state.map(
            initial: (s) => s.copyWith(monthSummary: summary),
            loading: (s) => s.copyWith(monthSummary: summary),
            loaded: (s) => s.copyWith(monthSummary: summary),
            error: (s) => s.copyWith(monthSummary: summary),
          ),
        );
      },
    );
  }

  Future<void> _onTakeBreakRequested(
    Emitter<AttendanceState> emit,
  ) async {
    final empid = await _getEmpId();
    if (empid == null) return;
    emit(
      AttendanceState.loading(
        calendarEvents: state.calendarEvents,
        actionType: AttendanceActionType.takeBreak,
        monthSummary: state.monthSummary,
      ),
    );
    final result = await startBreakUseCase(empid);
    await result.fold(
      (failure) async {
        emit(
          AttendanceState.error(
            failure.message,
            calendarEvents: state.calendarEvents,
            monthSummary: state.monthSummary,
          ),
        );
        await _loadAttendanceData(
          emit,
          useCache: true,
        );
      },
      (status) async {
        // Only refresh status and durations
        await _loadAttendanceData(
          emit,
          useCache: true,
          messageOverride: status.message,
        );
      },
    );
  }

  Future<void> _onEndBreakRequested(
    Emitter<AttendanceState> emit,
  ) async {
    final empid = await _getEmpId();
    if (empid == null) return;
    emit(
      AttendanceState.loading(
        calendarEvents: state.calendarEvents,
        actionType: AttendanceActionType.endBreak,
        monthSummary: state.monthSummary,
      ),
    );
    final result = await endBreakUseCase(empid);
    await result.fold(
      (failure) async {
        emit(
          AttendanceState.error(
            failure.message,
            calendarEvents: state.calendarEvents,
            monthSummary: state.monthSummary,
          ),
        );
        await _loadAttendanceData(emit, useCache: true);
      },
      (status) async {
        await _loadAttendanceData(
          emit,
          useCache: true,
          messageOverride: status.message,
        );
      },
    );
  }

  // Remove _onWorkDurationsRequested and merge into _loadAttendanceData

  String? _userName;
  String? _profileImage;
  bool _isProfileFetched = false;

  Future<void> _fetchProfileIfNeeded() async {
    if (_isProfileFetched) return;
    final prefs = await SharedPreferences.getInstance();
    _userName = prefs.getString(StorageConstants.userFullname);
    final cookieString = prefs.getString(StorageConstants.cookies);
    if (cookieString != null) {
      try {
        final Map<String, dynamic> cookieMap = json.decode(cookieString);
        _profileImage = cookieMap['user_image'];
      } catch (_) {}
    }
    _isProfileFetched = true;
  }

  Future<void> _loadAttendanceData(
    Emitter<AttendanceState> emit, {
    bool useCache = false,
    String? messageOverride,
  }) async {
    final empid = await _getEmpId();
    if (empid == null) return;
    await _fetchProfileIfNeeded();
    final statusResult = await getCheckinStatusUseCase(empid);
    final durationsResult = await getWorkDurationsUseCase(empid);

    final Either<dynamic, List<AttendanceLogEntity>> logsResult = const Right([]);

    statusResult.fold(
      (failure) => emit(
        AttendanceState.error(
          failure.message,
          calendarEvents: state.calendarEvents,
          monthSummary: state.monthSummary,
          userName: _userName,
          profileImage: _profileImage,
        ),
      ),
      (status) {
        logsResult.fold(
          (failure) => emit(
            AttendanceState.error(
              failure.message,
              calendarEvents: state.calendarEvents,
              monthSummary: state.monthSummary,
              userName: _userName,
              profileImage: _profileImage,
            ),
          ),
          (logs) {
            _cachedLogs = logs;
            durationsResult.fold(
              (failure) => emit(
                AttendanceState.loaded(
                  status: status.copyWith(
                    message: messageOverride ?? status.message,
                  ),
                  logs: logs,
                  calendarEvents: state.calendarEvents,
                  monthSummary: state.monthSummary,
                  userName: _userName,
                  profileImage: _profileImage,
                ),
              ),
              (durations) => emit(
                AttendanceState.loaded(
                  status: status.copyWith(
                    message: messageOverride ?? status.message,
                  ),
                  logs: logs,
                  calendarEvents: state.calendarEvents,
                  monthSummary: state.monthSummary,
                  workDurations: durations,
                  userName: _userName,
                  profileImage: _profileImage,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
