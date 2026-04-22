// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leave_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LeaveHistoryModel _$LeaveHistoryModelFromJson(Map<String, dynamic> json) =>
    _LeaveHistoryModel(
      name: json['name'] as String,
      employee: json['employee'] as String,
      employeeName: json['employee_name'] as String,
      leaveType: json['leave_type'] as String,
      fromDate: json['from_date'] as String,
      toDate: json['to_date'] as String,
      status: json['status'] as String,
      leaveApprover: json['leave_approver'] as String?,
      docstatus: (json['docstatus'] as num).toInt(),
      leaveApproverName: json['leave_approver_name'] as String?,
      totalLeaveDays: (json['total_leave_days'] as num).toDouble(),
    );

Map<String, dynamic> _$LeaveHistoryModelToJson(_LeaveHistoryModel instance) =>
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
    };
