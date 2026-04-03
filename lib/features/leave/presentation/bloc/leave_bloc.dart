import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../domain/usecases/get_leaves_usecase.dart';
import '../../domain/usecases/get_leave_types_usecase.dart';
import '../../domain/usecases/get_leave_balance_usecase.dart';
import '../../domain/usecases/submit_leave_usecase.dart';
import '../../domain/usecases/delete_leave_usecase.dart';
import '../../domain/usecases/cancel_leave_usecase.dart';
import 'leave_event.dart';
import 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  final GetLeavesUseCase getLeavesUseCase;
  final GetLeaveTypesUseCase getLeaveTypesUseCase;
  final GetLeaveBalanceUseCase getLeaveBalanceUseCase;
  final SubmitLeaveUseCase submitLeaveUseCase;
  final DeleteLeaveUseCase deleteLeaveUseCase;
  final CancelLeaveUseCase cancelLeaveUseCase;

  int _start = 0;
  final int _length = 10;

  LeaveBloc({
    required this.getLeavesUseCase,
    required this.getLeaveTypesUseCase,
    required this.getLeaveBalanceUseCase,
    required this.submitLeaveUseCase,
    required this.deleteLeaveUseCase,
    required this.cancelLeaveUseCase,
  }) : super(const LeaveState.initial()) {
    on<LeaveEvent>((event, emit) async {
      await event.when(
        started: (id) => _onStarted(id, emit),
        loadMoreRequested: (id) => _onLoadMoreRequested(id, emit),
        applyRequested: (id, type, from, to, reason, half, halfDayDate) => 
            _onApplyRequested(id, type, from, to, reason, half, halfDayDate, emit),
        deleteRequested: (name, id) => _onDeleteRequested(name, id, emit),
        cancelRequested: (name, id) => _onCancelRequested(name, id, emit),
      );
    });
  }

  Future<void> _onStarted(String employeeId, Emitter<LeaveState> emit) async {
    emit(const LeaveState.loading());
    _start = 0;
    
    final typesResult = await getLeaveTypesUseCase();
    final balanceResult = await getLeaveBalanceUseCase(employeeId, DateFormat('yyyy-MM-dd').format(DateTime.now()));
    final leavesResult = await getLeavesUseCase(start: _start, length: _length);

    typesResult.fold(
      (failure) => emit(LeaveState.error(failure.message)),
      (types) {
        balanceResult.fold(
          (failure) => emit(LeaveState.error(failure.message)),
          (balance) {
            leavesResult.fold(
              (failure) => emit(LeaveState.error(failure.message)),
              (leaves) {
                _start += leaves.length;
                emit(LeaveState.loaded(
                  leaves: leaves,
                  leaveTypes: types,
                  balance: balance,
                  hasMore: leaves.length == _length,
                ));
              },
            );
          },
        );
      },
    );
  }

  Future<void> _onLoadMoreRequested(String employeeId, Emitter<LeaveState> emit) async {
    state.maybeWhen(
      loaded: (leaves, types, balance, hasMore, isFetchingMore) async {
        if (isFetchingMore || !hasMore) return;
        
        emit((state as dynamic).copyWith(isFetchingMore: true));
        
        final result = await getLeavesUseCase(start: _start, length: _length);
        result.fold(
          (failure) => emit(LeaveState.error(failure.message)),
          (newLeaves) {
            _start += newLeaves.length;
            emit((state as dynamic).copyWith(
              leaves: [...leaves, ...newLeaves],
              isFetchingMore: false,
              hasMore: newLeaves.length == _length,
            ));
          },
        );
      },
      orElse: () {},
    );
  }

  Future<void> _onApplyRequested(
    String employeeId, 
    String leaveType, 
    String fromDate, 
    String toDate, 
    String reason, 
    int halfDay, 
    String? halfDayDate, 
    Emitter<LeaveState> emit
  ) async {
    emit(const LeaveState.loading());
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
      (failure) => emit(LeaveState.error(failure.message)),
      (success) {
        if (success) {
          emit(const LeaveState.success("Leave applied successfully"));
          add(LeaveEvent.started(employeeId));
        } else {
          emit(const LeaveState.error("Submission failed"));
        }
      },
    );
  }

  Future<void> _onDeleteRequested(String name, String employeeId, Emitter<LeaveState> emit) async {
    emit(const LeaveState.loading());
    final result = await deleteLeaveUseCase(name);
    result.fold(
      (failure) => emit(LeaveState.error(failure.message)),
      (success) {
        emit(const LeaveState.success("Leave deleted successfully"));
        add(LeaveEvent.started(employeeId));
      },
    );
  }

  Future<void> _onCancelRequested(String name, String employeeId, Emitter<LeaveState> emit) async {
    emit(const LeaveState.loading());
    final result = await cancelLeaveUseCase(name);
    result.fold(
      (failure) => emit(LeaveState.error(failure.message)),
      (success) {
        emit(const LeaveState.success("Leave cancelled successfully"));
        add(LeaveEvent.started(employeeId));
      },
    );
  }
}
