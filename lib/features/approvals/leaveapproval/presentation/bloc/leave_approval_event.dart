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
    String? attachment,
  }) = UpdateRequested;

  const factory LeaveApprovalEvent.typesRequested() = TypesRequested;

  const factory LeaveApprovalEvent.balanceRequested({
    required String employeeId,
    required String todayDate,
    required String gender,
  }) = BalanceRequested;

  const factory LeaveApprovalEvent.overlapLeavesRequested({
    required String employeeId,
    required String fromDate,
    required String toDate,
  }) = OverlapLeavesRequested;

  const factory LeaveApprovalEvent.uploadFileRequested({
    required String filePath,
    required String fileName,
  }) = UploadFileRequested;

  const factory LeaveApprovalEvent.statisticsRequested({
    required String employeeId,
    required String fromDate,
    required String toDate,
  }) = StatisticsRequested;

  const factory LeaveApprovalEvent.clearUploadStatus() = ClearUploadStatus;

  const factory LeaveApprovalEvent.formInitialized({
    required String? leaveId,
    required String? fileUrl,
  }) = FormInitialized;
}
