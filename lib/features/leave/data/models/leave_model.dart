import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_entity.dart';

part 'leave_model.freezed.dart';
part 'leave_model.g.dart';

@freezed
abstract class LeaveModel with _$LeaveModel {
  const factory LeaveModel({
    required String name,
    required String employee,
    @JsonKey(name: 'employee_name') required String employeeName,
    @JsonKey(name: 'leave_type') required String leaveType,
    @JsonKey(name: 'from_date') required String fromDate,
    @JsonKey(name: 'to_date') required String toDate,
    required String status,
    @JsonKey(name: 'leave_approver') String? leaveApprover,
    int? docstatus,
    @JsonKey(name: 'leave_approver_name') String? leaveApproverName,
    @JsonKey(name: 'total_leave_days') double? totalLeaveDays,
    @JsonKey(name: 'half_day', defaultValue: 0) @Default(0) int halfDay,
  }) = _LeaveModel;

  const LeaveModel._();

  factory LeaveModel.fromJson(Map<String, dynamic> json) => _$LeaveModelFromJson(json);

  LeaveEntity toEntity() {
    return LeaveEntity(
      name: name,
      employee: employee,
      employeeName: employeeName,
      leaveType: leaveType,
      fromDate: fromDate,
      toDate: toDate,
      status: status,
      leaveApprover: leaveApprover,
      docstatus: docstatus,
      leaveApproverName: leaveApproverName,
      totalLeaveDays: totalLeaveDays,
    );
  }
}
