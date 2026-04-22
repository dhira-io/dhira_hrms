import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/leave_entities.dart';

part 'leave_state.freezed.dart';

@freezed
abstract class LeaveState with _$LeaveState {
  const LeaveState._();

  const factory LeaveState({
    @Default([]) List<LeaveTypeEntity> leaveTypes,
    @Default(LeaveBalanceEntity(totalAllocated: 0, used: 0, pending: 0, approved: 0, rejected: 0, applied: 0, available: 0)) LeaveBalanceEntity balance,
    LeaveStatisticsEntity? statistics,
    @Default(false) bool isLoading,
    @Default('') String currentEmpId,
    @Default('') String userEmail,
    String? errorMessage,
    @Default(false) bool success,
  }) = _LeaveState;
}
