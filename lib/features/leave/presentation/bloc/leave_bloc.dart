import 'package:dhira_hrms/core/utils/date_time_utils.dart';
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
import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/leave_entities.dart';
import '../../domain/entities/leave_type_entity.dart';
import '../../domain/entities/leave_balance_entity.dart';
import '../../domain/entities/leave_statistics_entity.dart';

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
        leaveTypeChanged: (type) async => emit(state.copyWith(selectedLeaveType: type, errorMessage: null)),
        dateSelected: (isFrom, date) async => _onDateSelected(isFrom, date, emit),
        halfDayToggled: (isHalf) async => _onHalfDayToggled(isHalf, emit),
        halfDayDateSelected: (date) async => emit(state.copyWith(halfDayDate: date, errorMessage: null)),
        daySegmentChanged: (segment) async => emit(state.copyWith(daySegment: segment, errorMessage: null)),
        formInitialized: (leave, name, gender) async => _onFormInitialized(leave: leave, employeeName: name, gender: gender, emit: emit),
        overlapHiddenStatusChanged: (hide) async => emit(state.copyWith(hideOverlapAfterSubmit: hide, errorMessage: null)),
        clearError: () async => emit(state.copyWith(errorMessage: null)),
        refreshRequested: (id, gender) async => _onRefreshRequested(id, gender, emit),
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
    // Note: Extension check is already done by FilePicker, but we could re-validate here if needed.
    if (file.size > FileValidationUtils.defaultMaxFileSize) {
      emit(state.copyWith(uploadError: 'File size exceeds 5MB limit'));
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
      errorMessage: null,
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
      errorMessage: null,
    ));
  }

  void _onFormInitialized({
    LeaveEntity? leave,
    String? employeeName,
    String? gender,
    required Emitter<LeaveState> emit,
  }) {
    emit(state.copyWith(
      employeeName: employeeName ?? state.employeeName,
      gender: gender ?? state.gender,
      selectedLeaveType: leave?.leaveType ?? state.selectedLeaveType,
      fromDate: leave != null ? DateTime.tryParse(leave.fromDate) : state.fromDate,
      toDate: leave != null ? DateTime.tryParse(leave.toDate) : state.toDate,
      isHalfDay: leave != null ? (leave.halfDay == 1) : state.isHalfDay,
      halfDayDate: (leave != null && leave.halfDayDate != null) ? DateTime.tryParse(leave.halfDayDate!) : state.halfDayDate,
      daySegment: leave?.halfDaySegment ?? state.daySegment,
      errorMessage: null,
    ));
  }

  Future<void> _onRefreshRequested(
    String employeeId,
    String gender,
    Emitter<LeaveState> emit,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));

    final now = DateTime.now();
    final results = await Future.wait([
      getLeaveTypesUseCase(),
      getLeaveBalanceUseCase(employeeId, DateTimeUtils.todayDate(), gender),
      getLeaveStatisticsUseCase(GetLeaveStatisticsParams(
        employeeId: employeeId,
        fromDate: now.firstDayOfMonth.format(),
        toDate: now.lastDayOfMonth.format(),
      )),
    ]);

    // results[0] is Either<Failure, List<LeaveTypeEntity>>
    // results[1] is Either<Failure, List<LeaveBalanceEntity>>
    // results[2] is Either<Failure, LeaveStatisticsEntity>

    // We can extract failures if any
    String? error;
    for (final res in results) {
      final r = res as Either<Failure, dynamic>;
      if (r.isLeft()) {
        error = r.fold((f) => f.message, (_) => null);
        break;
      }
    }

    final typesResult = results[0] as Either<Failure, List<LeaveTypeEntity>>;
    final balanceResult = results[1] as Either<Failure, LeaveBalanceEntity>;
    final statisticsResult = results[2] as Either<Failure, LeaveStatisticsEntity>;

    emit(state.copyWith(
      isLoading: false,
      leaveTypes: typesResult.fold((_) => state.leaveTypes, (types) => types),
      balance: balanceResult.fold((_) => state.balance, (balance) => balance),
      statistics: statisticsResult.fold((_) => state.statistics, (stats) => stats),
      errorMessage: error,
    ));
  }
}
