import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_event.freezed.dart';

@freezed
abstract class AttendanceEvent with _$AttendanceEvent {
  const AttendanceEvent._();

  const factory AttendanceEvent.started() = _Started;
  const factory AttendanceEvent.punchInRequested() = _PunchInRequested;
  const factory AttendanceEvent.punchOutRequested() = _PunchOutRequested;
  const factory AttendanceEvent.checkStatusRequested() = _CheckStatusRequested;
  const factory AttendanceEvent.logRequested() = _LogRequested;
}
