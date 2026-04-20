import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../core/constants/storage_constants.dart';
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
  final SharedPreferences sharedPreferences;

  String get _empid => sharedPreferences.getString(StorageConstants.empId) ?? '';

  AttendanceBloc({
    required this.punchInUseCase,
    required this.punchOutUseCase,
    required this.getCheckinStatusUseCase,
    required this.getAttendanceLogsUseCase,
    required this.sharedPreferences,
  }) : super(const AttendanceState.initial()) {
    on<AttendanceEvent>((event, emit) async {
      await event.when(
        started: () => _onStarted(emit),
        punchInRequested: () => _onPunchInRequested(emit),
        punchOutRequested: () => _onPunchOutRequested(emit),
        checkStatusRequested: () => _loadAttendanceData(emit),
        logRequested: () => _loadAttendanceData(emit),
      );
    });
  }

  Future<void> _onStarted(Emitter<AttendanceState> emit) async {
    emit(const AttendanceState.loading());
    await _loadAttendanceData(emit);
  }

  Future<void> _onPunchInRequested(Emitter<AttendanceState> emit) async {
    emit(const AttendanceState.loading());
    final result = await punchInUseCase(_empid);
    await result.fold(
      (failure) async {
        emit(AttendanceState.error(failure.message));
        await _loadAttendanceData(emit); // Reload last known state
      },
      (status) async {
        await _loadAttendanceData(emit);
      },
    );
  }

  Future<void> _onPunchOutRequested(Emitter<AttendanceState> emit) async {
    emit(const AttendanceState.loading());
    final result = await punchOutUseCase(_empid);
    await result.fold(
      (failure) async {
        emit(AttendanceState.error(failure.message));
        await _loadAttendanceData(emit); // Reload last known state
      },
      (status) async {
        await _loadAttendanceData(emit);
      },
    );
  }

  Future<void> _loadAttendanceData(Emitter<AttendanceState> emit) async {
    final empid = _empid;
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
