import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_balance_entity.freezed.dart';

@freezed
abstract class LeaveBalanceEntity with _$LeaveBalanceEntity {
  const factory LeaveBalanceEntity({
    required int totalAllocated,
    required int used,
    required int pending,
    required int available,
  }) = _LeaveBalanceEntity;

  const LeaveBalanceEntity._();
}
