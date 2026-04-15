import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_attendance_logs_usecase.dart';
import '../../domain/usecases/get_calendar_events_usecase.dart';
import '../../domain/usecases/get_checkin_status_usecase.dart';
import '../../domain/usecases/punch_in_usecase.dart';
import '../../domain/usecases/punch_out_usecase.dart';
import 'attendance_event.dart';
import 'attendance_state.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  final PunchInUseCase punchInUseCase;
  final PunchOutUseCase punchOutUseCase;
  final GetCheckinStatusUseCase getCheckinStatusUseCase;
  final GetAttendanceLogsUseCase getAttendanceLogsUseCase;
  final GetCalendarEventsUseCase getCalendarEventsUseCase;

  AttendanceBloc({
    required this.punchInUseCase,
    required this.punchOutUseCase,
    required this.getCheckinStatusUseCase,
    required this.getAttendanceLogsUseCase,
    required this.getCalendarEventsUseCase,
  }) : super(const AttendanceState.initial()) {
    on<Started>((event, emit) => _onStarted(event.empid, emit));
    on<PunchInRequested>(
      (event, emit) => _onPunchInRequested(event.empid, emit),
    );
    on<PunchOutRequested>(
      (event, emit) => _onPunchOutRequested(event.empid, emit),
    );
    on<CheckStatusRequested>(
      (event, emit) => _loadAttendanceData(event.empid, emit),
    );
    on<CalendarEventsRequested>(
      (event, emit) => _onCalendarEventsRequested(
        event.empid,
        event.fromDate,
        event.toDate,
        emit,
      ),
    );
    on<LogRequested>((event, emit) => _loadAttendanceData(event.empid, emit));
  }

  Future<void> _onStarted(String empid, Emitter<AttendanceState> emit) async {
    emit(AttendanceState.loading(calendarEvents: state.calendarEvents));
    await _loadAttendanceData(empid, emit);
  }

  Future<void> _onPunchInRequested(
    String empid,
    Emitter<AttendanceState> emit,
  ) async {
    emit(AttendanceState.loading(calendarEvents: state.calendarEvents));
    final result = await punchInUseCase(empid);
    await result.fold(
      (failure) async {
        emit(
          AttendanceState.error(
            failure.message,
            calendarEvents: state.calendarEvents,
          ),
        );
        await _loadAttendanceData(empid, emit); // Reload last known state
      },
      (status) async {
        state.maybeMap(
          loaded: (currentState) {
            emit(currentState.copyWith(status: status));
          },
          orElse: () {
            _loadAttendanceData(empid, emit);
          },
        );
      },
    );
  }

  Future<void> _onPunchOutRequested(
    String empid,
    Emitter<AttendanceState> emit,
  ) async {
    emit(AttendanceState.loading(calendarEvents: state.calendarEvents));
    final result = await punchOutUseCase(empid);
    await result.fold(
      (failure) async {
        emit(
          AttendanceState.error(
            failure.message,
            calendarEvents: state.calendarEvents,
          ),
        );
        await _loadAttendanceData(empid, emit); // Reload last known state
      },
      (status) async {
        state.maybeMap(
          loaded: (currentState) {
            emit(currentState.copyWith(status: status));
          },
          orElse: () {
            _loadAttendanceData(empid, emit);
          },
        );
      },
    );
  }

  Future<void> _onCalendarEventsRequested(
    String empid,
    String fromDate,
    String toDate,
    Emitter<AttendanceState> emit,
  ) async {
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

  Future<void> _loadAttendanceData(
    String empid,
    Emitter<AttendanceState> emit,
  ) async {
    final statusResult = await getCheckinStatusUseCase(empid);
    final logsResult = await getAttendanceLogsUseCase(empid);

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
            emit(
              AttendanceState.loaded(
                status: status,
                logs: logs,
                calendarEvents: state.calendarEvents,
              ),
            );
          },
        );
      },
    );
  }
}
