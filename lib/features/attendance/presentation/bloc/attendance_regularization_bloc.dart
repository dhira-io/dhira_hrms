import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/utils/date_time_utils.dart';
import '../../domain/entities/attendance_regularization_entity.dart';
import '../../domain/usecases/get_attendance_punch_summary_usecase.dart';
import '../../domain/usecases/submit_regularization_use_case.dart';
import '../../domain/usecases/upload_file_use_case.dart';
import '../../../../core/services/image_compress_service.dart';
import 'attendance_regularization_event.dart';
import 'attendance_regularization_state.dart';

class AttendanceRegularizationBloc
    extends Bloc<AttendanceRegularizationEvent, AttendanceRegularizationState> {
  final SubmitRegularizationUseCase submitRegularizationUseCase;
  final AttendanceRegularizationUploadFileUseCase uploadFileUseCase;
  final GetAttendancePunchSummaryUseCase getAttendancePunchSummaryUseCase;
  final LocalStorageService localStorageService;
  final ImageCompressService imageCompressService;

  AttendanceRegularizationBloc({
    required this.submitRegularizationUseCase,
    required this.uploadFileUseCase,
    required this.getAttendancePunchSummaryUseCase,
    required this.localStorageService,
    required this.imageCompressService,
  }) : super(const AttendanceRegularizationState.initial()) {
    on<DateChanged>(_onDateChanged);
    on<RegularizationStarted>(_onRegularizationStarted);
    on<RequestTypeChanged>(_onRequestTypeChanged);
    on<InTimeChanged>(_onInTimeChanged);
    on<OutTimeChanged>(_onOutTimeChanged);
    on<RouteToHRChanged>(_onRouteToHRChanged);
    on<ReasonChanged>(_onReasonChanged);
    on<UploadFileRequested>(_onUploadFileRequested);
    on<FileRemoved>(_onFileRemoved);
    on<SubmitRequested>(_onSubmitRequested);
    on<ResetRequested>(_onResetRequested);
  }

  void _onRegularizationStarted(
    RegularizationStarted event,
    Emitter<AttendanceRegularizationState> emit,
  ) {
    emit(const AttendanceRegularizationState.initial());
  }

  Future<void> _onDateChanged(
    DateChanged event,
    Emitter<AttendanceRegularizationState> emit,
  ) async {
    final formData = state.formData.copyWith(
      date: event.date,
      punchSummary: null,
      isPunchSummaryLoading: true,
    );

    emit(
      AttendanceRegularizationState.initial(
        formData: formData,
      ),
    );

    final attendanceDate = DateTimeUtils.formatToYMD(event.date);
    final result = await getAttendancePunchSummaryUseCase(
      attendanceDate: attendanceDate,
    );

    if (state.formData.date != event.date) return;

    result.fold(
      (failure) => emit(
        AttendanceRegularizationState.initial(
          formData: state.formData.copyWith(
            punchSummary: null,
            isPunchSummaryLoading: false,
          ),
        ),
      ),
      (summary) => emit(
        AttendanceRegularizationState.initial(
          formData: state.formData.copyWith(
            punchSummary: summary,
            isPunchSummaryLoading: false,
          ),
        ),
      ),
    );
  }

  void _onRequestTypeChanged(
    RequestTypeChanged event,
    Emitter<AttendanceRegularizationState> emit,
  ) {
    emit(
      AttendanceRegularizationState.initial(
        formData: state.formData.copyWith(requestType: event.type),
      ),
    );
  }

  void _onInTimeChanged(
    InTimeChanged event,
    Emitter<AttendanceRegularizationState> emit,
  ) {
    emit(
      AttendanceRegularizationState.initial(
        formData: state.formData.copyWith(inTime: event.time),
      ),
    );
  }

  void _onOutTimeChanged(
    OutTimeChanged event,
    Emitter<AttendanceRegularizationState> emit,
  ) {
    emit(
      AttendanceRegularizationState.initial(
        formData: state.formData.copyWith(outTime: event.time),
      ),
    );
  }

  void _onRouteToHRChanged(
    RouteToHRChanged event,
    Emitter<AttendanceRegularizationState> emit,
  ) {
    emit(
      AttendanceRegularizationState.initial(
        formData: state.formData.copyWith(routeToHR: event.value),
      ),
    );
  }

  void _onReasonChanged(
    ReasonChanged event,
    Emitter<AttendanceRegularizationState> emit,
  ) {
    emit(
      AttendanceRegularizationState.initial(
        formData: state.formData.copyWith(reason: event.reason),
      ),
    );
  }

  Future<void> _onUploadFileRequested(
    UploadFileRequested event,
    Emitter<AttendanceRegularizationState> emit,
  ) async {
    emit(
      AttendanceRegularizationState.loading(
        formData: state.formData.copyWith(selectedFileName: event.fileName),
        kind: RegularizationLoadingKind.upload,
      ),
    );

    String pathToBeUploaded = event.filePath;
    String nameToBeUploaded = event.fileName;
    final extension = event.filePath.split('.').last.toLowerCase();

    // Compress only if it's an image
    if (['jpg', 'jpeg', 'png'].contains(extension)) {
      final compressedFile = await imageCompressService.compressImage(
        event.filePath,
      );
      if (compressedFile != null) {
        pathToBeUploaded = compressedFile.path;
        // Update filename to .jpg if original was different (e.g. .png)
        if (!nameToBeUploaded.toLowerCase().endsWith('.jpg')) {
          final nameWithoutExt = nameToBeUploaded.contains('.')
              ? nameToBeUploaded.substring(0, nameToBeUploaded.lastIndexOf('.'))
              : nameToBeUploaded;
          nameToBeUploaded = '$nameWithoutExt.jpg';
        }
      }
    }

    final result = await uploadFileUseCase(
      filePath: pathToBeUploaded,
      fileName: nameToBeUploaded,
    );

    result.fold(
      (failure) => emit(
        AttendanceRegularizationState.error(
          formData: state.formData,
          message: failure.message,
        ),
      ),
      (fileUrl) => emit(
        AttendanceRegularizationState.success(
          formData: state.formData.copyWith(uploadedFileUrl: fileUrl),
          kind: RegularizationSuccessKind.fileUpload,
        ),
      ),
    );
  }

  void _onFileRemoved(
    FileRemoved event,
    Emitter<AttendanceRegularizationState> emit,
  ) {
    emit(
      AttendanceRegularizationState.initial(
        formData: state.formData.copyWith(
          selectedFileName: null,
          uploadedFileUrl: null,
        ),
      ),
    );
  }

  Future<void> _onSubmitRequested(
    SubmitRequested event,
    Emitter<AttendanceRegularizationState> emit,
  ) async {
    final formData = state.formData;

    // Validation
    if (formData.date == null) {
      emit(
        AttendanceRegularizationState.error(
          formData: formData,
          validationError: RegularizationValidationError.dateRequired,
        ),
      );
      return;
    }

    if (formData.inTime == null || formData.outTime == null) {
      emit(
        AttendanceRegularizationState.error(
          formData: formData,
          validationError: RegularizationValidationError.timeRequired,
        ),
      );
      return;
    }

    if (formData.reason.length < 10) {
      emit(
        AttendanceRegularizationState.error(
          formData: formData,
          validationError: RegularizationValidationError.reasonTooShort,
        ),
      );
      return;
    }

    final employeeId = localStorageService.getEmpId() ?? '';

    emit(
      AttendanceRegularizationState.loading(
        formData: formData,
        kind: RegularizationLoadingKind.submit,
      ),
    );

    final entity = AttendanceRegularizationEntity(
      date: formData.date!,
      employee: employeeId,
      requestType: formData.requestType.apiReason,
      requestedInTime: _formatTime(formData.inTime!),
      requestedOutTime: _formatTime(formData.outTime!),
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
        ),
      ),
      (_) => emit(
        AttendanceRegularizationState.success(
          formData: formData,
          kind: RegularizationSuccessKind.submission,
        ),
      ),
    );
  }

  void _onResetRequested(
    ResetRequested event,
    Emitter<AttendanceRegularizationState> emit,
  ) {
    emit(const AttendanceRegularizationState.initial());
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute:00';
  }
}
