import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/approvals_access_entity.dart';
import '../../domain/entities/approvals_summary_entity.dart';
import '../../domain/entities/comment_entity.dart';
import '../../../timesheet/domain/entities/project_entity.dart';
import '../../timesheetapproval/domain/entities/timesheet_approval_entity.dart';

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
    @Default([]) List<CommentEntity> comments,
    @Default(false) bool isCommentsLoading,
    TimesheetApprovalEntity? editingTimesheet,
    @Default(false) bool isTimesheetLoading,
    @Default([]) List<ProjectEntity> projects,
    @Default([]) List<Map<String, dynamic>> employees,
    String? successMessage,
    String? errorMessage,
  }) = Success;
  const factory ApprovalsState.failure(String message) = Failure;
}
