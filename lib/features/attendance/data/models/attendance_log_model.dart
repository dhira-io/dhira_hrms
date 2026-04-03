import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dhira_hrms/features/attendance/domain/entities/attendance_log_entity.dart';

part 'attendance_log_model.freezed.dart';
part 'attendance_log_model.g.dart';

@freezed
abstract class AttendanceLogModel with _$AttendanceLogModel {
  const factory AttendanceLogModel({
    @JsonKey(name: 'attendance_date') required String date,
    @JsonKey(name: 'day_name') required String dayName,
    @JsonKey(name: 'in_time') required String inTime,
    @JsonKey(name: 'out_time') String? outTime,
    @JsonKey(name: 'working_hours') double? workingHours,
    required String status,
  }) = _AttendanceLogModel;

  const AttendanceLogModel._();

  factory AttendanceLogModel.fromJson(Map<String, dynamic> json) => _$AttendanceLogModelFromJson(json);

  AttendanceLogEntity toEntity() {
    return AttendanceLogEntity(
      date: date,
      dayName: dayName,
      inTime: inTime,
      outTime: outTime,
      workingHours: workingHours,
      status: status,
    );
  }
}
