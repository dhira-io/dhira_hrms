import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_status_entity.freezed.dart';

@freezed
abstract class AttendanceStatusEntity with _$AttendanceStatusEntity {
  const factory AttendanceStatusEntity({
    required bool success,
    required bool punchedIn,
    required bool onBreak,
    required bool dayEnded,
    String? firstIn,
    String? lastOut,
    String? message,
  }) = _AttendanceStatusEntity;

  const AttendanceStatusEntity._();
}
