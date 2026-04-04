import '../../../../core/network/dio_client.dart';
import '../models/timesheet_models.dart';

abstract class TimesheetRemoteDataSource {
  Future<List<TimesheetModel>> fetchTimesheets({required int start, required int limit});
  Future<TimesheetModel> fetchSingleTimesheet(String timesheetId);
  Future<List<ProjectModel>> fetchProjects();
  Future<bool> createTimesheet(Map<String, dynamic> payload);
  Future<bool> updateTimesheet(Map<String, dynamic> payload);
}

class TimesheetRemoteDataSourceImpl implements TimesheetRemoteDataSource {
  final DioClient dioClient;

  TimesheetRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<TimesheetModel>> fetchTimesheets({required int start, required int limit}) async {
    final response = await dioClient.get(
      "api/resource/Timesheet",
      queryParameters: {
        "fields": '["name", "employee", "employee_name", "hours_total", "from_date", "to_date", "docstatus", "expected_hours_total", "remaining_hours", "total_spent_hours", "approver", "approver_name"]',
        "limit_start": start,
        "limit_page_length": limit,
        "order_by": "creation desc",
      },
    );

    final List data = response.data['data'] ?? [];
    return data.map((e) => TimesheetModel.fromJson(e)).toList();
  }

  @override
  Future<TimesheetModel> fetchSingleTimesheet(String timesheetId) async {
    final response = await dioClient.get("api/resource/Timesheet/$timesheetId");
    return TimesheetModel.fromJson(response.data['data']);
  }

  @override
  Future<List<ProjectModel>> fetchProjects() async {
    final response = await dioClient.get(
      "api/resource/Project",
      queryParameters: {"fields": '["name", "project_name"]'},
    );

    final List data = response.data['data'] ?? [];
    return data.map((e) => ProjectModel.fromJson(e)).toList();
  }

  @override
  Future<bool> createTimesheet(Map<String, dynamic> payload) async {
    final response = await dioClient.post(
      "api/method/dhira_hrms.api.timesheet.create_timesheet",
      data: payload,
    );
    return response.statusCode == 200;
  }

  @override
  Future<bool> updateTimesheet(Map<String, dynamic> payload) async {
    final response = await dioClient.post(
      "api/method/dhira_hrms.api.timesheet.update_timesheet",
      data: payload,
    );
    return response.statusCode == 200;
  }
}
