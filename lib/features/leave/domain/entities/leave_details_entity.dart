import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_details_entity.freezed.dart';

@freezed
abstract class LeaveDetailsEntity with _$LeaveDetailsEntity {
  const factory LeaveDetailsEntity({
    required Map<String, LeaveAllocationEntity> leaveAllocation,
    required String leaveApprover,
    required List<String> lwps,
  }) = _LeaveDetailsEntity;
}

@freezed
abstract class LeaveAllocationEntity with _$LeaveAllocationEntity {
  const factory LeaveAllocationEntity({
    required double totalLeaves,
    required int expiredLeaves,
    required double leavesTaken,
    required double leavesPendingApproval,
    required double remainingLeaves,
  }) = _LeaveAllocationEntity;
}
