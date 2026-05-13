import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/leave_constants.dart';
import '../../domain/usecases/get_leave_types_usecase.dart';
import '../../domain/usecases/get_leave_balance_usecase.dart';
import '../../domain/usecases/submit_leave_usecase.dart';
import '../../domain/usecases/update_leave_usecase.dart';
import '../../domain/usecases/get_leave_statistics_usecase.dart';
import '../../domain/usecases/get_overlap_leaves_usecase.dart';
import '../../domain/usecases/upload_file_usecase.dart';
import 'leave_event.dart';
import 'leave_state.dart';
import '../utils/leave_form_utils.dart';
import '../../domain/entities/leave_entity.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import '../../../../core/services/image_compress_service.dart';
import '../../../../core/utils/file_validation_utils.dart';
import '../../../../core/utils/toast_utils.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  final GetLeaveTypesUseCase getLeaveTypesUseCase;
  final GetLeaveBalanceUseCase getLeaveBalanceUseCase;
  final SubmitLeaveUseCase submitLeaveUseCase;
  final UpdateLeaveUseCase updateLeaveUseCase;
  final GetLeaveStatisticsUseCase getLeaveStatisticsUseCase;
  final GetOverlapLeavesUseCase getOverlapLeavesUseCase;
  final UploadFileUseCase uploadFileUseCase;

  LeaveBloc({
    required this.getLeaveTypesUseCase,
    required this.getLeaveBalanceUseCase,
    required this.submitLeaveUseCase,
    required this.updateLeaveUseCase,
    required this.getLeaveStatisticsUseCase,
    required this.getOverlapLeavesUseCase,
    required this.uploadFileUseCase,
  }) : super(const LeaveState()) {
    on<LeaveEvent>((event, emit) async {
      await event.when(
        applyRequested: (id, name, type, from, to, reason, half, halfDayDate, halfDaySegment, total) async =>
            _onApplyRequested(id, name, type, from, to, reason, half, halfDayDate, halfDaySegment, total, emit),
        updateRequested: (id, from, to, reason, half, halfDayDate, halfDaySegment, total) async =>
            _onUpdateRequested(id, from, to, reason, half, halfDayDate, halfDaySegment, total, emit),
        balanceRequested: (id, date, gender, isRefresh) async => _onBalanceRequested(id, date, gender, isRefresh, emit),
        statisticsRequested: (id, from, to, isRefresh) async => _onStatisticsRequested(id, from, to, isRefresh, emit),
        typesRequested: (isRefresh) async => _onTypesRequested(isRefresh, emit),
        overlapLeavesRequested: (id, from, to) async => _onOverlapLeavesRequested(id, from, to, emit),
        uploadFileRequested: (file, id) async => _onUploadFileRequested(file, id, emit),
        clearUploadStatus: () async => emit(state.copyWith(uploadedFileUrl: null, uploadError: null, isUploading: false)),
        leaveTypeChanged: (type) async => emit(state.copyWith(selectedLeaveType: type)),
        dateSelected: (isFrom, date) async => _onDateSelected(isFrom, date, emit),
        halfDayToggled: (isHalf) async => _onHalfDayToggled(isHalf, emit),
        halfDayDateSelected: (date) async => emit(state.copyWith(halfDayDate: date)),
        daySegmentChanged: (segment) async => emit(state.copyWith(daySegment: segment)),
        formInitialized: (leave) async => _onFormInitialized(leave, emit),
        overlapHiddenStatusChanged: (hide) async => emit(state.copyWith(hideOverlapAfterSubmit: hide)),
      );
    });
  }

  Future<void> _onTypesRequested(bool isRefresh, Emitter<LeaveState> emit) async {
    if (!isRefresh) {
      emit(state.copyWith(isInitialLoading: true));
    }
    final result = await getLeaveTypesUseCase();
    result.fold(
      (failure) => emit(state.copyWith(isInitialLoading: false, errorMessage: failure.message, success: false)),
      (types) => emit(state.copyWith(isInitialLoading: false, leaveTypes: types, success: false)),
    );
  }

  Future<void> _onApplyRequested(
    String employeeId,
    String employeeName,
    String leaveType,
    String fromDate,
    String toDate,
    String reason,
    int halfDay,
    String? halfDayDate,
    String? halfDaySegment,
    double? totalleavedays,
    Emitter<LeaveState> emit,
  ) async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true, errorMessage: null, success: false));
    final result = await submitLeaveUseCase(
      employeeId: employeeId,
      employeeName: employeeName,
      leaveType: leaveType,
      fromDate: fromDate,
      toDate: toDate,
      reason: reason,
      halfDay: halfDay,
      halfDayDate: halfDayDate,
      halfDaySegment: halfDaySegment,
      totalleavedays: totalleavedays,
    );

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (success) {
        if (success) {
          emit(state.copyWith(isLoading: false, success: true));
        } else {
          emit(state.copyWith(isLoading: false, errorMessage: LeaveErrorConstants.submissionFailed));
        }
      },
    );
  }

  Future<void> _onUpdateRequested(
    String leaveId,
    String fromDate,
    String toDate,
    String reason,
    int halfDay,
    String? halfDayDate,
    String? halfDaySegment,
    double? totalleavedays,
    Emitter<LeaveState> emit,
  ) async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true, errorMessage: null, success: false));
    final result = await updateLeaveUseCase(
      leaveId: leaveId,
      fromDate: fromDate,
      toDate: toDate,
      reason: reason,
      halfDay: halfDay,
      halfDayDate: halfDayDate,
      halfDaySegment: halfDaySegment,
      totalleavedays: totalleavedays,
    );

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (success) {
        if (success) {
          emit(state.copyWith(isLoading: false, success: true));
        } else {
          emit(state.copyWith(isLoading: false, errorMessage: LeaveErrorConstants.updateFailed));
        }
      },
    );
  }

  Future<void> _onBalanceRequested(String employeeId, String todayDate, String gender, bool isRefresh, Emitter<LeaveState> emit) async {
    if (!isRefresh) {
      emit(state.copyWith(isInitialLoading: true));
    }
    final result = await getLeaveBalanceUseCase(employeeId, todayDate, gender);
    result.fold(
      (failure) => emit(state.copyWith(isInitialLoading: false, errorMessage: failure.message, success: false)),
      (balance) => emit(state.copyWith(isInitialLoading: false, balance: balance, success: false)),
    );
  }

  Future<void> _onStatisticsRequested(
    String employeeId,
    String fromDate,
    String toDate,
    bool isRefresh,
    Emitter<LeaveState> emit,
  ) async {
    if (!isRefresh) {
      emit(state.copyWith(isInitialLoading: true));
    }
    final result = await getLeaveStatisticsUseCase(GetLeaveStatisticsParams(
      employeeId: employeeId,
      fromDate: fromDate,
      toDate: toDate,
    ));
    result.fold(
      (failure) => emit(state.copyWith(isInitialLoading: false, errorMessage: failure.message, success: false)),
      (statistics) => emit(state.copyWith(isInitialLoading: false, statistics: statistics, success: false, errorMessage: null)),
    );
  }

  Future<void> _onOverlapLeavesRequested(
    String employeeId,
    String fromDate,
    String toDate,
    Emitter<LeaveState> emit,
  ) async {
    emit(state.copyWith(loadingOverlap: true, overlapLeaves: [], errorMessage: null));
    final result = await getOverlapLeavesUseCase(
      employeeId: employeeId,
      fromDate: fromDate,
      toDate: toDate,
    );
    result.fold(
      (failure) => emit(state.copyWith(loadingOverlap: false, errorMessage: failure.message)),
      (leaves) => emit(state.copyWith(loadingOverlap: false, overlapLeaves: leaves)),
    );
  }

  Future<void> _onUploadFileRequested(
    PlatformFile file,
    String employeeId,
    Emitter<LeaveState> emit,
  ) async {
    // 1. Validation (Size check)
    if (file.size > FileValidationUtils.defaultMaxFileSize) {
      // We can't easily get l10n here, so we use a generic error or emit a state.
      // But for simplicity as requested, we'll use ToastUtils with a fallback message.
      // Ideally, the UI should pass the localized error message or we should use an error code.
      emit(state.copyWith(uploadError: 'File size exceeds limit'));
      return;
    }

    emit(state.copyWith(
      isUploading: true,
      uploadError: null,
      uploadedFileUrl: null,
      selectedFileName: file.name,
    ));

    // 2. Processing (Compression)
    String finalPath = file.path!;
    final extension = p.extension(finalPath).toLowerCase();
    
    if (['.jpg', '.jpeg', '.png'].contains(extension)) {
      try {
        final imageCompressService = Get.find<ImageCompressService>();
        final compressedFile = await imageCompressService.compressImage(finalPath);
        if (compressedFile != null) {
          finalPath = compressedFile.path;
        }
      } catch (e) {
        // Fallback to original path if compression fails
      }
    }

    // 3. Upload
    final result = await uploadFileUseCase(
      filePath: finalPath,
      fileName: file.name,
      employeeId: employeeId,
    );

    result.fold(
      (failure) => emit(state.copyWith(isUploading: false, uploadError: failure.message)),
      (fileUrl) => emit(state.copyWith(
        isUploading: false,
        uploadedFileUrl: fileUrl,
        uploadCount: state.uploadCount + 1,
      )),
    );
  }

  void _onDateSelected(bool isFromDate, DateTime picked, Emitter<LeaveState> emit) {
    final result = LeaveFormUtils.applyDateSelectionRules(
      isFromDate: isFromDate,
      picked: picked,
      isHalfDay: state.isHalfDay,
      currentFromDate: state.fromDate,
      currentToDate: state.toDate,
      currentHalfDayDate: state.halfDayDate,
    );

    emit(state.copyWith(
      fromDate: result.fromDate,
      toDate: result.toDate,
      halfDayDate: result.halfDayDate,
    ));
  }

  void _onHalfDayToggled(bool isHalfDay, Emitter<LeaveState> emit) {
    DateTime? toDate = state.toDate;
    DateTime? halfDayDate = state.halfDayDate;

    if (isHalfDay && state.fromDate != null) {
      toDate = state.fromDate;
      halfDayDate = state.fromDate;
    }

    emit(state.copyWith(
      isHalfDay: isHalfDay,
      toDate: toDate,
      halfDayDate: halfDayDate,
    ));
  }

  void _onFormInitialized(LeaveEntity? leave, Emitter<LeaveState> emit) {
    if (leave == null) return;

    emit(state.copyWith(
      selectedLeaveType: leave.leaveType,
      fromDate: DateTime.tryParse(leave.fromDate),
      toDate: DateTime.tryParse(leave.toDate),
      isHalfDay: leave.halfDay == 1,
      halfDayDate: leave.halfDayDate != null ? DateTime.tryParse(leave.halfDayDate!) : null,
      daySegment: leave.halfDaySegment,
    ));
  }
}
