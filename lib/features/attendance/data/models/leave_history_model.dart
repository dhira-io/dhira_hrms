import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/leave_history_entity.dart';

part 'leave_history_model.freezed.dart';
part 'leave_history_model.g.dart';

@freezed
abstract class LeaveHistoryModel with _$LeaveHistoryModel {
  const LeaveHistoryModel._();

  const factory LeaveHistoryModel({
    required String name,
    required String employee,
    @JsonKey(name: 'employee_name') required String employeeName,
    @JsonKey(name: 'leave_type') required String leaveType,
    @JsonKey(name: 'from_date') required String fromDate,
    @JsonKey(name: 'to_date') required String toDate,
    required String status,
    @JsonKey(name: 'leave_approver') String? leaveApprover,
    required int docstatus,
    @JsonKey(name: 'leave_approver_name') String? leaveApproverName,
    @JsonKey(name: 'total_leave_days') required double totalLeaveDays,
  }) = _LeaveHistoryModel;

  factory LeaveHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$LeaveHistoryModelFromJson(json);

  LeaveHistoryEntity toEntity() {
    return LeaveHistoryEntity(
      name: name,
      employee: employee,
      employeeName: employeeName,
      leaveType: leaveType,
      fromDate: fromDate,
      toDate: toDate,
      status: status,
      leaveApprover: leaveApprover,
      docstatus: docstatus,
      leaveApproverName: leaveApproverName,
      totalLeaveDays: totalLeaveDays,
    );
  }
}
