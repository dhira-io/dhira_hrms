import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dhira_hrms/core/services/local_storage_service.dart';
import 'package:dhira_hrms/core/services/image_compress_service.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dhira_hrms/features/attendance_regularization/domain/entities/attendance_regularization_entity.dart';
import 'package:dhira_hrms/features/attendance_regularization/domain/usecases/submit_attendance_regularization_usecase.dart';
import 'package:dhira_hrms/features/attendance_regularization/domain/usecases/upload_attendance_regularization_file_usecase.dart';
import 'package:dhira_hrms/features/attendance_regularization/domain/usecases/get_regularization_punch_summary_usecase.dart';
import 'attendance_regularization_event.dart';
import 'attendance_regularization_state.dart';

class AttendanceRegularizationBloc
    extends Bloc<AttendanceRegularizationEvent, AttendanceRegularizationState> {
  final SubmitAttendanceRegularizationUseCase submitRegularizationUseCase;
  final UploadAttendanceRegularizationFileUseCase uploadFileUseCase;
  final GetRegularizationPunchSummaryUseCase getAttendancePunchSummaryUseCase;
  final LocalStorageService localStorageService;
  final ImageCompressService imageCompressService;

  AttendanceRegularizationBloc({
    required this.submitRegularizationUseCase,
    required this.uploadFileUseCase,
    required this.getAttendancePunchSummaryUseCase,
    required this.localStorageService,
    required this.imageCompressService,
  }) : super(const AttendanceRegularizationState.initial()) {
    on<AttendanceRegularizationStarted>(_onStarted);
    on<AttendanceRegularizationDateChanged>(_onDateChanged);
    on<AttendanceRegularizationRequestTypeChanged>(_onRequestTypeChanged);
    on<AttendanceRegularizationInTimeChanged>(_onInTimeChanged);
    on<AttendanceRegularizationOutTimeChanged>(_onOutTimeChanged);
    on<AttendanceRegularizationRouteToHRChanged>(_onRouteToHRChanged);
    on<AttendanceRegularizationReasonChanged>(_onReasonChanged);
    on<AttendanceRegularizationUploadFileRequested>(_onUploadFileRequested);
    on<AttendanceRegularizationPickFileRequested>(_onPickFileRequested);
    on<AttendanceRegularizationFileRemoved>(_onFileRemoved);
    on<AttendanceRegularizationNextPressed>(_onNextPressed);
    on<AttendanceRegularizationPreviousPressed>(_onPreviousPressed);
    on<AttendanceRegularizationSubmitRequested>(_onSubmitRequested);
    on<AttendanceRegularizationResetRequested>(_onResetRequested);
  }

  void _onStarted(
    AttendanceRegularizationStarted event,
    Emitter<AttendanceRegularizationState> emit,
  ) {
    emit(const AttendanceRegularizationState.initial());
  }

  Future<void> _onDateChanged(
    AttendanceRegularizationDateChanged event,
    Emitter<AttendanceRegularizationState> emit,
  ) async {
    final currentStep = state.currentStep;
    final updatedFormData = state.formData.copyWith(
      date: event.date,
      punchSummary: null,
      isPunchSummaryLoading: true,
      inTime: null,
      outTime: null,
    );

    emit(
      AttendanceRegularizationState.initial(
        formData: updatedFormData,
        currentStep: currentStep,
      ),
    );

    final attendanceDate = DateTimeUtils.formatToYMD(event.date);
    final result = await getAttendancePunchSummaryUseCase(attendanceDate);

    if (state.formData.date != event.date) return;

    result.fold(
      (failure) => emit(
        AttendanceRegularizationState.initial(
          formData: state.formData.copyWith(
            punchSummary: null,
            isPunchSummaryLoading: false,
          ),
          currentStep: currentStep,
        ),
      ),
      (summary) {
        // Derive Clock In & Clock Out from punch summary
        final derivedIn = _parseTime(summary.firstIn);
        final derivedOut = _parseTime(summary.lastOut);

        emit(
          AttendanceRegularizationState.initial(
            formData: state.formData.copyWith(
              punchSummary: summary,
              isPunchSummaryLoading: false,
              inTime: derivedIn,
              outTime: derivedOut,
            ),
            currentStep: currentStep,
          ),
        );
      },
    );
  }

  void _onRequestTypeChanged(
    AttendanceRegularizationRequestTypeChanged event,
    Emitter<AttendanceRegularizationState> emit,
  ) {
    emit(
      AttendanceRegularizationState.initial(
        formData: state.formData.copyWith(requestType: event.type),
        currentStep: state.currentStep,
      ),
    );
  }

  void _onInTimeChanged(
    AttendanceRegularizationInTimeChanged event,
    Emitter<AttendanceRegularizationState> emit,
  ) {
    emit(
      AttendanceRegularizationState.initial(
        formData: state.formData.copyWith(inTime: event.time),
        currentStep: state.currentStep,
      ),
    );
  }

  void _onOutTimeChanged(
    AttendanceRegularizationOutTimeChanged event,
    Emitter<AttendanceRegularizationState> emit,
  ) {
    emit(
      AttendanceRegularizationState.initial(
        formData: state.formData.copyWith(outTime: event.time),
        currentStep: state.currentStep,
      ),
    );
  }

  void _onRouteToHRChanged(
    AttendanceRegularizationRouteToHRChanged event,
    Emitter<AttendanceRegularizationState> emit,
  ) {
    emit(
      AttendanceRegularizationState.initial(
        formData: state.formData.copyWith(routeToHR: event.value),
        currentStep: state.currentStep,
      ),
    );
  }

  void _onReasonChanged(
    AttendanceRegularizationReasonChanged event,
    Emitter<AttendanceRegularizationState> emit,
  ) {
    emit(
      AttendanceRegularizationState.initial(
        formData: state.formData.copyWith(reason: event.reason),
        currentStep: state.currentStep,
      ),
    );
  }

  Future<void> _onUploadFileRequested(
    AttendanceRegularizationUploadFileRequested event,
    Emitter<AttendanceRegularizationState> emit,
  ) async {
    if (event.fileSize > AppConstants.maxAttachmentBytes) {
      emit(
        AttendanceRegularizationState.error(
          formData: state.formData,
          validationError: AttendanceRegularizationValidationError.fileTooLarge,
          currentStep: state.currentStep,
        ),
      );
      return;
    }

    emit(
      AttendanceRegularizationState.loading(
        formData: state.formData.copyWith(selectedFileName: event.fileName),
        kind: AttendanceRegularizationLoadingKind.upload,
        currentStep: state.currentStep,
      ),
    );

    String pathToBeUploaded = event.filePath;
    String nameToBeUploaded = event.fileName;
    final extension = event.filePath.split('.').last.toLowerCase();

    // Compress only if it's an image
    if (AppConstants.imageExtensions.contains(extension)) {
      final compressedFile = await imageCompressService.compressImage(
        event.filePath,
      );
      if (compressedFile != null) {
        pathToBeUploaded = compressedFile.path;
        if (!nameToBeUploaded.toLowerCase().endsWith('.jpg')) {
          final nameWithoutExt = nameToBeUploaded.contains('.')
              ? nameToBeUploaded.substring(0, nameToBeUploaded.lastIndexOf('.'))
              : nameToBeUploaded;
          nameToBeUploaded = '$nameWithoutExt.jpg';
        }
      }
    }

    final result = await uploadFileUseCase(
      UploadFileParams(filePath: pathToBeUploaded, fileName: nameToBeUploaded),
    );

    result.fold(
      (failure) => emit(
        AttendanceRegularizationState.error(
          formData: state.formData,
          message: failure.message,
          currentStep: state.currentStep,
        ),
      ),
      (fileUrl) => emit(
        AttendanceRegularizationState.success(
          formData: state.formData.copyWith(uploadedFileUrl: fileUrl),
          kind: AttendanceRegularizationSuccessKind.fileUpload,
          currentStep: state.currentStep,
        ),
      ),
    );
  }

  Future<void> _onPickFileRequested(
    AttendanceRegularizationPickFileRequested event,
    Emitter<AttendanceRegularizationState> emit,
  ) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: AppConstants.allowedExtensions,
    );
    if (result == null) return;

    final file = result.files.first;
    if (file.path == null) return;

    add(
      AttendanceRegularizationEvent.uploadFileRequested(
        filePath: file.path!,
        fileName: file.name,
        fileSize: file.size,
      ),
    );
  }

  void _onFileRemoved(
    AttendanceRegularizationFileRemoved event,
    Emitter<AttendanceRegularizationState> emit,
  ) {
    emit(
      AttendanceRegularizationState.initial(
        formData: state.formData.copyWith(
          selectedFileName: null,
          uploadedFileUrl: null,
        ),
        currentStep: state.currentStep,
      ),
    );
  }

  void _onNextPressed(
    AttendanceRegularizationNextPressed event,
    Emitter<AttendanceRegularizationState> emit,
  ) {
    final formData = state.formData;

    if (formData.date == null) {
      emit(
        AttendanceRegularizationState.error(
          formData: formData,
          validationError: AttendanceRegularizationValidationError.dateRequired,
          currentStep: state.currentStep,
        ),
      );
      return;
    }

    if (formData.inTime == null || formData.outTime == null) {
      emit(
        AttendanceRegularizationState.error(
          formData: formData,
          validationError: AttendanceRegularizationValidationError.timeRequired,
          currentStep: state.currentStep,
        ),
      );
      return;
    }

    if (formData.reason.length < 10) {
      emit(
        AttendanceRegularizationState.error(
          formData: formData,
          validationError:
              AttendanceRegularizationValidationError.reasonTooShort,
          currentStep: state.currentStep,
        ),
      );
      return;
    }

    emit(
      AttendanceRegularizationState.initial(
        formData: formData,
        currentStep: 1, // Advance to Review
      ),
    );
  }

  void _onPreviousPressed(
    AttendanceRegularizationPreviousPressed event,
    Emitter<AttendanceRegularizationState> emit,
  ) {
    emit(
      AttendanceRegularizationState.initial(
        formData: state.formData,
        currentStep: 0, // Go back to Form
      ),
    );
  }

  Future<void> _onSubmitRequested(
    AttendanceRegularizationSubmitRequested event,
    Emitter<AttendanceRegularizationState> emit,
  ) async {
    final formData = state.formData;
    final currentStep = state.currentStep;

    emit(
      AttendanceRegularizationState.loading(
        formData: formData,
        kind: AttendanceRegularizationLoadingKind.submit,
        currentStep: currentStep,
      ),
    );

    final employeeId = localStorageService.getEmpId() ?? '';

    final entity = AttendanceRegularizationEntity(
      date: formData.date!,
      employee: employeeId,
      requestType: formData.requestType.apiReason,
      requestedInTime: _formatTime(formData.date!, formData.inTime!),
      requestedOutTime: _formatTime(formData.date!, formData.outTime!),
      routeToHR: formData.routeToHR,
      reason: formData.reason,
      supportingDocument: formData.uploadedFileUrl,
    );

    final result = await submitRegularizationUseCase(entity);

    result.fold(
      (failure) => emit(
        AttendanceRegularizationState.error(
          formData: formData,
          message: failure.message,
          currentStep: currentStep,
        ),
      ),
      (_) => emit(
        AttendanceRegularizationState.success(
          formData: formData,
          kind: AttendanceRegularizationSuccessKind.submission,
          currentStep: 2, // Go to Confirmation
        ),
      ),
    );
  }

  void _onResetRequested(
    AttendanceRegularizationResetRequested event,
    Emitter<AttendanceRegularizationState> emit,
  ) {
    emit(const AttendanceRegularizationState.initial());
  }

  TimeOfDay? _parseTime(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) return null;
    try {
      // 1. Try parsing as a full DateTime
      final parsedDateTime = DateTime.tryParse(timeStr);
      if (parsedDateTime != null) {
        return TimeOfDay(
          hour: parsedDateTime.hour,
          minute: parsedDateTime.minute,
        );
      }

      // 2. If it's a time-only string, strip any date prefix
      final spaceParts = timeStr.trim().split(' ');
      final timeOnlyStr = spaceParts.last;

      final parts = timeOnlyStr.split(':');
      if (parts.length >= 2) {
        final hour = int.parse(parts[0]);
        final minute = int.parse(parts[1]);
        return TimeOfDay(hour: hour, minute: minute);
      }
    } catch (_) {}
    return null;
  }

  String _formatTime(DateTime date, TimeOfDay time) {
    final year = date.year;
    final month = date.month.toString().padLeft(2, '0');
    final day = date.day.toString().padLeft(2, '0');
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$year-$month-$day $hour:$minute:00';
  }
}
