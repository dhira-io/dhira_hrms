import 'package:dhira_hrms/core/constants/leave_constants.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/domain/usecases/get_leave_balance_approval_usecase.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/domain/usecases/get_leave_statistics_approval_usecase.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/domain/usecases/get_leave_types_approval_usecase.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/domain/usecases/get_overlap_leaves_approval_usecase.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/domain/usecases/update_leave_approval_usecase.dart';
import 'package:dhira_hrms/features/approvals/leaveapproval/domain/usecases/upload_leave_file_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'leave_approval_event.dart';
import 'leave_approval_state.dart';

class LeaveApprovalBloc extends Bloc<LeaveApprovalEvent, LeaveApprovalState> {
  final GetLeaveTypesApprovalUseCase getLeaveTypesUseCase;
  final GetLeaveBalanceApprovalUseCase getLeaveBalanceUseCase;
  final UpdateLeaveApprovalUseCase updateLeaveUseCase;
  final GetOverlapLeavesApprovalUseCase getOverlapLeavesUseCase;
  final UploadLeaveFileUseCase uploadFileUseCase;
  final GetLeaveStatisticsApprovalUseCase getLeaveStatisticsUseCase;

  LeaveApprovalBloc({
    required this.getLeaveTypesUseCase,
    required this.getLeaveBalanceUseCase,
    required this.updateLeaveUseCase,
    required this.getOverlapLeavesUseCase,
    required this.uploadFileUseCase,
    required this.getLeaveStatisticsUseCase,
  }) : super(LeaveApprovalState.initial()) {
    on<LeaveApprovalEvent>((event, emit) async {
      await event.when(
        updateRequested: (id, empId, empName, type, from, to, reason, half, halfDayDate, halfDaySegment, total, state, attachment) async =>
            _onUpdateRequested(id, empId, empName, type, from, to, reason, half, halfDayDate, halfDaySegment, total, state, attachment, emit),
        balanceRequested: (id, date, gender) async => _onBalanceRequested(id, date, gender, emit),
        typesRequested: () async => _onTypesRequested(emit),
        overlapLeavesRequested: (id, from, to) async => _onOverlapLeavesRequested(id, from, to, emit),
        uploadFileRequested: (path, name) async => _onUploadFileRequested(path, name, emit),
        statisticsRequested: (id, from, to) async => _onStatisticsRequested(id, from, to, emit),
        clearUploadStatus: () async => emit(state.copyWith(uploadedFileUrl: null, uploadError: null, isUploading: false)),
        formInitialized: (id, url) async => emit(state.copyWith(leaveId: id, uploadedFileUrl: url)),
      );
    });
  }

  Future<void> _onTypesRequested(Emitter<LeaveApprovalState> emit) async {
    final result = await getLeaveTypesUseCase();
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message, success: false)),
      (types) => emit(state.copyWith(leaveTypes: types, success: false)),
    );
  }

  Future<void> _onUpdateRequested(
    String leaveId,
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
    String? workflowState,
    String? attachment,
    Emitter<LeaveApprovalState> emit,
  ) async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true, errorMessage: null, success: false));
    final result = await updateLeaveUseCase(
      leaveId: leaveId,
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
      workflowState: workflowState,
      attachment: attachment,
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

  Future<void> _onBalanceRequested(String employeeId, String todayDate, String gender, Emitter<LeaveApprovalState> emit) async {
    final result = await getLeaveBalanceUseCase(employeeId, todayDate, gender);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message, success: false)),
      (balance) => emit(state.copyWith(balance: balance, success: false)),
    );
  }

  Future<void> _onOverlapLeavesRequested(
    String employeeId,
    String fromDate,
    String toDate,
    Emitter<LeaveApprovalState> emit,
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
    Emitter<LeaveApprovalState> emit,
  ) async {
    emit(state.copyWith(isUploading: true, uploadError: null, uploadedFileUrl: null));
    final result = await uploadFileUseCase(
      filePath: filePath,
      fileName: fileName,
      leaveId: state.leaveId,
    );

    result.fold(
      (failure) => emit(state.copyWith(isUploading: false, uploadError: failure.message)),
      (fileUrl) => emit(state.copyWith(isUploading: false, uploadedFileUrl: fileUrl)),
    );
  }

  Future<void> _onStatisticsRequested(
    String employeeId,
    String fromDate,
    String toDate,
    Emitter<LeaveApprovalState> emit,
  ) async {
    final result = await getLeaveStatisticsUseCase(GetLeaveStatisticsParams(
      employeeId: employeeId,
      fromDate: fromDate,
      toDate: toDate,
    ));
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message, success: false)),
      (statistics) => emit(state.copyWith(statistics: statistics, success: false, errorMessage: null)),
    );
  }
}
