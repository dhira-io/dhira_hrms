part of 'self_assessment_cubit.dart';

@freezed
class SelfAssessmentState with _$SelfAssessmentState {
  const factory SelfAssessmentState.initial() = _Initial;
  const factory SelfAssessmentState.loading() = _Loading;
  const factory SelfAssessmentState.success(SelfAssessmentEntity details) = _Success;
  const factory SelfAssessmentState.saving(SelfAssessmentEntity details) = _Saving;
  const factory SelfAssessmentState.saveSuccess(SelfAssessmentEntity details) = _SaveSuccess;
  const factory SelfAssessmentState.submitting(SelfAssessmentEntity details) = _Submitting;
  const factory SelfAssessmentState.submitSuccess(SelfAssessmentEntity details) = _SubmitSuccess;
  const factory SelfAssessmentState.failure(String message) = _Failure;
}

