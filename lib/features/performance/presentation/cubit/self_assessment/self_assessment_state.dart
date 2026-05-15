part of 'self_assessment_cubit.dart';

@freezed
class SelfAssessmentState with _$SelfAssessmentState {
  const factory SelfAssessmentState.initial({String? selectedKra}) = _Initial;
  const factory SelfAssessmentState.loading({String? selectedKra}) = _Loading;
  const factory SelfAssessmentState.success(
    SelfAssessmentEntity details, {
    String? selectedKra,
  }) = _Success;
  const factory SelfAssessmentState.saving(
    SelfAssessmentEntity details, {
    String? selectedKra,
  }) = _Saving;
  const factory SelfAssessmentState.saveSuccess(
    SelfAssessmentEntity details, {
    String? selectedKra,
  }) = _SaveSuccess;
  const factory SelfAssessmentState.submitting(
    SelfAssessmentEntity details, {
    String? selectedKra,
  }) = _Submitting;
  const factory SelfAssessmentState.submitSuccess(
    SelfAssessmentEntity details, {
    String? selectedKra,
  }) = _SubmitSuccess;
  const factory SelfAssessmentState.failure(
    String message, {
    String? selectedKra,
  }) = _Failure;

  const SelfAssessmentState._();

  String? get selectedKra => maybeMap(
        initial: (s) => s.selectedKra,
        loading: (s) => s.selectedKra,
        success: (s) => s.selectedKra,
        saving: (s) => s.selectedKra,
        saveSuccess: (s) => s.selectedKra,
        submitting: (s) => s.selectedKra,
        submitSuccess: (s) => s.selectedKra,
        failure: (s) => s.selectedKra,
        orElse: () => null,
      );

  bool get isLoading => maybeMap(
        loading: (_) => true,
        orElse: () => false,
      );
}

