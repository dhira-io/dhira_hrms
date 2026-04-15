// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_assignment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProjectAssignmentModel _$ProjectAssignmentModelFromJson(
  Map<String, dynamic> json,
) => _ProjectAssignmentModel(
  name: json['name'] as String?,
  project: json['project'] as String,
  date: json['date'] as String?,
  taskName: json['task_name'] as String?,
  expectedHours: (json['expected_hours'] as num?)?.toDouble() ?? 0.0,
  spentHours: (json['spent_hours'] as num?)?.toDouble() ?? 0.0,
  description: json['description'] as String?,
);

Map<String, dynamic> _$ProjectAssignmentModelToJson(
  _ProjectAssignmentModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'project': instance.project,
  'date': instance.date,
  'task_name': instance.taskName,
  'expected_hours': instance.expectedHours,
  'spent_hours': instance.spentHours,
  'description': instance.description,
};
