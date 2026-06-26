import 'dart:convert';
import 'package:dhira_hrms/core/network/dio_client.dart';
import 'package:dhira_hrms/features/calendar/data/constants/calendar_api_constants.dart';
import 'package:dhira_hrms/features/calendar/data/models/calendar_model.dart';
import 'package:dhira_hrms/features/calendar/data/models/team_leave_model.dart';
import 'package:dhira_hrms/features/calendar/data/models/attendance_punch_summary_model.dart';
import 'package:dhira_hrms/features/calendar/data/models/leave_history_model.dart';

abstract class ICalendarRemoteDataSource {
  Future<Map<String, String>> getCalendarEvents({
    required String employee,
    required String fromDate,
    required String toDate,
  });

  Future<CalendarSummaryModel> getCalendarSummary({
    required String employee,
    required int month,
    required int year,
  });

  Future<List<TeamLeaveModel>> getTeamLeaves({
    required String employee,
    required String fromDate,
    required String toDate,
  });

  Future<AttendancePunchSummaryModel> getAttendancePunchSummary({
    required String attendanceDate,
  });

  Future<List<LeaveHistoryModel>> getLeaveHistory(String employee);
}

class CalendarRemoteDataSourceImpl implements ICalendarRemoteDataSource {
  final DioClient dioClient;

  CalendarRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<Map<String, String>> getCalendarEvents({
    required String employee,
    required String fromDate,
    required String toDate,
  }) async {
    final response = await dioClient.post(
      CalendarApiConstants.getCalendarEvents,
      data: {
        "employee": employee,
        "from_date": fromDate,
        "to_date": toDate,
      },
    );
    
    final Map<String, dynamic> data = response.data['message'] ?? {};
    final Map<String, String> events = {};
    data.forEach((key, value) {
      events[key] = value.toString();
    });
    
    return events;
  }

  @override
  Future<CalendarSummaryModel> getCalendarSummary({
    required String employee,
    required int month,
    required int year,
  }) async {
    final response = await dioClient.post(
      CalendarApiConstants.getCalendarMonthSummary,
      data: {
        "employee": employee,
        "month": month,
        "year": year,
      },
    );
    
    final Map<String, dynamic> messageData = response.data['message'] ?? {};
    return CalendarSummaryModel.fromJson(messageData);
  }

  @override
  Future<List<TeamLeaveModel>> getTeamLeaves({
    required String employee,
    required String fromDate,
    required String toDate,
  }) async {
    final response = await dioClient.get(
      CalendarApiConstants.getTeamLeaves,
      queryParameters: {
        "employee": employee,
        "from_date": fromDate,
        "to_date": toDate,
      },
    );
    final messageData = response.data['message'] as Map<String, dynamic>? ?? {};
    final List data = messageData['data'] as List? ?? [];
    return data.map((e) => TeamLeaveModel.fromJson(e)).toList();
  }

  @override
  Future<AttendancePunchSummaryModel> getAttendancePunchSummary({
    required String attendanceDate,
  }) async {
    final response = await dioClient.get(
      CalendarApiConstants.getAttendancePunchSummary,
      queryParameters: {'attendance_date': attendanceDate},
    );
    return AttendancePunchSummaryModel.fromJson(response.data['message'] ?? {});
  }

  @override
  Future<List<LeaveHistoryModel>> getLeaveHistory(String employee) async {
    final response = await dioClient.get(
      CalendarApiConstants.getLeaveHistory,
      queryParameters: {
        'fields': jsonEncode([
          "name",
          "employee",
          "employee_name",
          "leave_type",
          "from_date",
          "to_date",
          "status",
          "leave_approver",
          "docstatus",
          "leave_approver_name",
          "total_leave_days",
        ]),
        'filters': jsonEncode([
          ["employee", "=", employee],
        ]),
        'limit_start': 0,
        'limit_page_length': 10,
        'order_by': 'creation desc',
      },
    );
    final data = response.data['data'] as List?;
    return (data ?? []).map((e) => LeaveHistoryModel.fromJson(e)).toList();
  }
}
