import 'package:freezed_annotation/freezed_annotation.dart';

part 'attendance_regularization_state.freezed.dart';

@freezed
abstract class AttendanceRegularizationState with _$AttendanceRegularizationState {
  const factory AttendanceRegularizationState({
    @Default(false) bool isSubmitting,
    @Default(false) bool isUploading,
    @Default(false) bool isSubmissionSuccess,
    @Default(false) bool isFileUploadSuccess,
    String? uploadedFileUrl,
    String? successMessage,
    String? errorMessage,
  }) = _AttendanceRegularizationState;
}
