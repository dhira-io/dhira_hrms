// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project_assignment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProjectAssignmentModel _$ProjectAssignmentModelFromJson(
  Map<String, dynamic> json,
) => _ProjectAssignmentModel(
  name: json['row_id'] as String?,
  project: json['project'] as String,
  date: json['date'] as String?,
  expectedHours: (json['expected_time'] as num?)?.toDouble() ?? 0.0,
  spentHours: (json['actual_time'] as num?)?.toDouble() ?? 0.0,
  description: json['description'] as String?,
  hoursDetails: json['task'] as String?,
  raisedBy: json['raised_by'] as String?,
  completed: (json['completed'] as num?)?.toInt(),
  approved: (json['approved'] as num?)?.toInt(),
  applicableForCompensatoryOff:
      (json['applicable_for_compensatory_off'] as num?)?.toInt(),
  status: json['status'] as String?,
  docStatus: (json['docstatus'] as num?)?.toInt(),
);

Map<String, dynamic> _$ProjectAssignmentModelToJson(
  _ProjectAssignmentModel instance,
) => <String, dynamic>{
  'row_id': instance.name,
  'project': instance.project,
  'date': instance.date,
  'expected_time': instance.expectedHours,
  'actual_time': instance.spentHours,
  'description': instance.description,
  'task': instance.hoursDetails,
  'raised_by': instance.raisedBy,
  'completed': instance.completed,
  'approved': instance.approved,
  'applicable_for_compensatory_off': instance.applicableForCompensatoryOff,
  'status': instance.status,
  'docstatus': instance.docStatus,
};
