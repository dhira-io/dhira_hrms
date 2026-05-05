import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../leave/domain/entities/leave_entities.dart';
import '../../../../leave/domain/entities/overlap_leave_entity.dart';

part 'leave_approval_state.freezed.dart';

@freezed
abstract class LeaveApprovalState with _$LeaveApprovalState {
  const LeaveApprovalState._();

  const factory LeaveApprovalState({
    @Default([]) List<LeaveTypeEntity> leaveTypes,
    @Default(LeaveBalanceEntity(totalAllocated: 0, used: 0, pending: 0, approved: 0, rejected: 0, applied: 0, available: 0)) LeaveBalanceEntity balance,
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default([]) List<OverlapLeaveEntity> overlapLeaves,
    @Default(false) bool loadingOverlap,
    @Default(false) bool success,
    @Default(false) bool isUploading,
    String? uploadedFileUrl,
    String? uploadError,
  }) = _LeaveApprovalState;

  factory LeaveApprovalState.initial() => const LeaveApprovalState();
}
