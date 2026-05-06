import 'package:dhira_hrms/core/network/dio_client.dart';
import 'package:dhira_hrms/core/services/local_storage_service.dart';
import 'package:dhira_hrms/features/leave/data/models/leave_models.dart';
import 'package:dhira_hrms/features/leave/data/models/leave_statistics_model.dart';
import 'package:dhira_hrms/features/leave/data/models/overlap_leave_model.dart';
import '../constants/leave_approval_api_constants.dart';
import '../../../data/models/approval_request_model.dart';
import '../../../domain/entities/approval_type.dart';
import '../../../domain/entities/approval_request_entity.dart';
import '../../../data/models/comment_model.dart';
import 'package:dhira_hrms/features/leave/data/constants/leave_api_constants.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:path/path.dart' as path_pkg;

abstract class LeaveApprovalRemoteDataSource {
  Future<List<ApprovalRequestModel>> getPendingLeaves(ApprovalCategory category);
  Future<void> submitLeaveWorkflowAction(String leaveApplicationName, String action);
  Future<void> addComment(String referenceDoctype, String referenceName, String content);
  Future<List<CommentModel>> getComments(String doctype, String requestId);
  
  // Leave Management methods
  Future<List<LeaveTypeModel>> fetchLeaveTypes();
  Future<bool> updateLeaveApplication({
    required String leaveId,
    String? employeeId,
    String? employeeName,
    String? leaveType,
    required String fromDate,
    required String toDate,
    required String reason,
    required int halfDay,
    String? halfDayDate,
    String? halfDaySegment,
    double? totalleavedays,
    String? workflowState,
  });
  Future<LeaveBalanceModel> getLeaveBalance(String employeeId, String todayDate, String gender);
  Future<LeaveStatisticsModel> getLeaveStatistics(String employeeId, String fromDate, String toDate);
  Future<List<OverlapLeaveModel>> getOverlapLeaves(String employeeId, String fromDate, String toDate);
  Future<String> uploadFile(String filePath, String fileName, String employeeId);
}

class LeaveApprovalRemoteDataSourceImpl implements LeaveApprovalRemoteDataSource {
  final DioClient dioClient;
  final LocalStorageService localStorageService;

  LeaveApprovalRemoteDataSourceImpl(this.dioClient, this.localStorageService);

  @override
  Future<List<ApprovalRequestModel>> getPendingLeaves(ApprovalCategory category) async {
    final String endpoint = (category == ApprovalCategory.team)
        ? LeaveApprovalApiConstants.getPendingLeaves
        : LeaveApprovalApiConstants.getMyLeaveApplications;

    Map<String, dynamic>? queryParameters;
    final now = DateTime.now();
    final startOfYear = "${now.year}-01-01";
    final endOfYear = "${now.year}-12-31";

    if (category == ApprovalCategory.team) {
      queryParameters = {
        'page': 1,
        'page_size': 10,
        'sort_by': 'pending_first',
        'include_workflow_actions': false,
        'from_date': startOfYear,
        'to_date': endOfYear,
      };
    } else {
      queryParameters = {
        'page': 1,
        'page_size': 10,
        'sort_by': 'date_desc',
        'include_workflow_actions': false,
        'from_date': startOfYear,
        'to_date': endOfYear,
      };
    }

    final response = await dioClient.get(endpoint, queryParameters: queryParameters);

    if (response.data != null) {
      List<dynamic> items = [];
      final dynamic msg = response.data['message'];

      if (msg != null) {
        if (msg is Map && msg.containsKey('data')) {
          final data = msg['data'];
          if (data is List) items = data;
          else if (data is Map && data.containsKey('leaves')) items = data['leaves'];
        } else if (msg is List) {
          items = msg;
        }
      } else if (response.data['data'] != null && response.data['data'] is List) {
        items = response.data['data'];
      }

      return items.map((json) => ApprovalRequestModel.fromJson(
        json as Map<String, dynamic>,
        ApprovalType.leave,
        category,
      )).toList();
    }
    return [];
  }

