// lib/features/approvals/presentation/bloc/approvals_event.dart
import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/approval_type.dart';

part 'approvals_event.freezed.dart';

// lib/features/approvals/presentation/bloc/approvals_event.dart

@freezed
class ApprovalsEvent with _$ApprovalsEvent {
  const factory ApprovalsEvent.started() = Started;

  // Update this line to include ApprovalCategory
  const factory ApprovalsEvent.categoryChanged(
      ApprovalType type,
      ApprovalCategory category,
      ) = CategoryChanged;

  const factory ApprovalsEvent.refreshSummary() = RefreshSummary;

  const factory ApprovalsEvent.workflowActionSubmitted({
    required String requestId,
    required String action,
    required ApprovalType type,
    required ApprovalCategory category,
  }) = WorkflowActionSubmitted;

  const factory ApprovalsEvent.commentSubmitted({
    required String requestId,
    required String comment,
    required ApprovalType type,
  }) = CommentSubmitted;

  const factory ApprovalsEvent.commentsRequested({
    required String requestId,
    required String doctype,
  }) = CommentsRequested;

  const factory ApprovalsEvent.editTimesheetRequested({
    required String requestId,
  }) = EditTimesheetRequested;

  const factory ApprovalsEvent.updateTimesheetRequested({
    required Map<String, dynamic> payload,
  }) = UpdateTimesheetRequested;

  const factory ApprovalsEvent.deleteTimesheetRequested({
    required String requestId,
  }) = DeleteTimesheetRequested;
}