// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'timesheet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TimesheetModel _$TimesheetModelFromJson(
  Map<String, dynamic> json,
) => _TimesheetModel(
  name: json['name'] as String,
  employee: json['employee'] as String,
  employeeName: json['employee_name'] as String?,
  hoursTotal: (json['hours_total'] as num?)?.toDouble() ?? 0.0,
  fromDate: json['from_date'] as String?,
  toDate: json['to_date'] as String?,
  docstatus: (json['docstatus'] as num?)?.toInt() ?? 0,
  expectedHoursTotal: (json['expected_hours_total'] as num?)?.toDouble() ?? 0.0,
  remainingHours: (json['remaining_hours'] as num?)?.toDouble() ?? 0.0,
  totalSpentHours: (json['total_spent_hours'] as num?)?.toDouble() ?? 0.0,
  approver: json['approver'] as String?,
  approverName: json['approver_name'] as String?,
  department: json['organization_department'] as String?,
  projectAssignments: (json['time_logs'] as List<dynamic>?)
      ?.map((e) => ProjectAssignmentModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$TimesheetModelToJson(_TimesheetModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'employee': instance.employee,
      'employee_name': instance.employeeName,
      'hours_total': instance.hoursTotal,
      'from_date': instance.fromDate,
      'to_date': instance.toDate,
      'docstatus': instance.docstatus,
      'expected_hours_total': instance.expectedHoursTotal,
      'remaining_hours': instance.remainingHours,
      'total_spent_hours': instance.totalSpentHours,
      'approver': instance.approver,
      'approver_name': instance.approverName,
      'organization_department': instance.department,
      'time_logs': instance.projectAssignments,
    };
