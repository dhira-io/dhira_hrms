// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'self_assessment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SelfAssessmentModel _$SelfAssessmentModelFromJson(
  Map<String, dynamic> json,
) => _SelfAssessmentModel(
  name: json['name'] as String,
  employee: json['employee'] as String,
  employeeName: json['employee_name'] as String? ?? '',
  cycle: json['cycle'] as String,
  goal: json['goal'] as String? ?? '',
  submissionDate: json['submission_date'] == null
      ? null
      : DateTime.parse(json['submission_date'] as String),
  modified: DateTime.parse(json['modified'] as String),
  goalReviews:
      (_readGoalsList(json, 'goal_ratings') as List<dynamic>?)
          ?.map((e) => GoalReviewModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  timeline:
      (json['timeline'] as List<dynamic>?)
          ?.map((e) => TimelineStageModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  competencyReviews:
      (_readCompetenciesList(json, 'competency_ratings') as List<dynamic>?)
          ?.map(
            (e) => CompetencyReviewModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
  attachments:
      (json['attachments'] as List<dynamic>?)
          ?.map((e) => FileAttachmentModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$SelfAssessmentModelToJson(
  _SelfAssessmentModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'employee': instance.employee,
  'employee_name': instance.employeeName,
  'cycle': instance.cycle,
  'goal': instance.goal,
  'submission_date': instance.submissionDate?.toIso8601String(),
  'modified': instance.modified.toIso8601String(),
  'goal_ratings': instance.goalReviews,
  'timeline': instance.timeline,
  'competency_ratings': instance.competencyReviews,
  'attachments': instance.attachments,
};

_FileAttachmentModel _$FileAttachmentModelFromJson(Map<String, dynamic> json) =>
    _FileAttachmentModel(
      name: json['name'] as String,
      fileName: json['file_name'] as String,
      fileUrl: json['file_url'] as String,
    );

Map<String, dynamic> _$FileAttachmentModelToJson(
  _FileAttachmentModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'file_name': instance.fileName,
  'file_url': instance.fileUrl,
};

_GoalReviewModel _$GoalReviewModelFromJson(Map<String, dynamic> json) =>
    _GoalReviewModel(
      name: json['name'] as String,
      goal: _readGoalName(json, 'goal') as String? ?? '',
      kras: json['kras'] as String? ?? '',
      weightage: (json['weightage'] as num?)?.toDouble() ?? 0.0,
      target: (json['target'] as num?)?.toDouble() ?? 0.0,
      progress: (json['progress'] as num?)?.toDouble() ?? 0.0,
      selfRating: json['self_rating'] as String? ?? '',
      selfComment: json['self_comment'] as String? ?? '',
      managerRating: json['manager_rating'] as String? ?? '',
      managerPercentage:
          (json['manager_percentage'] as num?)?.toDouble() ?? 0.0,
      managerComment: json['manager_comment'] as String? ?? '',
      employeeComment: json['employee_comment'] as String? ?? '',
      achieved: (json['achieved'] as num?)?.toDouble() ?? 0.0,
      weightedScore: (json['weighted_score'] as num?)?.toDouble() ?? 0.0,
      modified: DateTime.parse(json['modified'] as String),
    );

Map<String, dynamic> _$GoalReviewModelToJson(_GoalReviewModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'goal': instance.goal,
      'kras': instance.kras,
      'weightage': instance.weightage,
      'target': instance.target,
      'progress': instance.progress,
      'self_rating': instance.selfRating,
      'self_comment': instance.selfComment,
      'manager_rating': instance.managerRating,
      'manager_percentage': instance.managerPercentage,
      'manager_comment': instance.managerComment,
      'employee_comment': instance.employeeComment,
      'achieved': instance.achieved,
      'weighted_score': instance.weightedScore,
      'modified': instance.modified.toIso8601String(),
    };

_TimelineStageModel _$TimelineStageModelFromJson(Map<String, dynamic> json) =>
    _TimelineStageModel(
      name: json['name'] as String,
      stageName: json['stage_name'] as String? ?? '',
      date: DateTime.parse(json['date'] as String),
      status: json['stauts'] as String? ?? '',
    );

Map<String, dynamic> _$TimelineStageModelToJson(_TimelineStageModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'stage_name': instance.stageName,
      'date': instance.date.toIso8601String(),
      'stauts': instance.status,
    };

_CompetencyReviewModel _$CompetencyReviewModelFromJson(
  Map<String, dynamic> json,
) => _CompetencyReviewModel(
  name: json['name'] as String,
  competency: json['competency'] as String,
);

Map<String, dynamic> _$CompetencyReviewModelToJson(
  _CompetencyReviewModel instance,
) => <String, dynamic>{
  'name': instance.name,
  'competency': instance.competency,
};
