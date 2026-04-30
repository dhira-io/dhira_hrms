import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import '../../../../core/network/dio_client.dart';
import '../constants/approvals_api_constants.dart';
import '../models/approvals_access_model.dart';
import '../models/approvals_summary_model.dart';
import '../models/approval_request_model.dart';
import '../../../../core/services/local_storage_service.dart';

abstract class ApprovalsRemoteDataSource {
  Future<ApprovalsAccessModel> getApprovalsAccess();
  Future<ApprovalsSummaryModel> getApprovalsSummary();
  Future<List<ApprovalRequestModel>> getPendingRequests(ApprovalType type, {required ApprovalCategory category});
  Future<void> addComment(String referenceDoctype, String referenceName, String content);
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
  Future<List<ApprovalRequestModel>> getPendingRequests(
      ApprovalType type, {
        required ApprovalCategory category,
      }) async {
    // 1. Select the correct endpoint based on category
    final String endpoint = (category == ApprovalCategory.team)
        ? _getTeamEndpoint(type)
        : _getRaisedEndpoint(type);

    Map<String, dynamic>? queryParameters;

    if (category == ApprovalCategory.raised) {
      final empId = localStorageService.getEmpId() ?? '';

      if (type == ApprovalType.attendance) {
        queryParameters = {
          'filters': '[["employee","=","$empId"]]',
          'fields': '["*"]'
        };
      } else if (type == ApprovalType.compOff) {
        final now = DateTime.now();
        final startOfYear = "${now.year}-01-01 00:00:00";
        final endOfYear = "${now.year}-12-31 23:59:59";

        queryParameters = {
          'fields': '["*"]',
          'filters': '[["creation","between",["$startOfYear","$endOfYear"]],["employee","=","$empId"]]'
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
}