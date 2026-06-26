import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/approvals_access_entity.dart';
import '../../domain/entities/approvals_summary_entity.dart';
import '../../domain/entities/approval_request_entity.dart';
import '../../domain/entities/comment_entity.dart';
import '../../../timesheet/domain/entities/project_entity.dart';
import '../../timesheetapproval/domain/entities/timesheet_approval_entity.dart';
import '../../domain/entities/approval_type.dart';
import '../../../../core/constants/app_constants.dart';

part 'approvals_success_data.freezed.dart';

@freezed
class ApprovalsSuccessData with _$ApprovalsSuccessData {
  const ApprovalsSuccessData._(); // Added for getter

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
    @Default(1) int page,
    @Default(true) bool hasMore,
    @Default(false) bool isLoadMoreLoading,
    @Default('') String searchQuery,
    @Default(ApprovalStatus.pending) String statusFilter,
    @Default(<String>{}) Set<String> selectedRequestIds,
    @Default(false) bool isBulkActionLoading,
  }) = _ApprovalsSuccessData;

  List<ApprovalRequestEntity> get filteredRequests {
    return requests.where((request) {
      // Filter by Status
      bool matchesStatus = true;
      if (statusFilter != ApprovalStatus.allRequests) {
        matchesStatus = request.status.toLowerCase().contains(statusFilter.toLowerCase());
      }

      // Filter by Search Query
      bool matchesSearch = true;
      if (searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        matchesSearch = request.employeeName.toLowerCase().contains(query) ||
            request.id.toLowerCase().contains(query);
            
        // If not found in name or ID, check if it matches any visible details (like dates, leave types)
        if (!matchesSearch) {
          for (final value in request.displayDetails.values) {
            if (value.toLowerCase().contains(query)) {
              matchesSearch = true;
              break;
            }
          }
        }
      }

      return matchesStatus && matchesSearch;
    }).toList();
  }
}
