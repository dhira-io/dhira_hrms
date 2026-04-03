// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timesheet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TimesheetModel _$TimesheetModelFromJson(Map<String, dynamic> json) =>
    _TimesheetModel(
      name: json['name'] as String,
      employee: json['employee'] as String,
      employeeName: json['employee_name'] as String,
      hoursTotal: (json['total_hours'] as num).toDouble(),
      fromDate: json['start_date'] as String,
      toDate: json['end_date'] as String,
      docstatus: (json['docstatus'] as num).toInt(),
      totalSpentHours: (json['total_billable_hours'] as num).toDouble(),
      approver: json['approver'] as String,
      approverName: json['leave_approver_name'] as String,
      projectAssignments: (json['time_logs'] as List<dynamic>?)
          ?.map(
            (e) => ProjectAssignmentModel.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    );

Map<String, dynamic> _$TimesheetModelToJson(_TimesheetModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'employee': instance.employee,
      'employee_name': instance.employeeName,
      'total_hours': instance.hoursTotal,
      'start_date': instance.fromDate,
      'end_date': instance.toDate,
      'docstatus': instance.docstatus,
      'total_billable_hours': instance.totalSpentHours,
      'approver': instance.approver,
      'leave_approver_name': instance.approverName,
      'time_logs': instance.projectAssignments,
    };
