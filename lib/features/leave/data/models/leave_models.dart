import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_entities.dart';

part 'leave_models.freezed.dart';
part 'leave_models.g.dart';

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
    @JsonKey(name: 'half_day') required int halfDay,
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

@freezed
abstract class LeaveBalanceModel with _$LeaveBalanceModel {
  const factory LeaveBalanceModel({
    @JsonKey(name: 'total_leaves') required int totalAllocated,
    @JsonKey(name: 'leaves_taken') required int used,
    @JsonKey(name: 'leaves_pending_approval') required int pending,
  }) = _LeaveBalanceModel;

  const LeaveBalanceModel._();

  factory LeaveBalanceModel.fromJson(Map<String, dynamic> json) => _$LeaveBalanceModelFromJson(json);

  LeaveBalanceEntity toEntity() {
    return LeaveBalanceEntity(
      totalAllocated: totalAllocated,
      used: used,
      pending: pending,
      available: totalAllocated - used - pending,
    );
  }
}
