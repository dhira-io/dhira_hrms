import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_attendance_logs_usecase.dart';
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

  AttendanceBloc({
    required this.punchInUseCase,
    required this.punchOutUseCase,
    required this.getCheckinStatusUseCase,
    required this.getAttendanceLogsUseCase,
  }) : super(const AttendanceState.initial()) {
    on<AttendanceEvent>((event, emit) async {
      await event.when(
        started: (empid) => _onStarted(empid, emit),
        punchInRequested: (empid) => _onPunchInRequested(empid, emit),
        punchOutRequested: (empid) => _onPunchOutRequested(empid, emit),
        checkStatusRequested: (empid) => _loadAttendanceData(empid, emit),
        logRequested: (empid) => _loadAttendanceData(empid, emit),
      );
    });
  }

  Future<void> _onStarted(String empid, Emitter<AttendanceState> emit) async {
    emit(const AttendanceState.loading());
    await _loadAttendanceData(empid, emit);
  }

  Future<void> _onPunchInRequested(String empid, Emitter<AttendanceState> emit) async {
    emit(const AttendanceState.loading());
    final result = await punchInUseCase(empid);
    await result.fold(
      (failure) async {
        emit(AttendanceState.error(failure.message));
        await _loadAttendanceData(empid, emit); // Reload last known state
      },
      (status) async {
        await _loadAttendanceData(empid, emit);
      },
    );
  }

  Future<void> _onPunchOutRequested(String empid, Emitter<AttendanceState> emit) async {
    emit(const AttendanceState.loading());
    final result = await punchOutUseCase(empid);
    await result.fold(
      (failure) async {
        emit(AttendanceState.error(failure.message));
        await _loadAttendanceData(empid, emit); // Reload last known state
      },
      (status) async {
        await _loadAttendanceData(empid, emit);
      },
    );
  }

  Future<void> _loadAttendanceData(String empid, Emitter<AttendanceState> emit) async {
    final statusResult = await getCheckinStatusUseCase(empid);
    final logsResult = await getAttendanceLogsUseCase(empid);

    statusResult.fold(
      (failure) => emit(AttendanceState.error(failure.message)),
      (status) {
        logsResult.fold(
          (failure) => emit(AttendanceState.error(failure.message)),
          (logs) => emit(AttendanceState.loaded(status: status, logs: logs)),
        );
      },
    );
  }
}
