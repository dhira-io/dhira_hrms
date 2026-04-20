import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_balance_entity.dart';

part 'leave_balance_model.freezed.dart';
part 'leave_balance_model.g.dart';

@freezed
abstract class LeaveBalanceModel with _$LeaveBalanceModel {
  const factory LeaveBalanceModel({
    @JsonKey(name: 'total_leaves') required int totalAllocated,
    @JsonKey(name: 'leaves_taken') required num used,
    @JsonKey(name: 'leaves_pending_approval') required num pending,
  }) = _LeaveBalanceModel;

  const LeaveBalanceModel._();

  factory LeaveBalanceModel.fromJson(Map<String, dynamic> json) => _$LeaveBalanceModelFromJson(json);

  LeaveBalanceEntity toEntity() {
    return LeaveBalanceEntity(
      totalAllocated: totalAllocated.toInt(),
      used: used.toInt(),
      pending: pending.toInt(),
      available: (totalAllocated - used - pending).toInt(),
    );
  }
}
