import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/attendance_entities.dart';

part 'attendance_state.freezed.dart';

@freezed
class AttendanceState with _$AttendanceState {
  const factory AttendanceState.initial() = _Initial;
  const factory AttendanceState.loading() = _Loading;
  const factory AttendanceState.loaded({
    required AttendanceStatusEntity status,
    required List<AttendanceLogEntity> logs,
  }) = _Loaded;
  const factory AttendanceState.error(String message) = _Error;
}
