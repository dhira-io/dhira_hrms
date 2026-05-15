import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_work_durations_entity.freezed.dart';

@freezed
abstract class AttendanceWorkDurationsEntity with _$AttendanceWorkDurationsEntity {
  const factory AttendanceWorkDurationsEntity({
    required double todayHours,
    required String todayLabel,
    required double weekHours,
    required String weekLabel,
    required double monthHours,
    required String monthLabel,
    required bool onBreak,
    required bool punchedIn,
  }) = _AttendanceWorkDurationsEntity;

  const AttendanceWorkDurationsEntity._();
}
