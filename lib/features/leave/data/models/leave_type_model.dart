import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_type_entity.dart';

part 'leave_type_model.freezed.dart';
part 'leave_type_model.g.dart';

@freezed
abstract class LeaveTypeModel with _$LeaveTypeModel {
  const factory LeaveTypeModel({
    required String name,
    @JsonKey(name: 'leave_type_name') required String leaveTypeName,
  }) = _LeaveTypeModel;

  const LeaveTypeModel._();

  factory LeaveTypeModel.fromJson(Map<String, dynamic> json) => _$LeaveTypeModelFromJson(json);

  LeaveTypeEntity toEntity() {
    return LeaveTypeEntity(
      name: name,
      leaveTypeName: leaveTypeName,
    );
  }
}