  @override
  Future<void> submitLeaveWorkflowAction(String leaveApplicationName, String action) async {
    final response = await dioClient.put(
      LeaveApprovalApiConstants.leaveBulkWorkflowAction,
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
  Future<void> addComment(String referenceDoctype, String referenceName, String content) async {
    final commentEmail = localStorageService.getUserEmail() ?? '';
    final commentBy = localStorageService.getUserFullname() ?? '';
    final wrappedContent = '<div class="ql-editor read-mode"><p>$content</p></div>';

    final response = await dioClient.post(
      LeaveApprovalApiConstants.addComment,
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
  Future<List<CommentModel>> getComments(String doctype, String requestId) async {
    final queryParams = {
      'fields': '["name","content","comment_type","owner","creation","comment_by"]',
      'filters': '[["reference_doctype","=","$doctype"],["reference_name","=","$requestId"]]',
      'order_by': 'creation desc'
    };

    final response = await dioClient.get(
      LeaveApprovalApiConstants.commentResource,
      queryParameters: queryParams,
    );

    if (response.data != null && response.data['data'] != null) {
      final List<dynamic> data = response.data['data'];
      return data.map((json) => CommentModel.fromJson(json as Map<String, dynamic>)).toList();
    }
    return [];
  }

  @override
  Future<List<LeaveTypeModel>> fetchLeaveTypes() async {
    final response = await dioClient.get(LeaveApiConstants.leaveType, queryParameters: {
      'fields': '["name", "leave_type_name"]',
    });
    if (response.data != null && response.data['data'] != null) {
      final List<dynamic> data = response.data['data'];
      return data.map((json) => LeaveTypeModel.fromJson(json as Map<String, dynamic>)).toList();
    }
    return [];
  }

  @override
  Future<bool> updateLeaveApplication({
    required String leaveId,
    String? employeeId,
    String? employeeName,
    String? leaveType,
    required String fromDate,
    required String toDate,
    required String reason,
    required int halfDay,
    String? halfDayDate,
    String? halfDaySegment,
    double? totalleavedays,
    String? workflowState,
  }) async {
    final response = await dioClient.post(
      LeaveApiConstants.updateLeave,
      data: {
        "leave_id": leaveId,
        "employee_id": employeeId,
        "employee_name": employeeName,
        "leave_type": leaveType,
        "from_date": fromDate,
        "to_date": toDate,
        "reason": reason,
        "half_day": halfDay,
        "half_day_date": halfDayDate,
        "half_day_segment": halfDaySegment,
        "total_leave_days": totalleavedays,
        "workflow_state": workflowState,
      },
    );
    return response.data != null && response.data['message'] == "Success";
  }

  @override
  Future<LeaveBalanceModel> getLeaveBalance(String employeeId, String todayDate, String gender) async {
    final response = await dioClient.get(
      LeaveApiConstants.getLeaveBalance,
      queryParameters: {
        'employee': employeeId,
        'date': todayDate,
      },
    );
    if (response.data != null && response.data['message'] != null) {
      return LeaveBalanceModel.fromJson(response.data['message'] as Map<String, dynamic>);
    }
    throw Exception("Failed to fetch leave balance");
  }

  @override
  Future<LeaveStatisticsModel> getLeaveStatistics(String employeeId, String fromDate, String toDate) async {
    final response = await dioClient.get(
      LeaveApiConstants.getLeaveStatistics,
      queryParameters: {
        'employee': employeeId,
        'from_date': fromDate,
        'to_date': toDate,
      },
    );
    if (response.data != null && response.data['message'] != null) {
      return LeaveStatisticsModel.fromJson(response.data['message'] as Map<String, dynamic>);
    }
    throw Exception("Failed to fetch leave statistics");
  }

  @override
  Future<List<OverlapLeaveModel>> getOverlapLeaves(String employeeId, String fromDate, String toDate) async {
    final response = await dioClient.get(
      LeaveApiConstants.getApprovedLeavesSameProject,
      queryParameters: {
        'employee': employeeId,
        'from_date': fromDate,
        'to_date': toDate,
      },
    );
    if (response.data != null && response.data['message'] != null) {
      final List<dynamic> data = response.data['message'];
      return data.map((json) => OverlapLeaveModel.fromJson(json as Map<String, dynamic>)).toList();
    }
    return [];
  }

  @override
  Future<String> uploadFile(String filePath, String fileName, String employeeId) async {
    final file = File(filePath);
    final formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(filePath, filename: fileName),
      "docname": employeeId,
      "doctype": "Employee",
      "is_private": 1,
      "folder": "Home/Attachments"
    });

    final response = await dioClient.post(LeaveApiConstants.uploadFile, data: formData);
    if (response.data != null && response.data['message'] != null) {
      return response.data['message']['file_url'] as String;
    }
    throw Exception("Failed to upload file");
  }
}
