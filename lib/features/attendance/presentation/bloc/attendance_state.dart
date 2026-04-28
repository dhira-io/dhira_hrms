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
class AttendanceState with _$AttendanceState {
  const AttendanceState._();

  @override
  Map<String, String>? get calendarEvents => mapOrNull(
        initial: (s) => s.calendarEvents,
        loading: (s) => s.calendarEvents,
        loaded: (s) => s.calendarEvents,
        error: (s) => s.calendarEvents,
      );

  @override
  String? get userName => mapOrNull(
        initial: (s) => s.userName,
        loading: (s) => s.userName,
        loaded: (s) => s.userName,
        error: (s) => s.userName,
      );

  @override
  String? get profileImage => mapOrNull(
        initial: (s) => s.profileImage,
        loading: (s) => s.profileImage,
        loaded: (s) => s.profileImage,
        error: (s) => s.profileImage,
      );

  @override
  AttendanceMonthSummaryEntity? get monthSummary => mapOrNull(
        initial: (s) => s.monthSummary,
        loading: (s) => s.monthSummary,
        loaded: (s) => s.monthSummary,
        error: (s) => s.monthSummary,
      );

  @override
  LeaveDetailsEntity? get leaveDetails => mapOrNull(
        initial: (s) => s.leaveDetails,
        loading: (s) => s.leaveDetails,
        loaded: (s) => s.leaveDetails,
        error: (s) => s.leaveDetails,
      );

  @override
  List<LeaveHistoryEntity>? get leaveHistory => mapOrNull(
        initial: (s) => s.leaveHistory,
        loading: (s) => s.leaveHistory,
        loaded: (s) => s.leaveHistory,
        error: (s) => s.leaveHistory,
      );

  @override
  List<TeamLeaveEntity>? get teamLeaves => mapOrNull(
        initial: (s) => s.teamLeaves,
        loading: (s) => s.teamLeaves,
        loaded: (s) => s.teamLeaves,
        error: (s) => s.teamLeaves,
      );

  @override
  HolidayListLeavePolicyEntity? get holidayListLeavePolicy => mapOrNull(
        initial: (s) => s.holidayListLeavePolicy,
        loading: (s) => s.holidayListLeavePolicy,
        loaded: (s) => s.holidayListLeavePolicy,
        error: (s) => s.holidayListLeavePolicy,
      );

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
