import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_log_entity.freezed.dart';

@freezed
abstract class AttendanceLogEntity with _$AttendanceLogEntity {
  const factory AttendanceLogEntity({
    required String date,
    required String dayName,
    required String inTime,
    String? outTime,
    double? workingHours,
    required String status,
  }) = _AttendanceLogEntity;

  const AttendanceLogEntity._();
}
