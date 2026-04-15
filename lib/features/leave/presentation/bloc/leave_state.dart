import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/leave_entities.dart';

part 'leave_state.freezed.dart';

@freezed
abstract class LeaveState with _$LeaveState {
  const LeaveState._();

  const factory LeaveState({
    @Default([]) List<LeaveEntity> leaves,
    @Default([]) List<LeaveEntity> filteredLeaves,
    @Default([]) List<LeaveTypeEntity> leaveTypes,
    @Default(LeaveBalanceEntity(totalAllocated: 0, used: 0, pending: 0, available: 0)) LeaveBalanceEntity balance,
    @Default(false) bool isLoading,
    @Default(false) bool isFetchingMore,
    @Default(true) bool hasMore,
    @Default('') String searchQuery,
    String? errorMessage,
    @Default(false) bool success,
    @Default(false) bool isUpdatingStatus,
  }) = _LeaveState;
}
