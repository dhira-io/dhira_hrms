import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/error/exceptions.dart';
import '../constants/timesheet_api_constants.dart';
import '../models/project_model.dart';
import '../models/project_assignment_model.dart';

abstract class TimesheetRemoteDataSource {
  Future<List<ProjectModel>> fetchProjects();
  Future<String> createTimesheet(Map<String, dynamic> payload);
  Future<String> updateTimesheet(Map<String, dynamic> payload);
  Future<Map<String, dynamic>> fetchWeekWiseDetails({required int month, required int year});
  Future<void> deleteTimesheetEntry(Map<String, dynamic> payload);
  Future<Map<String, dynamic>> getTimesheetOverview({required int month, required int year});
}

class TimesheetRemoteDataSourceImpl implements TimesheetRemoteDataSource {
  final DioClient dioClient;

  TimesheetRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<ProjectModel>> fetchProjects() async {
    final response = await dioClient.get(
      TimesheetApiConstants.project,
      queryParameters: {
        "fields": '["name", "project_name"]',
        "limit_page_length": 100, // Ensure we get all projects
      },
    );

    final List data = response.data['data'] ?? [];
    return data.map((e) => ProjectModel.fromJson(e)).toList();
  }

  @override
  Future<String> createTimesheet(Map<String, dynamic> payload) async {
    final response = await dioClient.post(
      TimesheetApiConstants.createTimesheet,
      data: payload,
      options: Options(headers: {"Content-Type": "application/json"}),
    );

    return _handleMutationResponse(response, payload, "Submission failed");
  }

  @override
  Future<String> updateTimesheet(Map<String, dynamic> payload) async {
    final response = await dioClient.post(
      TimesheetApiConstants.updateTimesheet,
      data: payload,
      options: Options(headers: {"Content-Type": "application/json"}),
    );

    return _handleMutationResponse(response, payload, "Update failed");
  }

  @override
  Future<void> deleteTimesheetEntry(Map<String, dynamic> payload) async {
    final response = await dioClient.post(
      TimesheetApiConstants.deleteEntry,
      data: payload,
      options: Options(headers: {"Content-Type": "application/json"}),
    );

    _handleMutationResponse(response, payload, "Delete failed");
  }

  String _handleMutationResponse(Response response, Map<String, dynamic> payload, String fallbackError) {
    if (response.statusCode != null && response.statusCode! >= 200 && response.statusCode! < 300) {
      final data = response.data;
      if (data is Map && data['message'] is Map) {
        final message = data['message'];
        
        // Error detection: success=false OR partial_success with errors
        if (message['success'] == false || 
            (message['status'] == 'partial_success' && (message['summary']?['errors'] ?? 0) > 0) ||
            (message['status'] == 'failed')) {
          
          final errorMsg = _parseErrorMessage(data, message['error'] ?? message['status'] ?? fallbackError);
          throw ServerException(message: errorMsg, code: response.statusCode);
        }

        // Try to get name from top level, then from added_rows, then fallback to payload name
        String? resolvedName = message['name']?.toString();
        
        if (resolvedName == null && 
            message['details']?['added_rows'] is List && 
            (message['details']['added_rows'] as List).isNotEmpty) {
           resolvedName = message['details']['added_rows'][0]['name']?.toString();
        }

        return resolvedName ?? payload['name']?.toString() ?? "";
      }
      return payload['name']?.toString() ?? "";
    }

    throw ServerException(
      message: _parseErrorMessage(response.data, "$fallbackError (status: ${response.statusCode})"),
      code: response.statusCode,
    );
  }

  @override
  Future<Map<String, dynamic>> fetchWeekWiseDetails({required int month, required int year}) async {
    final response = await dioClient.get(
      TimesheetApiConstants.getWeekWiseDetails,
      queryParameters: {
        "month": month,
        "year": year,
      },
    );

    if (response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    }
    throw ServerException(message: "Failed to fetch month data", code: response.statusCode);
  }

  @override
  Future<Map<String, dynamic>> getTimesheetOverview({required int month, required int year}) async {
    final response = await dioClient.get(
      TimesheetApiConstants.getOverview,
      queryParameters: {
        "month": month,
        "year": year,
      },
    );

    if (response.statusCode == 200) {
      return response.data as Map<String, dynamic>;
    }
    throw ServerException(message: "Failed to fetch overview data", code: response.statusCode);
  }

  String _parseErrorMessage(dynamic data, String fallback) {
    if (data is! Map) return fallback;
    try {
      if (data['_server_messages'] != null) {
        final List messages = jsonDecode(data['_server_messages']);
        if (messages.isNotEmpty) {
          final Map msgObj = jsonDecode(messages[0]);
          if (msgObj['message'] != null) {
            return msgObj['message'].toString().replaceAll(RegExp(r'<[^>]*>'), '');
          }
        }
      }
      if (data['message'] != null && data['message'] is Map && data['message']['error'] != null) {
        return data['message']['error'].toString();
      }
    } catch (_) {}
    return fallback;
  }
}
