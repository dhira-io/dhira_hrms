import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/leave_details_entity.dart';

part 'leave_details_model.freezed.dart';
part 'leave_details_model.g.dart';

@freezed
abstract class LeaveDetailsModel with _$LeaveDetailsModel {
  const LeaveDetailsModel._();

  const factory LeaveDetailsModel({
    @JsonKey(name: 'leave_allocation') required Map<String, LeaveAllocationModel> leaveAllocation,
    @JsonKey(name: 'leave_approver') required String leaveApprover,
    required List<String> lwps,
  }) = _LeaveDetailsModel;

  factory LeaveDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveDetailsModelFromJson(json);

  LeaveDetailsEntity toEntity() {
    return LeaveDetailsEntity(
      leaveAllocation: leaveAllocation.map(
        (key, value) => MapEntry(key, value.toEntity()),
      ),
      leaveApprover: leaveApprover,
      lwps: lwps,
    );
  }
}

@freezed
abstract class LeaveAllocationModel with _$LeaveAllocationModel {
  const LeaveAllocationModel._();

  const factory LeaveAllocationModel({
    @JsonKey(name: 'total_leaves') required double totalLeaves,
    @JsonKey(name: 'expired_leaves') required int expiredLeaves,
    @JsonKey(name: 'leaves_taken') required double leavesTaken,
    @JsonKey(name: 'leaves_pending_approval') required double leavesPendingApproval,
    @JsonKey(name: 'remaining_leaves') required double remainingLeaves,
  }) = _LeaveAllocationModel;

  factory LeaveAllocationModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveAllocationModelFromJson(json);

  LeaveAllocationEntity toEntity() {
    return LeaveAllocationEntity(
      totalLeaves: totalLeaves,
      expiredLeaves: expiredLeaves,
      leavesTaken: leavesTaken,
      leavesPendingApproval: leavesPendingApproval,
      remainingLeaves: remainingLeaves,
    );
  }
}
