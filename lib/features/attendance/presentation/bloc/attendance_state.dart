import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/attendance_entities.dart';

part 'attendance_state.freezed.dart';

enum AttendanceActionType { punchIn, punchOut, takeBreak, endBreak, checkStatus }

@freezed
class AttendanceState with _$AttendanceState {
  const AttendanceState._();

  @override
  Map<String, String>? get calendarEvents {
    return maybeWhen(
      initial: (events, _, __, ___) => events,
      loading: (events, _, __, ___, ____) => events,
      loaded: (status, logs, events, _, __, ___, ____) => events,
      error: (message, events, _, __, ___) => events,
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

  const factory AttendanceState.initial({
    Map<String, String>? calendarEvents,
    String? userName,
    String? profileImage,
    AttendanceMonthSummaryEntity? monthSummary,
  }) = Initial;
  const factory AttendanceState.loading({
    Map<String, String>? calendarEvents,
    AttendanceActionType? actionType,
    String? userName,
    String? profileImage,
    AttendanceMonthSummaryEntity? monthSummary,
  }) = Loading;
  const factory AttendanceState.loaded({
    required AttendanceStatusEntity status,
    required List<AttendanceLogEntity> logs,
    Map<String, String>? calendarEvents,
    AttendanceWorkDurationsEntity? workDurations,
    String? userName,
    String? profileImage,
    AttendanceMonthSummaryEntity? monthSummary,
  }) = Loaded;
  const factory AttendanceState.error(
    String message, {
    Map<String, String>? calendarEvents,
    String? userName,
    String? profileImage,
    AttendanceMonthSummaryEntity? monthSummary,
  }) = Error;
}
