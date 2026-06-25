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
import 'package:dhira_hrms/features/attendance_regularization/data/constants/attendance_regularization_api_constants.dart';

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
  }) : super(const AttendanceRegularizationState()) {
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
    final manager = localStorageService.getApproverName() ?? '';
    emit(AttendanceRegularizationState(managerName: manager));
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
      state.copyWith(
        status: AttendanceRegularizationStatus.initial,
        formData: updatedFormData,
        currentStep: currentStep,
        errorMessage: null,
        validationError: null,
      ),
    );

    final attendanceDate = DateTimeUtils.formatToYMD(event.date);
    final result = await getAttendancePunchSummaryUseCase(attendanceDate);

    if (state.formData.date != event.date) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: AttendanceRegularizationStatus.initial,
          formData: state.formData.copyWith(
            punchSummary: null,
            isPunchSummaryLoading: false,
          ),
          currentStep: currentStep,
        ),
      ),
      (summary) {
        final derivedIn = _parseTime(summary.firstIn);
        final derivedOut = _parseTime(summary.lastOut);

        emit(
          state.copyWith(
            status: AttendanceRegularizationStatus.initial,
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
      state.copyWith(
        status: AttendanceRegularizationStatus.initial,
        formData: state.formData.copyWith(requestType: event.type),
      ),
    );
  }

  void _onInTimeChanged(
    AttendanceRegularizationInTimeChanged event,
    Emitter<AttendanceRegularizationState> emit,
  ) {
    emit(
      state.copyWith(
        status: AttendanceRegularizationStatus.initial,
        formData: state.formData.copyWith(inTime: event.time),
      ),
    );
  }

  void _onOutTimeChanged(
    AttendanceRegularizationOutTimeChanged event,
    Emitter<AttendanceRegularizationState> emit,
  ) {
    emit(
      state.copyWith(
        status: AttendanceRegularizationStatus.initial,
        formData: state.formData.copyWith(outTime: event.time),
      ),
    );
  }

  void _onRouteToHRChanged(
    AttendanceRegularizationRouteToHRChanged event,
    Emitter<AttendanceRegularizationState> emit,
  ) {
    emit(
      state.copyWith(
        status: AttendanceRegularizationStatus.initial,
        formData: state.formData.copyWith(routeToHR: event.value),
      ),
    );
  }

  void _onReasonChanged(
    AttendanceRegularizationReasonChanged event,
    Emitter<AttendanceRegularizationState> emit,
  ) {
    emit(
      state.copyWith(
        status: AttendanceRegularizationStatus.initial,
        formData: state.formData.copyWith(reason: event.reason),
      ),
    );
  }

  Future<void> _onUploadFileRequested(
    AttendanceRegularizationUploadFileRequested event,
    Emitter<AttendanceRegularizationState> emit,
  ) async {
    if (event.fileSize > AppConstants.maxAttachmentBytes) {
      emit(
        state.copyWith(
          status: AttendanceRegularizationStatus.error,
          validationError: AttendanceRegularizationValidationError.fileTooLarge,
          errorMessage: null,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: AttendanceRegularizationStatus.loading,
        loadingKind: AttendanceRegularizationLoadingKind.upload,
        formData: state.formData.copyWith(selectedFileName: event.fileName),
        errorMessage: null,
        validationError: null,
      ),
    );

    String pathToBeUploaded = event.filePath;
    String nameToBeUploaded = event.fileName;
    final extension = event.filePath.split('.').last.toLowerCase();

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
        state.copyWith(
          status: AttendanceRegularizationStatus.error,
          errorMessage: failure.message,
          loadingKind: null,
        ),
      ),
      (fileUrl) => emit(
        state.copyWith(
          status: AttendanceRegularizationStatus.success,
          successKind: AttendanceRegularizationSuccessKind.fileUpload,
          formData: state.formData.copyWith(uploadedFileUrl: fileUrl),
          loadingKind: null,
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
      state.copyWith(
        status: AttendanceRegularizationStatus.initial,
        formData: state.formData.copyWith(
          selectedFileName: null,
          uploadedFileUrl: null,
        ),
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
        state.copyWith(
          status: AttendanceRegularizationStatus.error,
          validationError: AttendanceRegularizationValidationError.dateRequired,
          errorMessage: null,
        ),
      );
      return;
    }

    if (formData.inTime == null || formData.outTime == null) {
      emit(
        state.copyWith(
          status: AttendanceRegularizationStatus.error,
          validationError: AttendanceRegularizationValidationError.timeRequired,
          errorMessage: null,
        ),
      );
      return;
    }

    if (formData.reason.length < 10) {
      emit(
        state.copyWith(
          status: AttendanceRegularizationStatus.error,
          validationError: AttendanceRegularizationValidationError.reasonTooShort,
          errorMessage: null,
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        status: AttendanceRegularizationStatus.initial,
        currentStep: AttendanceRegularizationSteps.reviewDetails,
        errorMessage: null,
        validationError: null,
      ),
    );
  }

  void _onPreviousPressed(
    AttendanceRegularizationPreviousPressed event,
    Emitter<AttendanceRegularizationState> emit,
  ) {
    emit(
      state.copyWith(
        status: AttendanceRegularizationStatus.initial,
        currentStep: AttendanceRegularizationSteps.enterDetails,
        errorMessage: null,
        validationError: null,
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
      state.copyWith(
        status: AttendanceRegularizationStatus.loading,
        loadingKind: AttendanceRegularizationLoadingKind.submit,
        currentStep: currentStep,
        errorMessage: null,
        validationError: null,
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
      action: AppConstants.actionSave,
    );

    final result = await submitRegularizationUseCase(entity);

    result.fold(
      (failure) => emit(
        state.copyWith(
          status: AttendanceRegularizationStatus.error,
          errorMessage: failure.message,
          loadingKind: null,
        ),
      ),
      (_) => emit(
        state.copyWith(
          status: AttendanceRegularizationStatus.success,
          successKind: AttendanceRegularizationSuccessKind.submission,
          currentStep: AttendanceRegularizationSteps.confirmation,
          loadingKind: null,
        ),
      ),
    );
  }

  void _onResetRequested(
    AttendanceRegularizationResetRequested event,
    Emitter<AttendanceRegularizationState> emit,
  ) {
    emit(AttendanceRegularizationState(
      managerName: localStorageService.getApproverName() ?? '',
    ));
  }

  TimeOfDay? _parseTime(String? timeStr) {
    if (timeStr == null || timeStr.isEmpty) return null;
    try {
      final parsedDateTime = DateTime.tryParse(timeStr);
      if (parsedDateTime != null) {
        return TimeOfDay(
          hour: parsedDateTime.hour,
          minute: parsedDateTime.minute,
        );
      }

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
