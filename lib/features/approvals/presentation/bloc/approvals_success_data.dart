import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/approvals_access_entity.dart';
import '../../domain/entities/approvals_summary_entity.dart';
import '../../domain/entities/approval_request_entity.dart';
import '../../domain/entities/comment_entity.dart';
import '../../../timesheet/domain/entities/project_entity.dart';
import '../../timesheetapproval/domain/entities/timesheet_approval_entity.dart';
import '../../domain/entities/approval_type.dart';

part 'approvals_success_data.freezed.dart';

@freezed
class ApprovalsSuccessData with _$ApprovalsSuccessData {
  const factory ApprovalsSuccessData({
    required ApprovalsAccessEntity access,
    required ApprovalsSummaryEntity summary,
    @Default(ApprovalCategory.team) ApprovalCategory category,
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
    @Default(ApprovalCategory.team) ApprovalCategory targetCategory,
    @Default(ApprovalType.leave) ApprovalType type,
    @Default(ApprovalType.leave) ApprovalType targetType,
    @Default({}) Set<String> processingIds,
  }) = _ApprovalsSuccessData;
}
