import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/approvals_access_entity.dart';
import '../../domain/entities/approvals_summary_entity.dart';

part 'approvals_state.freezed.dart';

@freezed
class ApprovalsState with _$ApprovalsState {
  const factory ApprovalsState.initial() = Initial;
  const factory ApprovalsState.loading() = Loading;
  const factory ApprovalsState.success({
    required ApprovalsAccessEntity access,
    required ApprovalsSummaryEntity summary,
    @Default([]) List<ApprovalRequestEntity> requests,
    @Default(false) bool isListLoading,
  }) = Success;
  const factory ApprovalsState.failure(String message) = Failure;
}
