part of 'self_assessment_cubit.dart';

@freezed
class SelfAssessmentState with _$SelfAssessmentState {
  const factory SelfAssessmentState.initial({
    String? selectedKra,
    @Default(false) bool isAttachmentUploading,
    @Default('') String deletingAttachmentId,
  }) = _Initial;

  const factory SelfAssessmentState.loading({
    String? selectedKra,
    @Default(false) bool isAttachmentUploading,
    @Default('') String deletingAttachmentId,
  }) = _Loading;

  const factory SelfAssessmentState.success(
    SelfAssessmentEntity details, {
    String? selectedKra,
    @Default({}) Map<String, List<GoalReviewEntity>> groupedGoals,
    @Default([]) List<String> kras,
    SaTrackingEntity? tracking,
    @Default(false) bool isAttachmentUploading,
    @Default('') String deletingAttachmentId,
  }) = _Success;

  const factory SelfAssessmentState.saving(
    SelfAssessmentEntity details, {
    String? selectedKra,
    @Default({}) Map<String, List<GoalReviewEntity>> groupedGoals,
    @Default([]) List<String> kras,
    SaTrackingEntity? tracking,
    @Default(false) bool isAttachmentUploading,
    @Default('') String deletingAttachmentId,
  }) = _Saving;

  const factory SelfAssessmentState.saveSuccess(
    SelfAssessmentEntity details, {
    String? selectedKra,
    @Default({}) Map<String, List<GoalReviewEntity>> groupedGoals,
    @Default([]) List<String> kras,
    SaTrackingEntity? tracking,
    @Default(false) bool isAttachmentUploading,
    @Default('') String deletingAttachmentId,
  }) = _SaveSuccess;

  const factory SelfAssessmentState.submitting(
    SelfAssessmentEntity details, {
    String? selectedKra,
    @Default({}) Map<String, List<GoalReviewEntity>> groupedGoals,
    @Default([]) List<String> kras,
    SaTrackingEntity? tracking,
    @Default(false) bool isAttachmentUploading,
    @Default('') String deletingAttachmentId,
  }) = _Submitting;

  const factory SelfAssessmentState.submitSuccess(
    SelfAssessmentEntity details, {
    String? selectedKra,
    @Default({}) Map<String, List<GoalReviewEntity>> groupedGoals,
    @Default([]) List<String> kras,
    SaTrackingEntity? tracking,
    @Default(false) bool isAttachmentUploading,
    @Default('') String deletingAttachmentId,
  }) = _SubmitSuccess;

  const factory SelfAssessmentState.failure(
    String message, {
    String? selectedKra,
    SelfAssessmentEntity? details,
    @Default({}) Map<String, List<GoalReviewEntity>> groupedGoals,
    @Default([]) List<String> kras,
    SaTrackingEntity? tracking,
    @Default(false) bool isAttachmentUploading,
    @Default('') String deletingAttachmentId,
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

  SelfAssessmentEntity? get details => maybeMap(
        success: (s) => s.details,
        saving: (s) => s.details,
        saveSuccess: (s) => s.details,
        submitting: (s) => s.details,
        submitSuccess: (s) => s.details,
        failure: (s) => s.details,
        orElse: () => null,
      );

  Map<String, List<GoalReviewEntity>> get groupedGoals => maybeMap(
        success: (s) => s.groupedGoals,
        saving: (s) => s.groupedGoals,
        saveSuccess: (s) => s.groupedGoals,
        submitting: (s) => s.groupedGoals,
        submitSuccess: (s) => s.groupedGoals,
        failure: (s) => s.groupedGoals,
        orElse: () => {},
      );

  List<String> get kras => maybeMap(
        success: (s) => s.kras,
        saving: (s) => s.kras,
        saveSuccess: (s) => s.kras,
        submitting: (s) => s.kras,
        submitSuccess: (s) => s.kras,
        failure: (s) => s.kras,
        orElse: () => [],
      );

  SaTrackingEntity? get tracking => maybeMap(
        success: (s) => s.tracking,
        saving: (s) => s.tracking,
        saveSuccess: (s) => s.tracking,
        submitting: (s) => s.tracking,
        submitSuccess: (s) => s.tracking,
        failure: (s) => s.tracking,
        orElse: () => null,
      );

  bool get isLoading => maybeMap(
        loading: (_) => true,
        orElse: () => false,
      );

  bool get isAttachmentUploading => maybeMap(
        initial: (s) => s.isAttachmentUploading,
        loading: (s) => s.isAttachmentUploading,
        success: (s) => s.isAttachmentUploading,
        saving: (s) => s.isAttachmentUploading,
        saveSuccess: (s) => s.isAttachmentUploading,
        submitting: (s) => s.isAttachmentUploading,
        submitSuccess: (s) => s.isAttachmentUploading,
        failure: (s) => s.isAttachmentUploading,
        orElse: () => false,
      );

  String get deletingAttachmentId => maybeMap(
        initial: (s) => s.deletingAttachmentId,
        loading: (s) => s.deletingAttachmentId,
        success: (s) => s.deletingAttachmentId,
        saving: (s) => s.deletingAttachmentId,
        saveSuccess: (s) => s.deletingAttachmentId,
        submitting: (s) => s.deletingAttachmentId,
        submitSuccess: (s) => s.deletingAttachmentId,
        failure: (s) => s.deletingAttachmentId,
        orElse: () => '',
      );
}
