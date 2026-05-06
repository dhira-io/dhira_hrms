import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/self_assessment_entity.dart';

part 'self_assessment_model.freezed.dart';
part 'self_assessment_model.g.dart';

@freezed
abstract class SelfAssessmentModel with _$SelfAssessmentModel {
  const factory SelfAssessmentModel({
    required String name,
    required String employee,
    @JsonKey(name: 'employee_name') @Default('') String employeeName,
    required String cycle,
    @Default('') String goal,
    @JsonKey(name: 'submission_date') DateTime? submissionDate,
    required DateTime modified,
    @JsonKey(
      name: 'goal_ratings',
      readValue: _readGoalsList,
    )
    @Default([])
    List<GoalReviewModel> goalReviews,
    @Default([]) List<TimelineStageModel> timeline,
    @JsonKey(
      name: 'competency_ratings',
      readValue: _readCompetenciesList,
    )
    @Default([])
    List<CompetencyReviewModel> competencyReviews,
    @Default([]) List<FileAttachmentModel> attachments,
  }) = _SelfAssessmentModel;

  factory SelfAssessmentModel.fromJson(Map<String, dynamic> json) =>
      _$SelfAssessmentModelFromJson(json);

  const SelfAssessmentModel._();

  SelfAssessmentEntity toEntity() => SelfAssessmentEntity(
        name: name,
        employee: employee,
        employeeName: employeeName,
        cycle: cycle,
        goal: goal,
        submissionDate: submissionDate ?? modified,
        modified: modified,
        goalReviews: goalReviews.map((e) => e.toEntity()).toList(),
        timeline: timeline.map((e) => e.toEntity()).toList(),
        competencyReviews: competencyReviews.map((e) => e.toEntity()).toList(),
        attachments: attachments.map((e) => e.toEntity()).toList(),
      );

  static Object? _readGoals(Map json, String key) => _readGoalsList(json, key);
  static Object? _readCompetencies(Map json, String key) => _readCompetenciesList(json, key);
}

Object? _readGoalsList(Map json, String key) {
  return json['goal_ratings'] ?? json['goal_review'];
}

Object? _readCompetenciesList(Map json, String key) {
  return json['competency_ratings'] ?? json['competency_review'];
}

Object? _readGoalName(Map json, String key) {
  return json['goal'] ?? json['goal_name'];
}

@freezed
abstract class FileAttachmentModel with _$FileAttachmentModel {
  const factory FileAttachmentModel({
    required String name,
    @JsonKey(name: 'file_name') required String fileName,
    @JsonKey(name: 'file_url') required String fileUrl,
  }) = _FileAttachmentModel;

  factory FileAttachmentModel.fromJson(Map<String, dynamic> json) =>
      _$FileAttachmentModelFromJson(json);

  const FileAttachmentModel._();

  FileAttachmentEntity toEntity() => FileAttachmentEntity(
        name: name,
        fileName: fileName,
        fileUrl: fileUrl,
      );
}


@freezed
abstract class GoalReviewModel with _$GoalReviewModel {
  const factory GoalReviewModel({
    required String name,
    @JsonKey(name: 'goal', readValue: _readGoalName) @Default('') String goal,
    @JsonKey(name: 'kras') @Default('') String kras,
    @Default(0.0) double weightage,
    @Default(0.0) double target,
    @Default(0.0) double progress,
    @JsonKey(name: 'self_rating') @Default('') String selfRating,
    @JsonKey(name: 'self_comment') @Default('') String selfComment,
    @JsonKey(name: 'manager_rating') @Default('') String managerRating,
    @JsonKey(name: 'manager_percentage') @Default(0.0) double managerPercentage,
    @JsonKey(name: 'manager_comment') @Default('') String managerComment,
    @JsonKey(name: 'employee_comment') @Default('') String employeeComment,
    @Default(0.0) double achieved,
    @JsonKey(name: 'weighted_score') @Default(0.0) double weightedScore,
    required DateTime modified,
  }) = _GoalReviewModel;

  factory GoalReviewModel.fromJson(Map<String, dynamic> json) =>
      _$GoalReviewModelFromJson(json);

  const GoalReviewModel._();

  GoalReviewEntity toEntity() => GoalReviewEntity(
        name: name,
        goal: goal,
        kras: kras,
        weightage: weightage,
        target: target,
        progress: progress,
        selfRating: selfRating,
        selfComment: selfComment,
        managerRating: managerRating,
        managerPercentage: managerPercentage,
        managerComment: managerComment,
        employeeComment: employeeComment,
        achieved: achieved,
        weightedScore: weightedScore,
        modified: modified,
      );
}

@freezed
abstract class TimelineStageModel with _$TimelineStageModel {
  const factory TimelineStageModel({
    required String name,
    @JsonKey(name: 'stage_name') @Default('') String stageName,
    required DateTime date,
    @JsonKey(name: 'stauts') @Default('') String status,
  }) = _TimelineStageModel;

  factory TimelineStageModel.fromJson(Map<String, dynamic> json) =>
      _$TimelineStageModelFromJson(json);

  const TimelineStageModel._();

  TimelineStageEntity toEntity() => TimelineStageEntity(
        name: name,
        stageName: stageName,
        date: date,
        status: status,
      );
}

@freezed
abstract class CompetencyReviewModel with _$CompetencyReviewModel {
  const factory CompetencyReviewModel({
    required String name,
    required String competency,
  }) = _CompetencyReviewModel;

  factory CompetencyReviewModel.fromJson(Map<String, dynamic> json) =>
      _$CompetencyReviewModelFromJson(json);

  const CompetencyReviewModel._();

  CompetencyReviewEntity toEntity() => CompetencyReviewEntity(
        name: name,
        competency: competency,
      );
}
