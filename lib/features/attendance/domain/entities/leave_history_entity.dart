import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_history_entity.freezed.dart';

@freezed
abstract class LeaveHistoryEntity with _$LeaveHistoryEntity {
  const factory LeaveHistoryEntity({
    required String name,
    required String employee,
    required String employeeName,
    required String leaveType,
    required String fromDate,
    required String toDate,
    required String status,
    String? leaveApprover,
    required int docstatus,
    String? leaveApproverName,
    required double totalLeaveDays,
  }) = _LeaveHistoryEntity;
}
