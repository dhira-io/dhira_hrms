import 'dart:convert';
import '../../../../core/network/dio_client.dart';
import '../../../../core/error/exceptions.dart';
import '../constants/timesheet_api_constants.dart';
import '../models/timesheet_models.dart';

import 'package:dio/dio.dart';

abstract class TimesheetRemoteDataSource {
  Future<List<TimesheetModel>> fetchTimesheets({required String employee, required int start, required int limit});
  Future<TimesheetModel> fetchSingleTimesheet(String timesheetId);
  Future<List<ProjectModel>> fetchProjects();
  Future<bool> createTimesheet(Map<String, dynamic> payload);
  Future<bool> updateTimesheet(Map<String, dynamic> payload);
}

class TimesheetRemoteDataSourceImpl implements TimesheetRemoteDataSource {
  final DioClient dioClient;

  TimesheetRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<TimesheetModel>> fetchTimesheets({required String employee, required int start, required int limit}) async {
    final response = await dioClient.get(
      TimesheetApiConstants.timesheet,
      queryParameters: {
        "fields": '["name","employee","employee_name","hours_total","from_date","to_date","docstatus"]',
        "filters": '[["employee","=","$employee"]]',
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
    final response = await dioClient.get("${TimesheetApiConstants.timesheet}/$timesheetId");
    return TimesheetModel.fromJson(response.data['data']);
  }

  @override
  Future<List<ProjectModel>> fetchProjects() async {
    final response = await dioClient.get(
      TimesheetApiConstants.project,
      queryParameters: {"fields": '["name","project_name"]'},
    );

    final List data = response.data['data'] ?? [];
    return data.map((e) => ProjectModel.fromJson(e)).toList();
  }

  @override
  Future<bool> createTimesheet(Map<String, dynamic> payload) async {
    final response = await dioClient.post(
      TimesheetApiConstants.createTimesheet,
      data: payload,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          "Cookie": "sid=YOUR_SESSION_ID", // 🔥 ADD THIS
        },
      ),
    );

    if (response.statusCode == 200) {
      final data = response.data;
      if (data is Map && data['message'] is Map) {
        final message = data['message'];
        if (message['success'] == false) {
          throw ServerException(
            message: _parseErrorMessage(data, message['error'] ?? 'Unknown Server Error'),
            code: 200,
          );
        }
      }
      return true;
    }
    return false;
  }

  @override
  Future<bool> updateTimesheet(Map<String, dynamic> payload) async {
    final response = await dioClient.post(
      TimesheetApiConstants.updateTimesheet,
      data: payload,
    );

    if (response.statusCode == 200) {
      final data = response.data;
      if (data is Map && data['message'] is Map) {
        final message = data['message'];
        if (message['success'] == false) {
          throw ServerException(
            message: _parseErrorMessage(data, message['error'] ?? 'Unknown Server Error'),
            code: 200,
          );
        }
      }
      return true;
    }
    return false;
  }

  String _parseErrorMessage(Map data, String fallback) {
    try {
      if (data['_server_messages'] != null) {
        final List messages = jsonDecode(data['_server_messages']);
        if (messages.isNotEmpty) {
          final Map msgObj = jsonDecode(messages[0]);
          if (msgObj['message'] != null) {
            // Strip HTML tags like <strong>
            return msgObj['message'].replaceAll(RegExp(r'<[^>]*>'), '');
          }
        }
      }
    } catch (_) {
      // If parsing fails, fall back to the provided error message
    }
    return fallback;
  }
}
