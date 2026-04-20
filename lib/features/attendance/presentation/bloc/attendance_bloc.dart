import 'package:dartz/dartz.dart';
import 'package:dhira_hrms/features/attendance/domain/entities/attendance_log_entity.dart';
import 'package:dhira_hrms/features/attendance/domain/usecases/end_break_usecase.dart';
import 'package:dhira_hrms/features/attendance/domain/usecases/get_work_durations_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_attendance_logs_usecase.dart';
import '../../domain/usecases/get_calendar_events_usecase.dart';
import '../../domain/usecases/get_checkin_status_usecase.dart';
import '../../domain/usecases/punch_in_usecase.dart';
import '../../domain/usecases/punch_out_usecase.dart';
import '../../domain/usecases/start_break_usecase.dart';
import 'dart:async';
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
      ),
    );
    final result = await punchInUseCase(empid);
    await result.fold(
      (failure) async {
        emit(
          AttendanceState.error(
            failure.message,
            calendarEvents: state.calendarEvents,
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
      ),
    );
    final result = await punchOutUseCase(empid);
    await result.fold(
      (failure) async {
        emit(
          AttendanceState.error(
            failure.message,
            calendarEvents: state.calendarEvents,
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

  Future<void> _onTakeBreakRequested(
    Emitter<AttendanceState> emit,
  ) async {
    final empid = await _getEmpId();
    if (empid == null) return;
    emit(
      AttendanceState.loading(
        calendarEvents: state.calendarEvents,
        actionType: AttendanceActionType.takeBreak,
      ),
    );
    final result = await startBreakUseCase(empid);
    await result.fold(
      (failure) async {
        emit(
          AttendanceState.error(
            failure.message,
            calendarEvents: state.calendarEvents,
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
      ),
    );
    final result = await endBreakUseCase(empid);
    await result.fold(
      (failure) async {
        emit(
          AttendanceState.error(
            failure.message,
            calendarEvents: state.calendarEvents,
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

  Future<void> _loadAttendanceData(
    Emitter<AttendanceState> emit, {
    bool useCache = false,
    String? messageOverride,
  }) async {
    final empid = await _getEmpId();
    if (empid == null) return;
    final statusResult = await getCheckinStatusUseCase(empid);
    final durationsResult = await getWorkDurationsUseCase(empid);

    final Either<dynamic, List<AttendanceLogEntity>> logsResult;
    if (useCache && _cachedLogs.isNotEmpty) {
      logsResult = Right(_cachedLogs);
    } else {
      logsResult = await getAttendanceLogsUseCase(empid);
    }

    statusResult.fold(
      (failure) => emit(
        AttendanceState.error(
          failure.message,
          calendarEvents: state.calendarEvents,
        ),
      ),
      (status) {
        logsResult.fold(
          (failure) => emit(
            AttendanceState.error(
              failure.message,
              calendarEvents: state.calendarEvents,
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
                ),
              ),
              (durations) => emit(
                AttendanceState.loaded(
                  status: status.copyWith(
                    message: messageOverride ?? status.message,
                  ),
                  logs: logs,
                  calendarEvents: state.calendarEvents,
                  workDurations: durations,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
