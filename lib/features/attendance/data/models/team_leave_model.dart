import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/team_leave_entity.dart';

part 'team_leave_model.freezed.dart';
part 'team_leave_model.g.dart';

@freezed
abstract class TeamLeaveModel with _$TeamLeaveModel {
  const TeamLeaveModel._();

  const factory TeamLeaveModel({
    @JsonKey(name: 'employee_name') required String employeeName,
    @JsonKey(name: 'leave_type') required String leaveType,
    @JsonKey(name: 'from_date') required String fromDate,
    @JsonKey(name: 'to_date') required String toDate,
    required String employee,
    String? designation,
    String? image,
  }) = _TeamLeaveModel;

  factory TeamLeaveModel.fromJson(Map<String, dynamic> json) =>
      _$TeamLeaveModelFromJson(json);

  TeamLeaveEntity toEntity() {
    return TeamLeaveEntity(
      employeeName: employeeName,
      leaveType: leaveType,
      fromDate: fromDate,
      toDate: toDate,
      employee: employee,
      designation: designation,
      image: image,
    );
  }
}
