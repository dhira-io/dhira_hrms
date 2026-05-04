import 'package:freezed_annotation/freezed_annotation.dart';

part 'self_assessment_entity.freezed.dart';

@freezed
abstract class SelfAssessmentEntity with _$SelfAssessmentEntity {
  const factory SelfAssessmentEntity({
    required String name,
    required String employee,
    required String employeeName,
    required String cycle,
    required String goal,
    required DateTime submissionDate,
    required DateTime modified,
    required List<GoalReviewEntity> goalReviews,
    required List<TimelineStageEntity> timeline,
    required List<CompetencyReviewEntity> competencyReviews,
    @Default([]) List<FileAttachmentEntity> attachments,
  }) = _SelfAssessmentEntity;
}

@freezed
abstract class FileAttachmentEntity with _$FileAttachmentEntity {
  const factory FileAttachmentEntity({
    required String name,
    required String fileName,
    required String fileUrl,
  }) = _FileAttachmentEntity;
}


@freezed
abstract class GoalReviewEntity with _$GoalReviewEntity {
  const factory GoalReviewEntity({
    required String name,
    required String goal,
    required String kras,
    required double weightage,
    required double target,
    required double progress,
    required String selfRating,
    required String selfComment,
    required String managerRating,
    required double managerPercentage,
    required String managerComment,
    required String employeeComment,
    required double achieved,
    required DateTime modified,
  }) = _GoalReviewEntity;
}

@freezed
abstract class TimelineStageEntity with _$TimelineStageEntity {
  const factory TimelineStageEntity({
    required String name,
    required String stageName,
    required DateTime date,
    required String status,
  }) = _TimelineStageEntity;
}

@freezed
abstract class CompetencyReviewEntity with _$CompetencyReviewEntity {
  const factory CompetencyReviewEntity({
    required String name,
    required String competency,
  }) = _CompetencyReviewEntity;
}
