import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/approvals_summary_entity.dart';

part 'approvals_summary_model.freezed.dart';
part 'approvals_summary_model.g.dart';

@freezed
abstract class ApprovalsSummaryModel with _$ApprovalsSummaryModel {
  const factory ApprovalsSummaryModel({
    @JsonKey(name: 'leave_approvals_pending') required int leaveApprovalsPending,
    @JsonKey(name: 'attendance_regularization_pending') required int attendanceRegularizationPending,
    @JsonKey(name: 'timesheet_approvals_pending') required int timesheetApprovalsPending,
    @JsonKey(name: 'compensatory_leave_pending') required int compensatoryLeavePending,
    @JsonKey(name: 'total_all_pending') required int totalAllPending,
    String? timestamp,
  }) = _ApprovalsSummaryModel;

  const ApprovalsSummaryModel._();

  factory ApprovalsSummaryModel.fromJson(Map<String, dynamic> json) =>
      _$ApprovalsSummaryModelFromJson(json);

  ApprovalsSummaryEntity toEntity() {
    return ApprovalsSummaryEntity(
      leaveApprovalsPending: leaveApprovalsPending,
      attendanceRegularizationPending: attendanceRegularizationPending,
      timesheetApprovalsPending: timesheetApprovalsPending,
      compensatoryLeavePending: compensatoryLeavePending,
      totalAllPending: totalAllPending,
    );
  }
}

@freezed
abstract class ApprovalsSummaryResponse with _$ApprovalsSummaryResponse {
  const factory ApprovalsSummaryResponse({
    required bool success,
    required ApprovalsSummaryModel data,
  }) = _ApprovalsSummaryResponse;

  factory ApprovalsSummaryResponse.fromJson(Map<String, dynamic> json) =>
      _$ApprovalsSummaryResponseFromJson(json);
}
