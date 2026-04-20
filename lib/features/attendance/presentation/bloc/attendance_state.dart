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
      initial: (events) => events,
      loading: (events, _) => events,
      loaded: (status, logs, events, _) => events,
      error: (message, events) => events,
      orElse: () => null,
    );
  }

  const factory AttendanceState.initial({
    Map<String, String>? calendarEvents,
  }) = Initial;
  const factory AttendanceState.loading({
    Map<String, String>? calendarEvents,
    AttendanceActionType? actionType,
  }) = Loading;
  const factory AttendanceState.loaded({
    required AttendanceStatusEntity status,
    required List<AttendanceLogEntity> logs,
    Map<String, String>? calendarEvents,
    AttendanceWorkDurationsEntity? workDurations,
  }) = Loaded;
  const factory AttendanceState.error(
    String message, {
    Map<String, String>? calendarEvents,
  }) = Error;
}
