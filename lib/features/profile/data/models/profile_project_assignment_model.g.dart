// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_project_assignment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileProjectAssignmentModel _$ProfileProjectAssignmentModelFromJson(
  Map<String, dynamic> json,
) => _ProfileProjectAssignmentModel(
  projectName: json['project_name'] as String,
  projectLead: json['project_lead'] as String?,
  startDate: json['start_date'] as String?,
  endDate: json['end_date'] as String?,
);

Map<String, dynamic> _$ProfileProjectAssignmentModelToJson(
  _ProfileProjectAssignmentModel instance,
) => <String, dynamic>{
  'project_name': instance.projectName,
  'project_lead': instance.projectLead,
  'start_date': instance.startDate,
  'end_date': instance.endDate,
};
