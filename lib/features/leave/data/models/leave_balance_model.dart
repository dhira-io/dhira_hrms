import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dhira_hrms/features/leave/domain/entities/leave_balance_entity.dart';

part 'leave_balance_model.freezed.dart';
part 'leave_balance_model.g.dart';

@freezed
abstract class LeaveBalanceModel with _$LeaveBalanceModel {
  const factory LeaveBalanceModel({
    @JsonKey(name: 'total_leaves') required num totalAllocated,
    @JsonKey(name: 'leaves_taken') required num used,
    @JsonKey(name: 'leaves_pending_approval') required num pending,
    @Default(0) num approved,
    @Default(0) num rejected,
    @Default(0) num applied,
    @Default([]) List<DetailedBalanceModel> details,
  }) = _LeaveBalanceModel;

  const LeaveBalanceModel._();

  factory LeaveBalanceModel.fromJson(Map<String, dynamic> json) => _$LeaveBalanceModelFromJson(json);

  LeaveBalanceEntity toEntity() {
    return LeaveBalanceEntity(
      totalAllocated: totalAllocated,
      used: used,
      pending: pending,
      approved: approved,
      rejected: rejected,
      applied: applied,
      available: totalAllocated - used - pending,
      details: details.map((e) => e.toEntity()).toList(),
    );
  }
}

@freezed
abstract class DetailedBalanceModel with _$DetailedBalanceModel {
  const factory DetailedBalanceModel({
    required String leaveType,
    required double allocated,
    required double used,
    required double pending,
  }) = _DetailedBalanceModel;

  const DetailedBalanceModel._();

  factory DetailedBalanceModel.fromJson(Map<String, dynamic> json) => _$DetailedBalanceModelFromJson(json);

  LeaveDetailedBalanceEntity toEntity() {
    return LeaveDetailedBalanceEntity(
      leaveType: leaveType,
      allocated: allocated,
      used: used,
      pending: pending,
      available: allocated - used - pending,
    );
  }
}
