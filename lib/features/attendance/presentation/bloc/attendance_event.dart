import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_event.freezed.dart';

@freezed
abstract class AttendanceEvent with _$AttendanceEvent {
  const AttendanceEvent._();

  const factory AttendanceEvent.started(String empid) = Started;
  const factory AttendanceEvent.punchInRequested(String empid) =
      PunchInRequested;
  const factory AttendanceEvent.punchOutRequested(String empid) =
      PunchOutRequested;
  const factory AttendanceEvent.checkStatusRequested(String empid) =
      CheckStatusRequested;
  const factory AttendanceEvent.calendarEventsRequested({
    required String empid,
    required String fromDate,
    required String toDate,
  }) = CalendarEventsRequested;
  const factory AttendanceEvent.logRequested(String empid) = LogRequested;
}
