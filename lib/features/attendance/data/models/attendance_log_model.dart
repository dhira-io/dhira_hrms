import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/attendance_entities.dart';

part 'attendance_log_model.freezed.dart';
part 'attendance_log_model.g.dart';

@freezed
abstract class AttendanceLogModel with _$AttendanceLogModel {
  const factory AttendanceLogModel({
    required String date,
    @JsonKey(name: 'day_name') required String dayName,
    @JsonKey(name: 'month_abbr') required String monthAbbr,
    @JsonKey(name: 'day_number') required String dayNumber,
    required String status,
    @JsonKey(name: 'in_time') String? inTime,
    @JsonKey(name: 'out_time') String? outTime,
    @JsonKey(name: 'working_hours') String? workingHours,
    required String label,
  }) = _AttendanceLogModel;

  const AttendanceLogModel._();

  factory AttendanceLogModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceLogModelFromJson(json);

  factory AttendanceLogModel.fromEntity(AttendanceLogEntity entity) =>
      AttendanceLogModel(
        date: entity.date,
        dayName: entity.dayName,
        monthAbbr: entity.monthAbbr,
        dayNumber: entity.dayNumber,
        status: entity.status,
        inTime: entity.inTime,
        outTime: entity.outTime,
        workingHours: entity.workingHours,
        label: entity.label,
      );
  AttendanceLogEntity toEntity() => AttendanceLogEntity(
        date: date,
        dayName: dayName,
        monthAbbr: monthAbbr,
        dayNumber: dayNumber,
        status: status,
        inTime: inTime,
        outTime: outTime,
        workingHours: workingHours,
        label: label,
      );
}
