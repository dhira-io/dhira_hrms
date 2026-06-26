import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/calendar_entity.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/team_leave_entity.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/attendance_punch_summary_entity.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/leave_history_entity.dart';

part 'calendar_state.freezed.dart';

@freezed
class CalendarState with _$CalendarState {
  const factory CalendarState.initial() = CalendarInitial;
  const factory CalendarState.loading() = CalendarLoading;
  const factory CalendarState.loaded({
    required Map<String, String> events,
    required CalendarSummaryEntity summary,
    required DateTime focusedMonth,
    DateTime? selectedDay,
    List<TeamLeaveEntity>? teamLeaves,
    AttendancePunchSummaryEntity? selectedDayPunchSummary,
    @Default(false) bool isPunchSummaryLoading,
    LeaveHistoryEntity? selectedDayLeaveDetails,
    List<LeaveHistoryEntity>? leaveHistory,
  }) = CalendarLoaded;
  const factory CalendarState.error({
    required String message,
  }) = CalendarError;
}
