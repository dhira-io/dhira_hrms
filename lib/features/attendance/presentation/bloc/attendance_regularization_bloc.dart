import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/submit_regularization_use_case.dart';
import '../../domain/usecases/upload_file_use_case.dart';
import 'attendance_regularization_event.dart';
import 'attendance_regularization_state.dart';

class AttendanceRegularizationBloc
    extends Bloc<AttendanceRegularizationEvent, AttendanceRegularizationState> {
  final SubmitRegularizationUseCase submitRegularizationUseCase;
  final UploadFileUseCase uploadFileUseCase;

  AttendanceRegularizationBloc({
    required this.submitRegularizationUseCase,
    required this.uploadFileUseCase,
  }) : super(const AttendanceRegularizationState()) {
    on<SubmitRequested>(_onSubmitRequested);
    on<UploadFileRequested>(_onUploadFileRequested);
  }

  Future<void> _onSubmitRequested(
    SubmitRequested event,
    Emitter<AttendanceRegularizationState> emit,
  ) async {
    // Clear previous messages and set loading
    emit(state.copyWith(
      isSubmitting: true,
      isSubmissionSuccess: false,
      errorMessage: null,
      successMessage: null,
    ));
    final result = await submitRegularizationUseCase(event.regularization);
    result.fold(
      (failure) {
        // Rollback loading, set error
        emit(state.copyWith(
          isSubmitting: false,
          errorMessage: failure.message,
        ));
      },
      (_) {
        // Set success
        emit(state.copyWith(
          isSubmitting: false,
          isSubmissionSuccess: true,
        ));
      },
    );
  }

  Future<void> _onUploadFileRequested(
    UploadFileRequested event,
    Emitter<AttendanceRegularizationState> emit,
  ) async {
    // Clear previous messages and set uploading
    emit(state.copyWith(
      isUploading: true,
      isSubmissionSuccess: false,
      isFileUploadSuccess: false,
      errorMessage: null,
      successMessage: null,
    ));
    final result = await uploadFileUseCase(
      filePath: event.filePath,
      fileName: event.fileName,
    );
    result.fold(
      (failure) {
        emit(state.copyWith(
          isUploading: false,
          errorMessage: failure.message,
        ));
      },
      (fileUrl) {
        emit(state.copyWith(
          isUploading: false,
          isFileUploadSuccess: true,
          uploadedFileUrl: fileUrl,
        ));
      },
    );
  }
}
