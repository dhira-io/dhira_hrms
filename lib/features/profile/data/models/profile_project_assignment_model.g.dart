// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_project_assignment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileProjectAssignmentModel _$ProfileProjectAssignmentModelFromJson(
  Map<String, dynamic> json,
) => _ProfileProjectAssignmentModel(
  projectName: json['project_name'] as String,
  projectLead: json['report_to_name'] as String?,
  startDate: json['creation'] as String?,
  endDate: json['modified'] as String?,
);

Map<String, dynamic> _$ProfileProjectAssignmentModelToJson(
  _ProfileProjectAssignmentModel instance,
) => <String, dynamic>{
  'project_name': instance.projectName,
  'report_to_name': instance.projectLead,
  'creation': instance.startDate,
  'modified': instance.endDate,
};
