import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_event.freezed.dart';

@freezed
abstract class AttendanceEvent with _$AttendanceEvent {
  const AttendanceEvent._();

  const factory AttendanceEvent.started() = Started;
  const factory AttendanceEvent.punchInRequested() =
      PunchInRequested;
  const factory AttendanceEvent.punchOutRequested() =
      PunchOutRequested;
  const factory AttendanceEvent.checkStatusRequested() =
      CheckStatusRequested;
  const factory AttendanceEvent.calendarEventsRequested({
    required String fromDate,
    required String toDate,
  }) = CalendarEventsRequested;
  const factory AttendanceEvent.logRequested() = LogRequested;
  const factory AttendanceEvent.takeBreakRequested() =
      TakeBreakRequested;
  const factory AttendanceEvent.endBreakRequested() =
      EndBreakRequested;
  const factory AttendanceEvent.workDurationsRequested() =
      WorkDurationsRequested;
  const factory AttendanceEvent.monthSummaryRequested({
    required int month,
    required int year,
  }) = MonthSummaryRequested;
  const factory AttendanceEvent.leaveDetailsRequested({
    required String date,
  }) = LeaveDetailsRequested;
  const factory AttendanceEvent.leaveHistoryRequested() = LeaveHistoryRequested;
}
