import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dhira_hrms/features/attendance/domain/entities/attendance_status_entity.dart';

part 'attendance_status_model.freezed.dart';
part 'attendance_status_model.g.dart';

@freezed
abstract class AttendanceStatusModel with _$AttendanceStatusModel {
  const factory AttendanceStatusModel({
    @JsonKey(name: 'success') required bool success,
    @JsonKey(name: 'punched_in') required bool punchedIn,
    @JsonKey(name: 'on_break') required bool onBreak,
    @JsonKey(name: 'day_ended') required bool dayEnded,
    @JsonKey(name: 'first_in') String? firstIn,
    @JsonKey(name: 'last_out') String? lastOut,
    @JsonKey(name: 'message') String? message,
  }) = _AttendanceStatusModel;

  const AttendanceStatusModel._();

  factory AttendanceStatusModel.fromJson(Map<String, dynamic> json) =>
      _$AttendanceStatusModelFromJson(json);

  AttendanceStatusEntity toEntity() {
    return AttendanceStatusEntity(
      success: success,
      punchedIn: punchedIn,
      onBreak: onBreak,
      dayEnded: dayEnded,
      firstIn: firstIn,
      lastOut: lastOut,
      message: message,
    );
  }
}
