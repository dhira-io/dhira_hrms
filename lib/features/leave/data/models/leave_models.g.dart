// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeaveModel _$LeaveModelFromJson(Map<String, dynamic> json) => _LeaveModel(
  name: json['name'] as String,
  employee: json['employee'] as String,
  employeeName: json['employee_name'] as String,
  leaveType: json['leave_type'] as String,
  fromDate: json['from_date'] as String,
  toDate: json['to_date'] as String,
  status: json['status'] as String,
  leaveApprover: json['leave_approver'] as String?,
  docstatus: (json['docstatus'] as num?)?.toInt(),
  leaveApproverName: json['leave_approver_name'] as String?,
  totalLeaveDays: (json['total_leave_days'] as num?)?.toDouble(),
  halfDay: (json['half_day'] as num).toInt(),
);

Map<String, dynamic> _$LeaveModelToJson(_LeaveModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'employee': instance.employee,
      'employee_name': instance.employeeName,
      'leave_type': instance.leaveType,
      'from_date': instance.fromDate,
      'to_date': instance.toDate,
      'status': instance.status,
      'leave_approver': instance.leaveApprover,
      'docstatus': instance.docstatus,
      'leave_approver_name': instance.leaveApproverName,
      'total_leave_days': instance.totalLeaveDays,
      'half_day': instance.halfDay,
    };

_LeaveTypeModel _$LeaveTypeModelFromJson(Map<String, dynamic> json) =>
    _LeaveTypeModel(
      name: json['name'] as String,
      leaveTypeName: json['leave_type_name'] as String,
    );

Map<String, dynamic> _$LeaveTypeModelToJson(_LeaveTypeModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'leave_type_name': instance.leaveTypeName,
    };

_LeaveBalanceModel _$LeaveBalanceModelFromJson(Map<String, dynamic> json) =>
    _LeaveBalanceModel(
      totalAllocated: (json['total_leaves'] as num).toInt(),
      used: (json['leaves_taken'] as num).toInt(),
      pending: (json['leaves_pending_approval'] as num).toInt(),
    );

Map<String, dynamic> _$LeaveBalanceModelToJson(_LeaveBalanceModel instance) =>
    <String, dynamic>{
      'total_leaves': instance.totalAllocated,
      'leaves_taken': instance.used,
      'leaves_pending_approval': instance.pending,
    };
