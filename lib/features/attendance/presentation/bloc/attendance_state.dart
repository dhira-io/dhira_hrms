import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/attendance_entities.dart';

part 'attendance_state.freezed.dart';

@freezed
class AttendanceState with _$AttendanceState {
  const AttendanceState._();

  Map<String, String>? get calendarEvents {
    return maybeWhen(
      initial: (events) => events,
      loading: (events) => events,
      loaded: (status, logs, events) => events,
      error: (message, events) => events,
      orElse: () => null,
    );
  }
  const factory AttendanceState.initial({
    Map<String, String>? calendarEvents,
  }) = Initial;
  const factory AttendanceState.loading({
    Map<String, String>? calendarEvents,
  }) = Loading;
  const factory AttendanceState.loaded({
    required AttendanceStatusEntity status,
    required List<AttendanceLogEntity> logs,
    Map<String, String>? calendarEvents,
  }) = Loaded;
  const factory AttendanceState.error(
    String message, {
    Map<String, String>? calendarEvents,
  }) = Error;
}
