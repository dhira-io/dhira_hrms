import 'package:dhira_hrms/features/approvals/domain/entities/approval_request_entity.dart';
import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';
import '../../../../core/network/dio_client.dart';
import '../constants/approvals_api_constants.dart';
import '../models/approvals_access_model.dart';
import '../models/approvals_summary_model.dart';
import '../models/approval_request_model.dart';

abstract class ApprovalsRemoteDataSource {
  Future<ApprovalsAccessModel> getApprovalsAccess();
  Future<ApprovalsSummaryModel> getApprovalsSummary();
  Future<List<ApprovalRequestModel>> getPendingRequests(ApprovalType type, {required ApprovalCategory category});
}

class ApprovalsRemoteDataSourceImpl implements ApprovalsRemoteDataSource {
  final DioClient dioClient;

  ApprovalsRemoteDataSourceImpl(this.dioClient);

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
  Future<List<ApprovalRequestModel>> getPendingRequests(
      ApprovalType type, {
        required ApprovalCategory category,
      }) async {
    // 1. Select the correct endpoint based on category
    final String endpoint = (category == ApprovalCategory.team)
        ? _getTeamEndpoint(type)
        : _getRaisedEndpoint(type);

    final response = await dioClient.get(endpoint);

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