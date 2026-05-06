import 'package:dhira_hrms/core/error/exceptions.dart';
import 'package:dhira_hrms/core/network/dio_client.dart';
import 'package:dhira_hrms/features/approvals/timesheetapproval/data/models/timesheet_approval_model.dart';

import '../constants/timesheet_approval_api_constants.dart';
import '../../../data/models/approval_request_model.dart';
import '../../../domain/entities/approval_request_entity.dart';
import '../../../domain/entities/approval_type.dart';

abstract class TimesheetApprovalRemoteDataSource {
  Future<List<TimesheetApprovalModel>> fetchTimesheets({required String employee, required int start, required int limit});
  Future<TimesheetApprovalModel> fetchSingleTimesheet(String timesheetId);
  Future<List<ApprovalRequestModel>> getPendingTimesheets(ApprovalCategory category);
  Future<void> submitTimesheetWorkflowAction(String timesheetName, String action);
  Future<TimesheetApprovalModel> getTimesheetDetails(String timesheetId);
  Future<bool> syncTimesheetWeekWise(Map<String, dynamic> payload);
  Future<bool> deleteTimesheet(String timesheetId);
  Future<List<Map<String, dynamic>>> fetchEmployees();
}

class TimesheetApprovalRemoteDataSourceImpl implements TimesheetApprovalRemoteDataSource {
  final DioClient dioClient;

  TimesheetApprovalRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<TimesheetApprovalModel>> fetchTimesheets({required String employee, required int start, required int limit}) async {
    final response = await dioClient.get(
      TimesheetApprovalApiConstants.timesheet,
      queryParameters: {
        "fields": '["name","employee","employee_name","hours_total","from_date","to_date","docstatus"]',
        "filters": '[["employee","=","$employee"]]',
        "limit_start": start,
        "limit_page_length": limit,
        "order_by": "creation desc",
      },
    );

    final List data = response.data['data'] ?? [];
    return data.map((e) => TimesheetApprovalModel.fromJson(e)).toList();
  }

  @override
  Future<TimesheetApprovalModel> fetchSingleTimesheet(String timesheetId) async {
    final response = await dioClient.get("${TimesheetApprovalApiConstants.timesheet}/$timesheetId");
    final data = response.data['data'];
    if (data == null) {
      throw ServerException(message: "Timesheet not found", code: 200);
    }
    return TimesheetApprovalModel.fromJson(data as Map<String, dynamic>);
  }


  @override
  Future<List<ApprovalRequestModel>> getPendingTimesheets(ApprovalCategory category) async {
    final String endpoint = (category == ApprovalCategory.team)
        ? TimesheetApprovalApiConstants.getTeamTimesheetApprovals
        : TimesheetApprovalApiConstants.getMyTimesheets;

    final response = await dioClient.get(endpoint);

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

      return items.map((json) => ApprovalRequestModel.fromJson(
        json as Map<String, dynamic>,
        ApprovalType.timesheet,
        category,
      )).toList();
    }
    return [];
  }

  @override
  Future<void> submitTimesheetWorkflowAction(String timesheetName, String action) async {
    if (action != 'Approve') {
      throw Exception("Reject action is not implemented for Timesheets.");
    }
    
    final response = await dioClient.post(
      TimesheetApprovalApiConstants.timesheetBulkApprove,
      data: {
        "timesheet_names": '["$timesheetName"]',
      },
    );
    if (response.data == null) {
      throw Exception("Failed to submit timesheet workflow action.");
    }
  }

  @override
  Future<TimesheetApprovalModel> getTimesheetDetails(String timesheetId) async {
    final response = await dioClient.get(
      TimesheetApprovalApiConstants.getTimesheetDetails,
      queryParameters: {"timesheet_name": timesheetId},
    );

    final data = response.data['message'];
    if (data == null) {
      throw ServerException(message: "Timesheet data not found", code: 200);
    }

    return TimesheetApprovalModel.fromJson(data as Map<String, dynamic>);
  }

  @override
  Future<bool> syncTimesheetWeekWise(Map<String, dynamic> payload) async {
    final response = await dioClient.post(
      TimesheetApprovalApiConstants.syncTimesheetWeekWise,
      data: payload,
    );
    return response.statusCode == 200;
  }

  @override
  Future<bool> deleteTimesheet(String timesheetId) async {
    final response = await dioClient.post(
      TimesheetApprovalApiConstants.deleteTimesheet,
      data: {"timesheet_name": timesheetId},
    );
    return response.statusCode == 200;
  }

  @override
  Future<List<Map<String, dynamic>>> fetchEmployees() async {
    final response = await dioClient.get(
      TimesheetApprovalApiConstants.employee,
      queryParameters: {
        "fields": '["name","employee_name","employee_number","user_id","designation"]',
        "limit_page_length": 0,
      },
    );
    final List data = response.data['data'] ?? [];
    return data.cast<Map<String, dynamic>>();
  }

}
