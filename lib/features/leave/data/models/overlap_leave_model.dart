import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/overlap_leave_entity.dart';

part 'overlap_leave_model.freezed.dart';
part 'overlap_leave_model.g.dart';

@freezed
abstract class OverlapLeaveModel with _$OverlapLeaveModel {
  const factory OverlapLeaveModel({
    required String id,
    required OverlapEmployeeModel employee,
    @JsonKey(name: 'shared_projects') List<String>? sharedProjects,
    @JsonKey(name: 'leave_type') required String leaveType,
    @JsonKey(name: 'from_date') required String fromDate,
    @JsonKey(name: 'to_date') required String toDate,
    @JsonKey(name: 'days') required double days,
    required String status,
    String? description,
    String? posting_date,
    String? modified,
  }) = _OverlapLeaveModel;

  const OverlapLeaveModel._();

  factory OverlapLeaveModel.fromJson(Map<String, dynamic> json) => _$OverlapLeaveModelFromJson(json);

  OverlapLeaveEntity toEntity() {
    return OverlapLeaveEntity(
      id: id,
      employeeId: employee.id,
      employeeName: employee.name,
      designation: employee.designation,
      image: employee.image,
      department: employee.department,
      sharedProjects: sharedProjects,
      leaveType: leaveType,
      fromDate: fromDate,
      toDate: toDate,
      days: days,
      status: status,
      description: description ?? "",
    );
  }
}

@freezed
abstract class OverlapEmployeeModel with _$OverlapEmployeeModel {
  const factory OverlapEmployeeModel({
    required String id,
    required String name,
    required String designation,
    String? image,
    String? department,
  }) = _OverlapEmployeeModel;

  factory OverlapEmployeeModel.fromJson(Map<String, dynamic> json) => _$OverlapEmployeeModelFromJson(json);
}
