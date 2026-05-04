import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/attendance_entities.dart';

part 'attendance_state.freezed.dart';

enum AttendanceActionType {
  punchIn,
  punchOut,
  takeBreak,
  endBreak,
  checkStatus,
  fetchPolicy,
}

@freezed
abstract class AttendanceState with _$AttendanceState {
  const AttendanceState._();

  // Freezed automatically provides getters for parameters that are common to all constructors.
  // We only need to define the factory constructors.

  const factory AttendanceState.initial({
    Map<String, String>? calendarEvents,
    String? userName,
    String? profileImage,
    AttendanceMonthSummaryEntity? monthSummary,
    LeaveDetailsEntity? leaveDetails,
    List<LeaveHistoryEntity>? leaveHistory,
    List<TeamLeaveEntity>? teamLeaves,
    HolidayListLeavePolicyEntity? holidayListLeavePolicy,
  }) = _Initial;
  const factory AttendanceState.loading({
    Map<String, String>? calendarEvents,
    AttendanceActionType? actionType,
    String? userName,
    String? profileImage,
    AttendanceMonthSummaryEntity? monthSummary,
    LeaveDetailsEntity? leaveDetails,
    List<LeaveHistoryEntity>? leaveHistory,
    List<TeamLeaveEntity>? teamLeaves,
    HolidayListLeavePolicyEntity? holidayListLeavePolicy,
  }) = _Loading;
  const factory AttendanceState.loaded({
    required AttendanceStatusEntity status,
    required List<AttendanceLogEntity> logs,
    Map<String, String>? calendarEvents,
    AttendanceWorkDurationsEntity? workDurations,
    String? userName,
    String? profileImage,
    AttendanceMonthSummaryEntity? monthSummary,
    LeaveDetailsEntity? leaveDetails,
    List<LeaveHistoryEntity>? leaveHistory,
    List<TeamLeaveEntity>? teamLeaves,
    HolidayListLeavePolicyEntity? holidayListLeavePolicy,
  }) = _Loaded;
  const factory AttendanceState.error(
    String message, {
    Map<String, String>? calendarEvents,
    String? userName,
    String? profileImage,
    AttendanceMonthSummaryEntity? monthSummary,
    LeaveDetailsEntity? leaveDetails,
    List<LeaveHistoryEntity>? leaveHistory,
    List<TeamLeaveEntity>? teamLeaves,
    HolidayListLeavePolicyEntity? holidayListLeavePolicy,
  }) = _AttendanceError;
}
