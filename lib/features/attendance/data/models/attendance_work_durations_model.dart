import 'package:dhira_hrms/features/attendance/domain/entities/attendance_work_durations_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_work_durations_model.freezed.dart';
part 'attendance_work_durations_model.g.dart';

@freezed
abstract class AttendanceWorkDurationsModel
    with _$AttendanceWorkDurationsModel {
  const factory AttendanceWorkDurationsModel({
    @JsonKey(name: 'today') required WorkDurationInfo today,
    @JsonKey(name: 'week') required WorkDurationInfo week,
    @JsonKey(name: 'month') required WorkDurationInfo month,
    @JsonKey(name: 'on_break') required bool onBreak,
    @JsonKey(name: 'punched_in') required bool punchedIn,
  }) = _AttendanceWorkDurationsModel;

  const AttendanceWorkDurationsModel._();

  factory AttendanceWorkDurationsModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceWorkDurationsModelFromJson(json);

  AttendanceWorkDurationsEntity toEntity() {
    return AttendanceWorkDurationsEntity(
      todayHours: today.hours,
      todayLabel: today.label,
      weekHours: week.hours,
      weekLabel: week.label,
      monthHours: month.hours,
      monthLabel: month.label,
      onBreak: onBreak,
      punchedIn: punchedIn,
    );
  }
}

@freezed
abstract class WorkDurationInfo with _$WorkDurationInfo {
  const factory WorkDurationInfo({
    required double hours,
    required String label,
  }) = _WorkDurationInfo;

  factory WorkDurationInfo.fromJson(Map<String, dynamic> json) =>
      _$WorkDurationInfoFromJson(json);
}
