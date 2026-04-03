import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dhira_hrms/features/attendance/domain/entities/attendance_status_entity.dart';

part 'attendance_status_model.freezed.dart';
part 'attendance_status_model.g.dart';

@freezed
abstract class AttendanceStatusModel with _$AttendanceStatusModel {
  const factory AttendanceStatusModel({
    @JsonKey(name: 'is_punched_in') required bool isPunchedIn,
    @JsonKey(name: 'status_text') required String statusText,
  }) = _AttendanceStatusModel;

  const AttendanceStatusModel._();

  factory AttendanceStatusModel.fromJson(Map<String, dynamic> json) => _$AttendanceStatusModelFromJson(json);

  AttendanceStatusEntity toEntity() {
    return AttendanceStatusEntity(
      isPunchedIn: isPunchedIn,
      statusText: statusText,
    );
  }
}
