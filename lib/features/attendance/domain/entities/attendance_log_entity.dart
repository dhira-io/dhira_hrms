import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_log_entity.freezed.dart';

@freezed
abstract class AttendanceLogEntity with _$AttendanceLogEntity {
  const factory AttendanceLogEntity({
    required String date,
    required String dayName,
    required String monthAbbr,
    required String dayNumber,
    required String status,
    String? inTime,
    String? outTime,
    String? workingHours,
    required String label,
  }) = _AttendanceLogEntity;

  const AttendanceLogEntity._();
}
