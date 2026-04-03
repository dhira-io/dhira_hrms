import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/leave_entities.dart';

part 'leave_state.freezed.dart';

@freezed
class LeaveState with _$LeaveState {
  const factory LeaveState.initial() = _Initial;
  const factory LeaveState.loading() = _Loading;
  const factory LeaveState.loaded({
    required List<LeaveEntity> leaves,
    required List<LeaveTypeEntity> leaveTypes,
    required LeaveBalanceEntity balance,
    @Default(false) bool hasMore,
    @Default(false) bool isFetchingMore,
  }) = _Loaded;
  const factory LeaveState.success(String message) = _Success;
  const factory LeaveState.error(String message) = _Error;
}
