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
        uploadFileRequested: (path, name, id) async => _onUploadFileRequested(path, name, id, emit),
        clearUploadStatus: () async => emit(state.copyWith(uploadedFileUrl: null, uploadError: null, isUploading: false)),
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
    String filePath,
    String fileName,
    String employeeId,
    Emitter<LeaveState> emit,
  ) async {
    emit(state.copyWith(isUploading: true, uploadError: null, uploadedFileUrl: null));
    final result = await uploadFileUseCase(
      filePath: filePath,
      fileName: fileName,
      employeeId: employeeId,
    );

    result.fold(
      (failure) => emit(state.copyWith(isUploading: false, uploadError: failure.message)),
      (fileUrl) => emit(state.copyWith(isUploading: false, uploadedFileUrl: fileUrl)),
    );
  }
}
