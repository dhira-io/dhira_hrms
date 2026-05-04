import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import '../../../../core/network/dio_client.dart';
import '../constants/approvals_api_constants.dart';
import '../models/approvals_access_model.dart';
import '../models/approvals_summary_model.dart';
import '../models/approval_request_model.dart';
import '../models/comment_model.dart';
import '../../../../core/services/local_storage_service.dart';

abstract class ApprovalsRemoteDataSource {
  Future<ApprovalsAccessModel> getApprovalsAccess();
  Future<ApprovalsSummaryModel> getApprovalsSummary();
  Future<List<ApprovalRequestModel>> getPendingRequests(ApprovalType type, {required ApprovalCategory category});
  Future<void> addComment(String referenceDoctype, String referenceName, String content);
  Future<void> submitLeaveWorkflowAction(String leaveApplicationName, String action);
  Future<void> submitAttendanceWorkflowAction(String attendanceRequestName, String action);
  Future<void> submitTimesheetWorkflowAction(String timesheetName, String action);
  Future<void> submitCompOffWorkflowAction(String compOffRequestName, String action);
  Future<List<CommentModel>> getComments(String doctype, String requestId);
}

class ApprovalsRemoteDataSourceImpl implements ApprovalsRemoteDataSource {
  final DioClient dioClient;
  final LocalStorageService localStorageService;

  ApprovalsRemoteDataSourceImpl(this.dioClient, this.localStorageService);

  @override
  Future<ApprovalsAccessModel> getApprovalsAccess() async {
    final response = await dioClient.get(ApprovalsApiConstants.canAccessApprovalPage);
    if (response.data['message'] != null) {
      return ApprovalsAccessModel.fromJson(response.data['message']);
    }
    throw Exception("Failed to fetch approvals access data.");
  }

  @override
  Future<ApprovalsSummaryModel> getApprovalsSummary() async {
    final response = await dioClient.get(ApprovalsApiConstants.getAllPendingApprovalsSummary);
    if (response.data['message'] != null) {
      return ApprovalsSummaryResponse.fromJson(response.data['message']).data;
    }
    throw Exception("Failed to fetch approvals summary statistics.");
  }

  @override
  Future<void> addComment(String referenceDoctype, String referenceName, String content) async {
    final commentEmail = localStorageService.getUserEmail() ?? '';
    final commentBy = localStorageService.getUserFullname() ?? '';

    final response = await dioClient.post(
      ApprovalsApiConstants.addComment,
      data: {
        "reference_doctype": referenceDoctype,
        "reference_name": referenceName,
        "content": content,
        "comment_email": commentEmail,
        "comment_by": commentBy,
        "comment_type": "Comment"
      },
    );
    if (response.data == null || response.data['message'] == null) {
      throw Exception("Failed to add comment.");
    }
  }

  @override
  Future<void> submitLeaveWorkflowAction(String leaveApplicationName, String action) async {
    final response = await dioClient.put(
      ApprovalsApiConstants.leaveBulkWorkflowAction,
      data: {
        "leave_application_names": '["$leaveApplicationName"]',
        "action": action,
        "description": action == "Cancel" ? "withdraw" : action
      },
    );
    if (response.data == null) {
      throw Exception("Failed to submit workflow action.");
    }
  }

  @override
  Future<void> submitAttendanceWorkflowAction(String attendanceRequestName, String action) async {
    final response = await dioClient.post(
      ApprovalsApiConstants.attendanceBulkWorkflowApproval,
      data: {
        "docnames": '["$attendanceRequestName"]',
        "doctype": ApprovalsApiConstants.doctypeAttendanceRegularization,
        "action": action
      },
    );
    if (response.data == null) {
      throw Exception("Failed to submit attendance workflow action.");
    }
  }

