import 'package:freezed_annotation/freezed_annotation.dart';

part 'leave_approval_event.freezed.dart';

@freezed
abstract class LeaveApprovalEvent with _$LeaveApprovalEvent {
  const LeaveApprovalEvent._();

  const factory LeaveApprovalEvent.updateRequested({
    required String leaveId,
    required String employeeId,
    required String employeeName,
    required String leaveType,
    required String fromDate,
    required String toDate,
    required String reason,
    required int halfDay,
    String? halfDayDate,
    String? halfDaySegment,
    double? totalleavedays,
    String? workflowState,
  }) = _UpdateRequested;

  const factory LeaveApprovalEvent.typesRequested() = _TypesRequested;
  
  const factory LeaveApprovalEvent.balanceRequested({
    required String employeeId, 
    required String todayDate, 
    required String gender,
  }) = _BalanceRequested;

  const factory LeaveApprovalEvent.overlapLeavesRequested({
    required String employeeId,
    required String fromDate,
    required String toDate,
  }) = _OverlapLeavesRequested;

  const factory LeaveApprovalEvent.uploadFileRequested({
    required String filePath,
    required String fileName,
    required String employeeId,
  }) = _UploadFileRequested;

  const factory LeaveApprovalEvent.clearUploadStatus() = _ClearUploadStatus;
}
