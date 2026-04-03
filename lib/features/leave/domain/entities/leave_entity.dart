import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_entity.freezed.dart';

@freezed
abstract class LeaveEntity with _$LeaveEntity {
  const factory LeaveEntity({
    required String name,
    required String employee,
    required String employeeName,
    required String leaveType,
    required String fromDate,
    required String toDate,
    required String status,
    String? leaveApprover,
    int? docstatus,
    String? leaveApproverName,
    double? totalLeaveDays,
  }) = _LeaveEntity;

  const LeaveEntity._();
}
