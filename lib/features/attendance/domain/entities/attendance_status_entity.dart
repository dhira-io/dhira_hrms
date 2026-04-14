import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_status_entity.freezed.dart';

@freezed
abstract class AttendanceStatusEntity with _$AttendanceStatusEntity {
  const factory AttendanceStatusEntity({
    required bool success,
    required bool punchedIn,
    String? firstIn,
    String? lastOut,
  }) = _AttendanceStatusEntity;

  const AttendanceStatusEntity._();
}
