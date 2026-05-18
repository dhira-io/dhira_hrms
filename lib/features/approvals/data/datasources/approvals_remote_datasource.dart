import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import '../../../../core/network/dio_client.dart';
import '../constants/approvals_api_constants.dart';
import '../models/approvals_access_model.dart';
import '../models/approvals_summary_model.dart';
import '../models/approval_request_model.dart';
import '../models/comment_model.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../leaveapproval/data/datasources/leave_approval_remote_datasource.dart';
import '../../timesheetapproval/data/datasources/timesheet_approval_remote_datasource.dart';

abstract class ApprovalsRemoteDataSource {
  Future<ApprovalsAccessModel> getApprovalsAccess();
  Future<ApprovalsSummaryModel> getApprovalsSummary();
  Future<List<ApprovalRequestModel>> getPendingRequests(ApprovalType type, {required ApprovalCategory category, int page = 1, int pageSize = 10});
  Future<void> addComment(String referenceDoctype, String referenceName, String content);
  Future<String> submitLeaveWorkflowAction(String leaveApplicationName, String action);
  Future<String> submitAttendanceWorkflowAction(String attendanceRequestName, String action);
  Future<String> submitTimesheetWorkflowAction(String timesheetName, String action);
  Future<String> submitCompOffWorkflowAction(String compOffRequestName, String action);
  Future<List<CommentModel>> getComments(String doctype, String requestId);
}

class ApprovalsRemoteDataSourceImpl implements ApprovalsRemoteDataSource {
  final DioClient dioClient;
  final LocalStorageService localStorageService;
  final LeaveApprovalRemoteDataSource leaveApprovalRemoteDataSource;
  final TimesheetApprovalRemoteDataSource timesheetApprovalRemoteDataSource;

  ApprovalsRemoteDataSourceImpl(
    this.dioClient,
    this.localStorageService,
    this.leaveApprovalRemoteDataSource,
    this.timesheetApprovalRemoteDataSource,
  );

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
    final wrappedContent = '<div class="ql-editor read-mode"><p>$content</p></div>';

