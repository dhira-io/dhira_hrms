// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'team_evaluation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TeamEvaluationModel _$TeamEvaluationModelFromJson(Map<String, dynamic> json) =>
    _TeamEvaluationModel(
      name: json['name'] as String,
      employee: json['employee'] as String,
      department: json['department'] as String,
      cycle: json['cycle'] as String,
      docstatus: (json['docstatus'] as num).toInt(),
      creation: DateTime.parse(json['creation'] as String),
      modified: DateTime.parse(json['modified'] as String),
      overallRating: (json['overall_rating'] as num).toDouble(),
      goalScore: (json['goal_score'] as num).toDouble(),
      selfAssessment: json['self_assesment'] as String,
      manager: json['manager'] as String,
    );

Map<String, dynamic> _$TeamEvaluationModelToJson(
  _TeamEvaluationModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'employee': instance.employee,
  'department': instance.department,
  'cycle': instance.cycle,
  'docstatus': instance.docstatus,
  'creation': instance.creation.toIso8601String(),
  'modified': instance.modified.toIso8601String(),
  'overall_rating': instance.overallRating,
  'goal_score': instance.goalScore,
  'self_assesment': instance.selfAssessment,
  'manager': instance.manager,
};
