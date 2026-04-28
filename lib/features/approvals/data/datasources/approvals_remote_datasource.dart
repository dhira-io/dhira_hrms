import 'package:dhira_hrms/features/approvals/domain/entities/approval_type.dart';

import '../../../../core/network/dio_client.dart';
import '../constants/approvals_api_constants.dart';
import '../models/approvals_access_model.dart';
import '../models/approvals_summary_model.dart';
import '../models/approval_request_model.dart';

abstract class ApprovalsRemoteDataSource {
  /// Validates if the current user has permissions to access the approvals module.
  Future<ApprovalsAccessModel> getApprovalsAccess();

  /// Fetches the numerical summary (counts) for all pending approval categories.
  Future<ApprovalsSummaryModel> getApprovalsSummary();

  /// Fetches the detailed list of pending requests based on the selected [ApprovalType].
  Future<List<ApprovalRequestModel>> getPendingRequests(ApprovalType type);
}

class ApprovalsRemoteDataSourceImpl implements ApprovalsRemoteDataSource {
  final DioClient dioClient;

  ApprovalsRemoteDataSourceImpl(this.dioClient);

  @override
  Future<ApprovalsAccessModel> getApprovalsAccess() async {
    final response = await dioClient.get(
      ApprovalsApiConstants.canAccessApprovalPage,
    );

    if (response.data['message'] != null) {
      return ApprovalsAccessModel.fromJson(response.data['message']);
    }

    throw Exception("Failed to fetch approvals access data.");
  }

  @override
  Future<ApprovalsSummaryModel> getApprovalsSummary() async {
    final response = await dioClient.get(
      ApprovalsApiConstants.getAllPendingApprovalsSummary,
    );

    if (response.data['message'] != null) {
      // Wraps the response into the SummaryResponse model to extract the 'data' field.
      return ApprovalsSummaryResponse.fromJson(response.data['message']).data;
    }

    throw Exception("Failed to fetch approvals summary statistics.");
  }

  @override
  Future<List<ApprovalRequestModel>> getPendingRequests(ApprovalType type) async {
    final String endpoint = _getEndpointForType(type);
    final response = await dioClient.get(endpoint);

    if (response.data != null && response.data['message'] != null) {
      final dynamic rawData = response.data['message'];

      List<dynamic> items = [];

      // Logic to handle Map vs List response structure
      if (rawData is List) {
        items = rawData;
      } else if (rawData is Map && rawData.containsKey('data')) {
        items = rawData['data']; // Extract the list from the 'data' key
      } else if (rawData is Map) {
        // Handle cases where 'message' itself is the map of results
        items = rawData.values.toList();
      }

      return items
          .map((json) => ApprovalRequestModel.fromJson(json as Map<String, dynamic>))
          .toList();
    }

    return [];
  }

  /// Maps the [ApprovalType] to the corresponding endpoint from [ApprovalsApiConstants].
  String _getEndpointForType(ApprovalType type) {
    switch (type) {
      case ApprovalType.leave:
        return ApprovalsApiConstants.getPendingLeaves;
      case ApprovalType.attendance:
        return ApprovalsApiConstants.getAttendanceRegularizations;
      case ApprovalType.timesheet:
        return ApprovalsApiConstants.getTeamTimesheetApprovals;
      case ApprovalType.compOff:
        return ApprovalsApiConstants.getCompensatoryLeaveRequests;
    }
  }
}