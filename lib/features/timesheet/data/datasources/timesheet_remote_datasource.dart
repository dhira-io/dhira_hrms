import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
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
    try {
      final response = await dioClient.get(
        "api/resource/Timesheet",
        queryParameters: {
          "fields": '["name", "employee", "employee_name", "hours_total", "from_date", "to_date", "docstatus", "expected_hours_total", "remaining_hours", "total_spent_hours", "approver", "approver_name"]',
          "limit_start": start,
          "limit_page_length": limit,
          "order_by": "creation desc",
        },
      );

      if (response.statusCode == 200) {
        final List data = response.data['data'] ?? [];
        return data.map((e) => TimesheetModel.fromJson(e)).toList();
      } else {
        throw const ServerException("Failed to fetch timesheets");
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? "Exception in fetchTimesheets");
    }
  }

  @override
  Future<TimesheetModel> fetchSingleTimesheet(String timesheetId) async {
    try {
      final response = await dioClient.get("api/resource/Timesheet/$timesheetId");

      if (response.statusCode == 200) {
        return TimesheetModel.fromJson(response.data['data']);
      } else {
        throw const ServerException("Failed to fetch timesheet details");
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? "Exception in fetchSingleTimesheet");
    }
  }

  @override
  Future<List<ProjectModel>> fetchProjects() async {
    try {
      final response = await dioClient.get(
        "api/resource/Project",
        queryParameters: {"fields": '["name", "project_name"]'},
      );

      if (response.statusCode == 200) {
        final List data = response.data['data'] ?? [];
        return data.map((e) => ProjectModel.fromJson(e)).toList();
      } else {
        throw const ServerException("Failed to fetch projects");
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? "Exception in fetchProjects");
    }
  }

  @override
  Future<bool> createTimesheet(Map<String, dynamic> payload) async {
    try {
      final response = await dioClient.post(
        "api/method/dhira_hrms.api.timesheet.create_timesheet",
        data: payload,
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      throw ServerException(e.message ?? "Exception in createTimesheet");
    }
  }

  @override
  Future<bool> updateTimesheet(Map<String, dynamic> payload) async {
    try {
      final response = await dioClient.post(
        "api/method/dhira_hrms.api.timesheet.update_timesheet",
        data: payload,
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      throw ServerException(e.message ?? "Exception in updateTimesheet");
    }
  }
}
