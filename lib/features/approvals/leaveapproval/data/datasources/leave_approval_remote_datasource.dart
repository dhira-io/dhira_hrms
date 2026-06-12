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
import 'dart:convert';
import '../../../../../core/error/exceptions.dart';
import 'package:dhira_hrms/core/constants/leave_constants.dart';

abstract class LeaveApprovalRemoteDataSource {
  Future<List<ApprovalRequestModel>> getPendingLeaves(
    ApprovalCategory category, {
    int page = 1,
    int pageSize = 10,
  });
  Future<String> submitLeaveWorkflowAction(
    String leaveApplicationName,
    String action,
  );
  Future<void> addComment(
    String referenceDoctype,
    String referenceName,
    String content,
  );
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
    String? attachment,
  });
  Future<LeaveBalanceModel> getLeaveBalance(
    String employeeId,
    String todayDate,
    String gender,
  );
  Future<LeaveStatisticsModel> getLeaveStatistics(
    String employeeId,
    String fromDate,
    String toDate,
  );
  Future<List<OverlapLeaveModel>> getOverlapLeaves(
    String employeeId,
    String fromDate,
    String toDate,
  );
  Future<String> uploadFile(String filePath, String fileName, String? leaveId);
}

class LeaveApprovalRemoteDataSourceImpl
    implements LeaveApprovalRemoteDataSource {
  final DioClient dioClient;
  final LocalStorageService localStorageService;

  LeaveApprovalRemoteDataSourceImpl(this.dioClient, this.localStorageService);

  @override
  Future<List<ApprovalRequestModel>> getPendingLeaves(
    ApprovalCategory category, {
    int page = 1,
    int pageSize = 10,
  }) async {
    final String endpoint = (category == ApprovalCategory.team)
        ? LeaveApprovalApiConstants.getPendingLeaves
        : LeaveApprovalApiConstants.getMyLeaveApplications;

    Map<String, dynamic>? queryParameters;
    final now = DateTime.now();
    final startOfYear = "${now.year}-01-01";
    final endOfYear = "${now.year}-12-31";

    if (category == ApprovalCategory.team) {
      queryParameters = {
        'page': page,
        'page_size': pageSize,
        'sort_by': 'pending_first',
        'include_workflow_actions': false,
        'from_date': startOfYear,
        'to_date': endOfYear,
      };
    } else {
      queryParameters = {
        'page': page,
        'page_size': pageSize,
        'sort_by': 'date_desc',
        'include_workflow_actions': false,
        'from_date': startOfYear,
        'to_date': endOfYear,
      };
    }

    final response = await dioClient.get(
      endpoint,
      queryParameters: queryParameters,
    );

    if (response.data != null) {
      final dynamic msg = response.data['message'];
      List<dynamic>? items;

      if (msg is List) {
        items = msg;
      } else if (msg is Map) {
        final data = msg['data'];
        if (data is List) {
          items = data;
        } else if (data is Map && data['leaves'] is List) {
          items = data['leaves'] as List;
        } else if (msg['leaves'] is List) {
          items = msg['leaves'] as List;
        }
      }

      if (items == null && response.data['data'] is List) {
        items = response.data['data'] as List;
      }

      final List finalItems = items ?? [];

      return finalItems
          .map(
            (json) => ApprovalRequestModel.fromJson(
              json as Map<String, dynamic>,
              ApprovalType.leave,
              category,
            ),
          )
          .toList();
    }
    return [];
  }

  @override
  Future<String> submitLeaveWorkflowAction(
    String leaveApplicationName,
    String action,
  ) async {
    final response = await dioClient.put(
      LeaveApprovalApiConstants.leaveBulkWorkflowAction,
      data: {
        "leave_application_names": '["$leaveApplicationName"]',
        "action": action,
        "description": action == "Cancel" ? "withdraw" : action,
      },
    );
    if (response.data == null) {
      throw Exception("Failed to submit workflow action.");
    }

    final messageData = response.data['message'] as Map<String, dynamic>?;
    final results = messageData?['results'] as Map<String, dynamic>?;
    final failed = results?['failed'] as List?;

    if (failed != null && failed.isNotEmpty) {
      // Check for Frappe server messages first
      if (response.data['_server_messages'] != null) {
        try {
          dynamic serverMsgs = response.data['_server_messages'];
          if (serverMsgs is String) {
            serverMsgs = jsonDecode(serverMsgs);
          }
          if (serverMsgs is List && serverMsgs.isNotEmpty) {
            final String serverMsgsStr = serverMsgs.first.toString();
            final Map<String, dynamic> errorMap = jsonDecode(serverMsgsStr);
            if (errorMap['message'] != null) {
              throw ServerException(message: errorMap['message']);
            }
          }
        } catch (e) {
          if (e is ServerException) rethrow;
          // Ignore parsing errors and fall back to the basic error
        }
      }
      final String errorStr =
          failed.first['error']?.toString() ?? 'Failed to process action';
      throw ServerException(message: errorStr);
    }

    return messageData?['message']?.toString() ?? "Leave $action successfully";
  }

  @override
  Future<void> addComment(
    String referenceDoctype,
    String referenceName,
    String content,
  ) async {
    final commentEmail = localStorageService.getUserEmail() ?? '';
    final commentBy = localStorageService.getUserFullname() ?? '';
    final wrappedContent =
        '<div class="ql-editor read-mode"><p>$content</p></div>';

    final response = await dioClient.post(
      LeaveApprovalApiConstants.addComment,
      data: {
        "reference_doctype": referenceDoctype,
        "reference_name": referenceName,
        "content": wrappedContent,
        "comment_email": commentEmail,
        "comment_by": commentBy,
        "comment_type": "Comment",
      },
    );
    if (response.data == null || response.data['message'] == null) {
      throw Exception("Failed to add comment.");
    }
  }

  @override
  Future<List<CommentModel>> getComments(
    String doctype,
    String requestId,
  ) async {
    final queryParams = {
      'fields':
          '["name","content","comment_type","owner","creation","comment_by"]',
      'filters':
          '[["reference_doctype","=","$doctype"],["reference_name","=","$requestId"]]',
      'order_by': 'creation desc',
    };

    final response = await dioClient.get(
      LeaveApprovalApiConstants.commentResource,
      queryParameters: queryParams,
    );

    if (response.data != null && response.data['data'] != null) {
      final List<dynamic> data = response.data['data'];
      return data
          .map((json) => CommentModel.fromJson(json as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  @override
  Future<List<LeaveTypeModel>> fetchLeaveTypes() async {
    final response = await dioClient.get(
      LeaveApiConstants.leaveType,
      queryParameters: {'fields': '["name", "leave_type_name"]'},
    );

    final dynamic raw = response.data;
    final dynamic msg = raw?['message'];
    List<dynamic>? items;

    if (msg is List) {
      items = msg;
    } else if (msg is Map && msg['data'] is List) {
      items = msg['data'] as List;
    } else if (raw?['data'] is List) {
      items = raw['data'] as List;
    }

    final List finalItems = items ?? [];

    return finalItems
        .whereType<Map<String, dynamic>>()
        .map((json) => LeaveTypeModel.fromJson(json))
        .toList();
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
    String? attachment,
  }) async {
    final response = await dioClient.post(
      LeaveApiConstants.updateLeave,
      data: {
        "leave_application_name": leaveId,
        "employee": employeeId,
        "employee_name": employeeName,
        "leave_type": leaveType,
        "from_date": fromDate,
        "to_date": toDate,
        "reason": reason,
        "half_day": halfDay,
        "half_day_date": halfDayDate,
        "custom_half_details": halfDaySegment,
        "half_day_segment": halfDaySegment,
        "total_leave_days": totalleavedays,
        "workflow_state": workflowState,
        "custom_attach_document": attachment,
      },
    );
    final message = response.data?['message'];
    if (message != null && message['success'] == true) {
      return true;
    }

    // Extract nested error message and strip HTML tags
    String errorText = LeaveErrorConstants.updateFailed;

    if (message != null && message['message'] is Map<String, dynamic>) {
      final nestedMsg = message['message'];
      if (nestedMsg['message'] != null) {
        errorText = (nestedMsg['message'] as String)
            .replaceAll(RegExp(r'<[^>]*>'), '')
            .split(':')
            .first
            .trim();
      }
    }

    throw ServerException(message: errorText);
  }

  @override
  Future<LeaveBalanceModel> getLeaveBalance(
    String employeeId,
    String todayDate,
    String gender,
  ) async {
    final response = await dioClient.get(
      LeaveApiConstants.getLeaveBalance,
      queryParameters: {'employee': employeeId, 'date': todayDate},
    );
    if (response.data != null && response.data['message'] != null) {
      final message = response.data['message'];
      num totalAllocated = 0.0;
      num usedSum = 0.0;
      num pendingSum = 0.0;
      if (message['leave_allocation'] is Map) {
        final allocations = message['leave_allocation'] as Map;
        allocations.forEach((key, value) {
          if (value is Map) {
            totalAllocated += (value['total_leaves'] as num?) ?? 0.0;
            usedSum += (value['leaves_taken'] as num?) ?? 0.0;
            pendingSum += (value['leaves_pending_approval'] as num?) ?? 0.0;
          }
        });
      }
      return LeaveBalanceModel(
        totalAllocated: totalAllocated,
        used: usedSum,
        pending: pendingSum,
      );
    }
    throw Exception("Failed to fetch leave balance");
  }

  @override
  Future<LeaveStatisticsModel> getLeaveStatistics(
    String employeeId,
    String fromDate,
    String toDate,
  ) async {
    final response = await dioClient.get(
      LeaveApiConstants.getLeaveStatistics,
      queryParameters: {
        'employee': employeeId,
        'from_date': fromDate,
        'to_date': toDate,
      },
    );
    if (response.data != null && response.data['message'] != null) {
      return LeaveStatisticsModel.fromJson(
        response.data['message'] as Map<String, dynamic>,
      );
    }
    throw Exception("Failed to fetch leave statistics");
  }

  @override
  Future<List<OverlapLeaveModel>> getOverlapLeaves(
    String employeeId,
    String fromDate,
    String toDate,
  ) async {
    final response = await dioClient.get(
      LeaveApiConstants.getApprovedLeavesSameProject,
      queryParameters: {
        'employee': employeeId,
        'from_date': fromDate,
        'to_date': toDate,
      },
    );
    if (response.data != null && response.data['message'] != null) {
      final message = response.data['message'];
      if (message is Map && message['success'] == true) {
        final List<dynamic> data = message['data'] ?? [];
        return data
            .map(
              (json) =>
                  OverlapLeaveModel.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      }
    }
    return [];
  }

  @override
  Future<String> uploadFile(
    String filePath,
    String fileName,
    String? leaveId,
  ) async {
    final Map<String, dynamic> params = {
      "file": await MultipartFile.fromFile(filePath, filename: fileName),
      "fieldname": "custom_attach_document",
      "folder": "Home",
      "is_private": 0,
    };

    if (leaveId != null && leaveId.isNotEmpty) {
      params["doctype"] = "Leave Application";
      params["docname"] = leaveId;
    }

    final formData = FormData.fromMap(params);

    final response = await dioClient.post(
      LeaveApiConstants.uploadFile,
      data: formData,
    );
    if (response.data != null && response.data['message'] != null) {
      return response.data['message']['file_url'] as String;
    }
    throw Exception("Failed to upload file");
  }
}
