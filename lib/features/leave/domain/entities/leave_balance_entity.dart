import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_balance_entity.freezed.dart';

@freezed
abstract class LeaveBalanceEntity with _$LeaveBalanceEntity {
  const factory LeaveBalanceEntity({
    required num totalAllocated,
    required num used,
    required num pending,
    required num approved,
    required num rejected,
    required num applied,
    required num available,
    @Default([]) List<LeaveDetailedBalanceEntity> details,
  }) = _LeaveBalanceEntity;

  const LeaveBalanceEntity._();

  double get calculatedTotalAvailable => details.fold(0.0, (sum, detail) => sum + detail.available);
  double get calculatedTotalAllocated => details.fold(0.0, (sum, detail) => sum + detail.allocated);
}

@freezed
abstract class LeaveDetailedBalanceEntity with _$LeaveDetailedBalanceEntity {
  const factory LeaveDetailedBalanceEntity({
    required String leaveType,
    required double allocated,
    required double used,
    required double pending,
    required double available,
  }) = _LeaveDetailedBalanceEntity;

  const LeaveDetailedBalanceEntity._();
}
