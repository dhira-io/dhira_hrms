import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/attendance_entities.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_details_entity.dart';
import 'package:dhira_hrms/features/attendance/domain/entities/leave_history_entity.dart';

part 'attendance_state.freezed.dart';

enum AttendanceActionType {
  punchIn,
  punchOut,
  takeBreak,
  endBreak,
  checkStatus,
}

@freezed
class AttendanceState with _$AttendanceState {
  const AttendanceState._();

  @override
  Map<String, String>? get calendarEvents {
    return maybeWhen(
      initial: (events, _, __, ___, _, _) => events,
      loading: (events, _, __, ___, ____, _, _) => events,
      loaded: (status, logs, events, _, __, ___, ____, _, _) => events,
      error: (message, events, _, __, ___, _, _) => events,
      orElse: () => null,
    );
  }

  String? get userName => mapOrNull(
    initial: (s) => s.userName,
    loading: (s) => s.userName,
    loaded: (s) => s.userName,
    error: (s) => s.userName,
  );

  String? get profileImage => mapOrNull(
    initial: (s) => s.profileImage,
    loading: (s) => s.profileImage,
    loaded: (s) => s.profileImage,
    error: (s) => s.profileImage,
  );

  AttendanceMonthSummaryEntity? get monthSummary => mapOrNull(
    initial: (s) => s.monthSummary,
    loading: (s) => s.monthSummary,
    loaded: (s) => s.monthSummary,
    error: (s) => s.monthSummary,
  );

  LeaveDetailsEntity? get leaveDetails => mapOrNull(
    initial: (s) => s.leaveDetails,
    loading: (s) => s.leaveDetails,
    loaded: (s) => s.leaveDetails,
    error: (s) => s.leaveDetails,
  );

  List<LeaveHistoryEntity>? get leaveHistory => mapOrNull(
    initial: (s) => s.leaveHistory,
    loading: (s) => s.leaveHistory,
    loaded: (s) => s.leaveHistory,
    error: (s) => s.leaveHistory,
  );

  const factory AttendanceState.initial({
    Map<String, String>? calendarEvents,
    String? userName,
    String? profileImage,
    AttendanceMonthSummaryEntity? monthSummary,
    LeaveDetailsEntity? leaveDetails,
    List<LeaveHistoryEntity>? leaveHistory,
  }) = Initial;
  const factory AttendanceState.loading({
    Map<String, String>? calendarEvents,
    AttendanceActionType? actionType,
    String? userName,
    String? profileImage,
    AttendanceMonthSummaryEntity? monthSummary,
    LeaveDetailsEntity? leaveDetails,
    List<LeaveHistoryEntity>? leaveHistory,
  }) = Loading;
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
  }) = Loaded;
  const factory AttendanceState.error(
    String message, {
    Map<String, String>? calendarEvents,
    String? userName,
    String? profileImage,
    AttendanceMonthSummaryEntity? monthSummary,
    LeaveDetailsEntity? leaveDetails,
    List<LeaveHistoryEntity>? leaveHistory,
  }) = Error;
}
