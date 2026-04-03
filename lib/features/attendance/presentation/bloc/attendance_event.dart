import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_event.freezed.dart';

@freezed
abstract class AttendanceEvent with _$AttendanceEvent {
  const AttendanceEvent._();

  const factory AttendanceEvent.started(String empid) = _Started;
  const factory AttendanceEvent.punchInRequested(String empid) = _PunchInRequested;
  const factory AttendanceEvent.punchOutRequested(String empid) = _PunchOutRequested;
  const factory AttendanceEvent.checkStatusRequested(String empid) = _CheckStatusRequested;
  const factory AttendanceEvent.logRequested(String empid) = _LogRequested;
}
