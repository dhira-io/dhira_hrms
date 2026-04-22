import 'package:dhira_hrms/features/leave/domain/entities/leave_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_leave_types_usecase.dart';
import '../../domain/usecases/get_leave_balance_usecase.dart';
import '../../domain/usecases/submit_leave_usecase.dart';
import 'leave_event.dart';
import 'leave_state.dart';
import '../../domain/usecases/update_leave_usecase.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  final GetLeaveTypesUseCase getLeaveTypesUseCase;
  final GetLeaveBalanceUseCase getLeaveBalanceUseCase;
  final SubmitLeaveUseCase submitLeaveUseCase;
  final UpdateLeaveUseCase updateLeaveUseCase;

  LeaveBloc({
    required this.getLeaveTypesUseCase,
    required this.getLeaveBalanceUseCase,
    required this.submitLeaveUseCase,
    required this.updateLeaveUseCase,
  }) : super(const LeaveState()) {
    on<LeaveEvent>((event, emit) async {
      await event.when(
        applyRequested: (id, name, type, from, to, reason, half, halfDayDate, halfDaySegment, total) =>
            _onApplyRequested(id, name, type, from, to, reason, half, halfDayDate, halfDaySegment, total, emit),
        updateRequested: (id, from, to, reason, half, halfDayDate, halfDaySegment, total) =>
            _onUpdateRequested(id, from, to, reason, half, halfDayDate, halfDaySegment, total, emit),
        balanceRequested: (id, date) => _onBalanceRequested(id, date, emit),
        typesRequested: () => _onTypesRequested(emit),
      );
    });
  }

  Future<void> _onTypesRequested(Emitter<LeaveState> emit) async {
    final result = await getLeaveTypesUseCase();
    result.fold(
      (failure) => emit(state.copyWith(errorMessage: failure.message, success: false)),
      (types) => emit(state.copyWith(leaveTypes: types, success: false)),
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
          emit(state.copyWith(isLoading: false, errorMessage: "Update failed"));
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
