// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_assignment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProjectAssignmentModel _$ProjectAssignmentModelFromJson(
  Map<String, dynamic> json,
) => _ProjectAssignmentModel(
  name: json['name'] as String?,
  parent: json['parent'] as String?,
  project: json['project'] as String,
  date: json['date'] as String?,
  expectedHours: (json['expected_hours'] as num?)?.toDouble() ?? 0.0,
  spentHours: (json['spent_hours'] as num?)?.toDouble() ?? 0.0,
  description: json['description'] as String?,
  hoursDetails: json['hours_details'] as String?,
  raisedBy: json['raised_by'] as String?,
  completed: (json['completed'] as num?)?.toInt(),
  approved: (json['approved'] as num?)?.toInt(),
  applicableForCompensatoryOff:
      (json['applicable_for_compensatory_off'] as num?)?.toInt(),
  status: json['status'] as String?,
  taskData: json['task_data'] as String?,
);

Map<String, dynamic> _$ProjectAssignmentModelToJson(
  _ProjectAssignmentModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'parent': instance.parent,
  'project': instance.project,
  'date': instance.date,
  'expected_hours': instance.expectedHours,
  'spent_hours': instance.spentHours,
  'description': instance.description,
  'hours_details': instance.hoursDetails,
  'raised_by': instance.raisedBy,
  'completed': instance.completed,
  'approved': instance.approved,
  'applicable_for_compensatory_off': instance.applicableForCompensatoryOff,
  'status': instance.status,
  'task_data': instance.taskData,
};
