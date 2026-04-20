import 'package:dhira_hrms/features/leave/domain/entities/leave_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_leaves_usecase.dart';
import '../../domain/usecases/get_leave_types_usecase.dart';
import '../../domain/usecases/get_leave_balance_usecase.dart';
import '../../domain/usecases/submit_leave_usecase.dart';
import '../../domain/usecases/delete_leave_usecase.dart';
import '../../domain/usecases/cancel_leave_usecase.dart';
import 'leave_event.dart';
import 'leave_state.dart';
import '../../domain/usecases/update_leave_usecase.dart';
import '../../domain/usecases/update_leave_status_usecase.dart';
import 'package:dhira_hrms/core/utils/date_time_utils.dart';
import 'package:dhira_hrms/core/constants/leave_constants.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  final GetLeavesUseCase getLeavesUseCase;
  final GetLeaveTypesUseCase getLeaveTypesUseCase;
  final GetLeaveBalanceUseCase getLeaveBalanceUseCase;
  final SubmitLeaveUseCase submitLeaveUseCase;
  final UpdateLeaveUseCase updateLeaveUseCase;
  final UpdateLeaveStatusUseCase updateLeaveStatusUseCase;
  final DeleteLeaveUseCase deleteLeaveUseCase;
  final CancelLeaveUseCase cancelLeaveUseCase;

  final int _length = 10;

  LeaveBloc({
    required this.getLeavesUseCase,
    required this.getLeaveTypesUseCase,
    required this.getLeaveBalanceUseCase,
    required this.submitLeaveUseCase,
    required this.updateLeaveUseCase,
    required this.updateLeaveStatusUseCase,
    required this.deleteLeaveUseCase,
    required this.cancelLeaveUseCase,
  }) : super(const LeaveState()) {
    on<LeaveEvent>((event, emit) async {
      await event.when(
        started: (id, email) => _onStarted(id, email, emit),
        refreshRequested: (id, email) => _onStarted(id, email, emit),
        loadMoreRequested: (id, email) => _onLoadMoreRequested(id, email, emit),
        searchChanged: (query) => _onSearchChanged(query, emit),
        applyRequested: (id, type, from, to, reason, half, halfDayDate) =>
            _onApplyRequested(id, type, from, to, reason, half, halfDayDate, emit),
        updateRequested: (id, from, to, reason, half, halfDayDate) =>
            _onUpdateRequested(id, from, to, reason, half, halfDayDate, emit),
        statusUpdateRequested: (name, status) => _onStatusUpdateRequested(name, status, emit),
        deleteRequested: (name, id) => _onDeleteRequested(name, id, emit),
        cancelRequested: (name, id) => _onCancelRequested(name, id, emit),
        balanceRequested: (id, date) => _onBalanceRequested(id, date, emit),
      );
    });
  }

  Future<void> _onStarted(String employeeId, String userEmail, Emitter<LeaveState> emit) async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true, errorMessage: null, success: false));

    final typesResult = await getLeaveTypesUseCase();
    final balanceResult = await getLeaveBalanceUseCase(
      employeeId,
      DateTimeUtils.todayDate(),
    );
    final leavesResult = await getLeavesUseCase(start: 0, length: _length);

    typesResult.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message, success: false)),
      (types) {
        balanceResult.fold(
          (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message, success: false)),
          (balance) {
            leavesResult.fold(
              (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message, success: false)),
              (leaves) {
                final processedLeaves = _mapLeavesWithFlags(leaves, employeeId, userEmail);
                emit(state.copyWith(
                  isLoading: false,
                  leaves: processedLeaves,
                  filteredLeaves: processedLeaves,
                  leaveTypes: types,
                  balance: balance,
                  hasMore: leaves.length == _length,
                  currentEmpId: employeeId,
                  userEmail: userEmail,
                  success: false,
                ));
              },
            );
          },
        );
      },
    );
  }

  Future<void> _onLoadMoreRequested(String employeeId, String userEmail, Emitter<LeaveState> emit) async {
    if (state.isFetchingMore || state.isLoading || !state.hasMore) return;

    emit(state.copyWith(isFetchingMore: true, success: false));

    final result = await getLeavesUseCase(start: state.leaves.length, length: _length);
    result.fold(
      (failure) => emit(state.copyWith(isFetchingMore: false, errorMessage: failure.message, success: false)),
      (newLeaves) {
        final processedNewLeaves = _mapLeavesWithFlags(newLeaves, employeeId, userEmail);
        final updatedLeaves = [...state.leaves, ...processedNewLeaves];
        emit(state.copyWith(
          leaves: updatedLeaves,
          filteredLeaves: updatedLeaves.where((l) =>
            l.leaveType.toLowerCase().contains(state.searchQuery.toLowerCase()) ||
            l.employeeName.toLowerCase().contains(state.searchQuery.toLowerCase())
          ).toList(),
          isFetchingMore: false,
          hasMore: newLeaves.length == _length,
          success: false,
        ));
      },
    );
  }

  List<LeaveEntity> _mapLeavesWithFlags(List<LeaveEntity> leaves, String currentEmpId, String userEmail) {
    return leaves.map((leave) {
      final bool isMyLeave = leave.employee == currentEmpId;
      final bool isApprover = leave.leaveApprover?.toLowerCase() == userEmail.toLowerCase();

      // Condition 1: Delete and Edit
      final bool showEditDelete = leave.docstatus == LeaveDocStatus.draft && isMyLeave && leave.status == LeaveStatusConstants.open;

      // Condition 2: Cancel
      final parsedFromDate = DateTime.tryParse(leave.fromDate);
      final bool showCancel = leave.docstatus == LeaveDocStatus.submitted &&
          parsedFromDate != null &&
          parsedFromDate.isAfter(DateTime.now());

      // Condition 3: Reject and Approve
      final bool showApprovalActions = isApprover && leave.docstatus == LeaveDocStatus.draft;

      return leave.copyWith(
        isMyLeave: isMyLeave,
        isApprover: isApprover,
        showEditDelete: showEditDelete,
        showCancel: showCancel,
        showApprovalActions: showApprovalActions,
      );
    }).toList();
  }

  Future<void> _onSearchChanged(String query, Emitter<LeaveState> emit) async {
    final filtered = state.leaves.where((l) =>
      l.leaveType.toLowerCase().contains(query.toLowerCase()) ||
      l.employeeName.toLowerCase().contains(query.toLowerCase())
    ).toList();
    emit(state.copyWith(searchQuery: query, filteredLeaves: filtered));
  }

  Future<void> _onApplyRequested(
    String employeeId,
    String leaveType,
    String fromDate,
    String toDate,
    String reason,
    int halfDay,
    String? halfDayDate,
    Emitter<LeaveState> emit,
  ) async {
    if (state.isLoading) return;
    emit(state.copyWith(isLoading: true, errorMessage: null, success: false));
    final result = await submitLeaveUseCase(
      employeeId: employeeId,
      leaveType: leaveType,
      fromDate: fromDate,
      toDate: toDate,
      reason: reason,
      halfDay: halfDay,
      halfDayDate: halfDayDate,
    );

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (success) {
        if (success) {
          emit(state.copyWith(isLoading: false, success: true));
        } else {
          emit(state.copyWith(isLoading: false, errorMessage: "Submission failed"));
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
    );

    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (success) {
        if (success) {
          emit(state.copyWith(isLoading: false, success: true));
        } else {
          emit(state.copyWith(isLoading: false, errorMessage: "Update failed"));
        }
      },
    );
  }

  Future<void> _onStatusUpdateRequested(
    String name,
    String status,
    Emitter<LeaveState> emit,
  ) async {
    if (state.isUpdatingStatus) return;
    emit(state.copyWith(isUpdatingStatus: true, errorMessage: null, success: false));
    final result = await updateLeaveStatusUseCase(
      UpdateLeaveStatusParams(leaveApplicationName: name, newStatus: status),
    );

    result.fold(
      (failure) => emit(state.copyWith(isUpdatingStatus: false, errorMessage: failure.message)),
      (success) {
        if (success) {
          emit(state.copyWith(isUpdatingStatus: false, success: true));
        } else {
          emit(state.copyWith(isUpdatingStatus: false, errorMessage: "Status update failed"));
        }
      },
    );
  }

  Future<void> _onDeleteRequested(String name, String employeeId, Emitter<LeaveState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, success: false));
    final result = await deleteLeaveUseCase(name);
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (success) {
        if (success) {
          emit(state.copyWith(isLoading: false, success: true));
        } else {
          emit(state.copyWith(isLoading: false, errorMessage: "Deletion failed"));
        }
      },
    );
  }

  Future<void> _onCancelRequested(String name, String employeeId, Emitter<LeaveState> emit) async {
    emit(state.copyWith(isLoading: true, errorMessage: null, success: false));
    final result = await cancelLeaveUseCase(name);
    result.fold(
      (failure) => emit(state.copyWith(isLoading: false, errorMessage: failure.message)),
      (success) {
        if (success) {
          emit(state.copyWith(isLoading: false, success: true));
        } else {
          emit(state.copyWith(isLoading: false, errorMessage: "Cancellation failed"));
        }
      },
    );
  }

  Future<void> _onBalanceRequested(String employeeId, String todayDate, Emitter<LeaveState> emit) async {
    final result = await getLeaveBalanceUseCase(employeeId, todayDate);
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message, success: false)),
      (balance) => emit(state.copyWith(balance: balance, success: false)),
    );
  }
}