  @override
  Future<List<ApprovalRequestModel>> getPendingRequests(
      ApprovalType type, {
        required ApprovalCategory category,
      }) async {
    // 1. Select the correct endpoint based on category
    final String endpoint = (category == ApprovalCategory.team)
        ? _getTeamEndpoint(type)
        : _getRaisedEndpoint(type);

    Map<String, dynamic>? queryParameters;

    if (category == ApprovalCategory.team && type == ApprovalType.leave) {
      final now = DateTime.now();
      final startOfYear = "${now.year}-01-01";
      final endOfYear = "${now.year}-12-31";
      queryParameters = {
        'page': 1,
        'page_size': 10,
        'sort_by': 'pending_first',
        'include_workflow_actions': false,
        'from_date': startOfYear,
        'to_date': endOfYear,
      };
    } else if (category == ApprovalCategory.raised) {
      final empId = localStorageService.getEmpId() ?? '';
      final now = DateTime.now();
      final startOfYear = '${now.year}-01-01';
      final endOfYear   = '${now.year}-12-31';

      if (type == ApprovalType.leave) {
        queryParameters = {
          'page': 1,
          'page_size': 10,
          'sort_by': 'date_desc',
          'include_workflow_actions': false,
          'from_date': startOfYear,
          'to_date': endOfYear,
        };
      } else if (type == ApprovalType.attendance) {
        queryParameters = {
          'filters': '[["employee","=","$empId"],["attendance_date","between",["$startOfYear","$endOfYear"]]]',
          'fields': '["*"]'
        };
      } else if (type == ApprovalType.compOff) {
        final startOfYearTs = '${now.year}-01-01 00:00:00';
        final endOfYearTs   = '${now.year}-12-31 23:59:59';

        queryParameters = {
          'fields': '["*"]',
          'filters':
              '[["creation","between",["$startOfYearTs","$endOfYearTs"]],["employee","=","$empId"]]'
        };
      }
    }

    final response = await dioClient.get(endpoint, queryParameters: queryParameters);

    if (response.data != null) {
      List<dynamic> items = [];
      final dynamic msg = response.data['message'];

      // 2. Handle varied JSON response shapes
      if (msg != null) {
        // Standard for 'method/' calls
        if (msg is Map && msg.containsKey('data')) {
          final data = msg['data'];
          if (data is List) items = data;
          else if (data is Map && data.containsKey('leaves')) items = data['leaves'];
        } else if (msg is List) {
          items = msg;
        }
      } else if (response.data['data'] != null && response.data['data'] is List) {
        // Standard for 'resource/' calls
        items = response.data['data'];
      }

      // 3. Map to Model with the formatting logic for dd-MM-yyyy and pluralization
      return items.map((json) => ApprovalRequestModel.fromJson(
        json as Map<String, dynamic>,
        type,
        category,
      )).toList();
    }
    return [];
  }

  String _getTeamEndpoint(ApprovalType type) {
    switch (type) {
      case ApprovalType.leave: return ApprovalsApiConstants.getPendingLeaves;
      case ApprovalType.attendance: return ApprovalsApiConstants.getAttendanceRegularizations;
      case ApprovalType.timesheet: return ApprovalsApiConstants.getTeamTimesheetApprovals;
      case ApprovalType.compOff: return ApprovalsApiConstants.getCompensatoryLeaveRequests;
    }
  }

  String _getRaisedEndpoint(ApprovalType type) {
    switch (type) {
      case ApprovalType.leave: return ApprovalsApiConstants.getMyLeaveApplications;
      case ApprovalType.attendance: return ApprovalsApiConstants.getMyAttendanceRegularizations;
      case ApprovalType.timesheet: return ApprovalsApiConstants.getMyTimesheets;
      case ApprovalType.compOff: return ApprovalsApiConstants.getMyCompOffRequests;
    }
  }

  @override
  Future<void> submitTimesheetWorkflowAction(String timesheetName, String action) async {
    if (action != 'Approve') {
      throw Exception("Reject action is not implemented for Timesheets.");
    }
    
    final response = await dioClient.post(
      ApprovalsApiConstants.timesheetBulkApprove,
      data: {
        "timesheet_names": '["$timesheetName"]',
      },
    );
    if (response.data == null) {
      throw Exception("Failed to submit timesheet workflow action.");
    }
  }

  @override
  Future<void> submitCompOffWorkflowAction(String compOffRequestName, String action) async {
    final response = await dioClient.post(
      ApprovalsApiConstants.attendanceBulkWorkflowApproval, // Reusing the same generic endpoint
      data: {
        "docnames": '["$compOffRequestName"]',
        "doctype": ApprovalsApiConstants.doctypeCompensatoryLeave,
        "action": action
      },
    );
    if (response.data == null) {
      throw Exception("Failed to submit comp-off workflow action.");
    }
  }

  @override
  Future<List<CommentModel>> getComments(String doctype, String requestId) async {
    final queryParams = {
      'fields': '["name","content","comment_type","owner","creation","comment_by"]',
      'filters': '[["reference_doctype","=","$doctype"],["reference_name","=","$requestId"]]',
      'order_by': 'creation desc'
    };

    final response = await dioClient.get(
      ApprovalsApiConstants.commentResource,
      queryParameters: queryParams,
    );

    if (response.data != null && response.data['data'] != null) {
      final List<dynamic> data = response.data['data'];
      return data.map((json) => CommentModel.fromJson(json as Map<String, dynamic>)).toList();
    }
    return [];
  }
}