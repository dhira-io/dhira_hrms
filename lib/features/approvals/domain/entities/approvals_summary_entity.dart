import 'package:freezed_annotation/freezed_annotation.dart';

part 'approvals_summary_entity.freezed.dart';

@freezed
abstract class ApprovalsSummaryEntity with _$ApprovalsSummaryEntity {
  const factory ApprovalsSummaryEntity({
    required int leaveApprovalsPending,
    required int attendanceRegularizationPending,
    required int timesheetApprovalsPending,
    required int compensatoryLeavePending,
    required int totalAllPending,
  }) = _ApprovalsSummaryEntity;
}
