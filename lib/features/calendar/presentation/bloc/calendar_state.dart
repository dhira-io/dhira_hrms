import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/calendar_entity.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/team_leave_entity.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/attendance_punch_summary_entity.dart';
import 'package:dhira_hrms/features/calendar/domain/entities/leave_history_entity.dart';

part 'calendar_state.freezed.dart';

enum CalendarStatus { initial, loading, loaded, error }

@freezed
class CalendarState with _$CalendarState {
  const factory CalendarState({
    required CalendarStatus status,
    required Map<String, String> events,
    required CalendarSummaryEntity summary,
    required DateTime focusedMonth,
    DateTime? selectedDay,
    List<TeamLeaveEntity>? teamLeaves,
    AttendancePunchSummaryEntity? selectedDayPunchSummary,
    @Default(false) bool isPunchSummaryLoading,
    LeaveHistoryEntity? selectedDayLeaveDetails,
    List<LeaveHistoryEntity>? leaveHistory,
    String? errorMessage,
    String? employeeId,
  }) = _CalendarState;

  factory CalendarState.initial() => CalendarState(
        status: CalendarStatus.initial,
        events: const {},
        summary: const CalendarSummaryEntity(
          presentDays: 0.0,
          absentDays: 0.0,
          onLeaveDays: 0.0,
          holidays: 0,
          weekendDays: 0,
          totalWorkingDays: 0,
          attendancePercentage: 0.0,
          holidayDetails: [],
        ),
        focusedMonth: DateTime.now(),
      );
}
