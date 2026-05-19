part of 'self_assessment_cubit.dart';

enum SelfAssessmentStatus { initial, loading, success, failure }
enum SelfAssessmentActionStatus { none, saving, saveSuccess, submitting, submitSuccess, failure }

@freezed
class SelfAssessmentState with _$SelfAssessmentState {
  const factory SelfAssessmentState({
    @Default(SelfAssessmentStatus.initial) SelfAssessmentStatus status,
    @Default(SelfAssessmentActionStatus.none) SelfAssessmentActionStatus actionStatus,
    @Default('') String errorMessage,
    @Default('') String actionErrorMessage,
    SelfAssessmentEntity? details,
    String? selectedKra,
    @Default({}) Map<String, List<GoalReviewEntity>> groupedGoals,
    @Default([]) List<String> kras,
    @Default({}) Map<String, double> kraWeightages,
    SaTrackingEntity? tracking,
    @Default(false) bool isAttachmentUploading,
    @Default('') String deletingAttachmentId,
  }) = _SelfAssessmentState;
}