    final response = await dioClient.post(
      ApprovalsApiConstants.addComment,
      data: {
        "reference_doctype": referenceDoctype,
        "reference_name": referenceName,
        "content": wrappedContent,
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
  Future<String> submitLeaveWorkflowAction(String leaveApplicationName, String action) async {
    return await leaveApprovalRemoteDataSource.submitLeaveWorkflowAction(leaveApplicationName, action);
  }

  @override
  Future<String> submitAttendanceWorkflowAction(String attendanceRequestName, String action) async {
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

    final data = response.data;
    if (data.containsKey('_error_message')) {
      final errorMsg = data['_error_message'].toString().replaceAll(RegExp(r'<[^>]*>'), '');
      throw ServerException(message: errorMsg);
    }

    final dynamic messageData = data['message'];
    if (messageData is Map) {
      final msg = messageData['message'] ?? messageData['msg'];
      if (msg != null) return msg.toString();
    }
    if (messageData != null) return messageData.toString();
    
    return "your changes saved successfully";
  }

  @override
  Future<List<ApprovalRequestModel>> getPendingRequests(
      ApprovalType type, {
        required ApprovalCategory category,
        int page = 1,
        int pageSize = 10,
      }) async {
    
    // Delegation for Leave
    if (type == ApprovalType.leave) {
      return await leaveApprovalRemoteDataSource.getPendingLeaves(category, page: page, pageSize: pageSize);
    }
    
    // Delegation for Timesheet
    if (type == ApprovalType.timesheet) {
       return await timesheetApprovalRemoteDataSource.getPendingTimesheets(category, page: page, pageSize: pageSize);
    }
    
    final String endpoint = (category == ApprovalCategory.team)
        ? _getTeamEndpoint(type)
        : _getRaisedEndpoint(type);

    Map<String, dynamic>? queryParameters;

    final now = DateTime.now();
    final startOfYear = '${now.year}-01-01';
    final endOfYear   = '${now.year}-12-31';

    if (category == ApprovalCategory.team) {
      if (type == ApprovalType.attendance || type == ApprovalType.compOff) {
        queryParameters = {
          'page': page,
          'page_size': 100, // Matching working manual test
          'from_date': startOfYear,
          'to_date': endOfYear,
        };
      }
    } else if (category == ApprovalCategory.raised) {
      final empId = localStorageService.getEmpId() ?? '';

      if (type == ApprovalType.attendance) {
        queryParameters = {
          'filters': '[["employee","=","$empId"],["attendance_date","between",["$startOfYear","$endOfYear"]]]',
          'fields': '["*"]'
        };
      } else if (type == ApprovalType.compOff) {
        final startOfYearTs = '$startOfYear 00:00:00';
        final endOfYearTs   = '$endOfYear 23:59:59';

        queryParameters = {
          'fields': '["*"]',
          'filters':
              '[["creation","between",["$startOfYearTs","$endOfYearTs"]],["employee","=","$empId"]]'
        };
      }
    }

    queryParameters ??= {};
    
    // Use page/page_size for method-based endpoints, and limit_start/limit_page_length for resource-based ones.
    if (category == ApprovalCategory.team && (type == ApprovalType.attendance || type == ApprovalType.compOff)) {
      // already set page and page_size above
    } else {
      queryParameters['limit_start'] = (page - 1) * pageSize;
      queryParameters['limit_page_length'] = pageSize;
    }

    final response = await dioClient.get(endpoint, queryParameters: queryParameters);

    if (response.data != null) {
      List<dynamic> items = [];
      final dynamic msg = response.data['message'];

      if (msg != null) {
        if (msg is Map && msg.containsKey('data')) {
          final data = msg['data'];
          if (data is List) items = data;
        } else if (msg is List) {
          items = msg;
        }
      } else if (response.data['data'] != null && response.data['data'] is List) {
        items = response.data['data'];
      }

      return items
          .whereType<Map<String, dynamic>>()
          .map((json) => ApprovalRequestModel.fromJson(
                json,
                type,
                category,
              ))
          .toList();
    }
    return [];
  }

  String _getTeamEndpoint(ApprovalType type) {
    switch (type) {
      case ApprovalType.attendance: return ApprovalsApiConstants.getAttendanceRegularizations;
      case ApprovalType.compOff: return ApprovalsApiConstants.getCompensatoryLeaveRequests;
      default: throw Exception("Unsupported type for Team Endpoint: $type");
    }
  }

  String _getRaisedEndpoint(ApprovalType type) {
    switch (type) {
      case ApprovalType.attendance: return ApprovalsApiConstants.getMyAttendanceRegularizations;
      case ApprovalType.compOff: return ApprovalsApiConstants.getMyCompOffRequests;
      default: throw Exception("Unsupported type for Raised Endpoint: $type");
    }
  }

  @override
  Future<String> submitTimesheetWorkflowAction(String timesheetName, String action) async {
    return await timesheetApprovalRemoteDataSource.submitTimesheetWorkflowAction(timesheetName, action);
  }

  @override
  Future<String> submitCompOffWorkflowAction(String compOffRequestName, String action) async {
    final response = await dioClient.post(
      ApprovalsApiConstants.attendanceBulkWorkflowApproval,
      data: {
        "docnames": '["$compOffRequestName"]',
        "doctype": ApprovalsApiConstants.doctypeCompensatoryLeave,
        "action": action
      },
    );
    if (response.data == null) {
      throw Exception("Failed to submit comp-off workflow action.");
    }

    final data = response.data;
    if (data is Map<String, dynamic> && data.containsKey('_error_message')) {
      final errorMsg = data['_error_message'].toString().replaceAll(RegExp(r'<[^>]*>'), '');
      throw ServerException(message: errorMsg);
    }

    final dynamic messageData = data['message'];
    if (messageData is Map) {
      final msg = messageData['message'] ?? messageData['msg'];
      if (msg != null) return msg.toString();
    }
    if (messageData != null) return messageData.toString();

    return "your changes saved successfully";
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