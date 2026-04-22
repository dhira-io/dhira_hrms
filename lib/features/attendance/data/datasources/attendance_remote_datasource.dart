import 'package:dhira_hrms/features/attendance/data/models/attendance_month_summary_model.dart';
import 'package:dhira_hrms/features/attendance/data/models/leave_history_model.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/network/dio_client.dart';
import '../constants/attendance_api_constants.dart';
import '../models/attendance_models.dart';

abstract class AttendanceRemoteDataSource {
  Future<AttendanceStatusModel> getCheckinStatus(String empid);
  Future<AttendanceStatusModel> punchIn(String empid);
  Future<AttendanceStatusModel> punchOut(String empid);
  Future<List<AttendanceLogModel>> getAttendanceLogs(String empid);
  Future<Map<String, String>> getCalendarEvents({
    required String employee,
    required String fromDate,
    required String toDate,
  });
  Future<AttendanceStatusModel> startBreak(String empid);
  Future<AttendanceStatusModel> endBreak(String empid);
  Future<AttendanceWorkDurationsModel> getWorkDurations(String empid);
  Future<AttendanceMonthSummaryModel> getAttendanceMonthSummary({
    required String employee,
    required int month,
    required int year,
  });
  Future<List<LeaveHistoryModel>> getLeaveHistory(String employee);
}

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  final DioClient dioClient;

  AttendanceRemoteDataSourceImpl(this.dioClient);

  @override
  Future<AttendanceStatusModel> getCheckinStatus(String empid) async {
    final response = await dioClient.post(
      AttendanceApiConstants.getCheckinStatus,
      data: {"employee": empid},
    );
    final data = response.data['message'];

    return AttendanceStatusModel(
      punchedIn: data['punched_in'] == true,
      onBreak: data['on_break'] == true,
      dayEnded: data['day_ended'] == true,
      firstIn: data['first_in'] as String?,
      success: data['success'] == true,
      lastOut: data['last_out'] as String?,
    );
  }

  @override
  Future<AttendanceStatusModel> punchIn(String empid) async {
    final response = await dioClient.post(
      AttendanceApiConstants.punchIn,
      data: {"employee": empid},
    );

    final messageData = response.data['message'];

    return AttendanceStatusModel(
      punchedIn: true,
      onBreak: false,
      dayEnded: false,
      success: messageData['success'] == true,
      message: messageData['message'] as String?,
    );
  }

  @override
  Future<AttendanceStatusModel> punchOut(String empid) async {
    final response = await dioClient.post(
      AttendanceApiConstants.punchOut,
      data: {"employee": empid},
    );

    final messageData = response.data['message'];

    return AttendanceStatusModel(
      punchedIn: false,
      onBreak: false,
      dayEnded: false,
      success: messageData['success'] == true,
      message: messageData['message'] as String?,
    );
  }

  @override
  Future<List<AttendanceLogModel>> getAttendanceLogs(String empid) async {
    final response = await dioClient.post(
      AttendanceApiConstants.getAttendanceLogs,
      data: {"employee": empid},
    );
    final List data = response.data['message']['data'] ?? [];
    return data.map((e) => AttendanceLogModel.fromJson(e)).toList();

    // Mock response for testing while backend is down
    // final dummyData = [
    //   {
    //     "date": "2026-04-14",
    //     "day_name": "Tuesday",
    //     "month_abbr": "APR",
    //     "day_number": "14",
    //     "status": "Absent",
    //     "in_time": null,
    //     "out_time": null,
    //     "working_hours": "09:30",
    //     "label": "-",
    //   },
    //   {
    //     "date": "2026-04-13",
    //     "day_name": "Monday",
    //     "month_abbr": "APR",
    //     "day_number": "13",
    //     "status": "Absent",
    //     "in_time": null,
    //     "out_time": null,
    //     "working_hours": "10:03",
    //     "label": "-",
    //   },
    //   {
    //     "date": "2026-04-12",
    //     "day_name": "Sunday",
    //     "month_abbr": "APR",
    //     "day_number": "12",
    //     "status": "Weekend",
    //     "in_time": null,
    //     "out_time": null,
    //     "working_hours": null,
    //     "label": "-",
    //   },
    //   {
    //     "date": "2026-04-11",
    //     "day_name": "Saturday",
    //     "month_abbr": "APR",
    //     "day_number": "11",
    //     "status": "Weekend",
    //     "in_time": null,
    //     "out_time": null,
    //     "working_hours": null,
    //     "label": "-",
    //   },
    //   {
    //     "date": "2026-04-10",
    //     "day_name": "Friday",
    //     "month_abbr": "APR",
    //     "day_number": "10",
    //     "status": "Present",
    //     "in_time": "09:00",
    //     "out_time": "05:20",
    //     "working_hours": "08:20",
    //     "label": "-",
    //   },
    // ];

    //return dummyData.map((e) => AttendanceLogModel.fromJson(e)).toList();
  }

  @override
  Future<Map<String, String>> getCalendarEvents({
    required String employee,
    required String fromDate,
    required String toDate,
  }) async {
    final response = await dioClient.post(
      AttendanceApiConstants.getCalendarEvents,
      data: {"employee": employee, "from_date": fromDate, "to_date": toDate},
    );
    final Map<String, dynamic> data = response.data['message'] ?? {};

    // Mock response for testing
    // final Map<String, dynamic> data = {
    //   "2026-04-01": "Present",
    //   "2026-04-02": "On Leave",
    //   "2026-04-03": "Present",
    //   "2026-04-04": "Holiday",
    //   "2026-04-05": "Holiday",
    //   "2026-04-06": "Present",
    //   "2026-04-07": "Present",
    //   "2026-04-08": "Present",
    //   "2026-04-09": "Present",
    //   "2026-04-10": "Absent",
    //   "2026-04-11": "Holiday",
    //   "2026-04-12": "Holiday",
    //   "2026-04-13": "Absent",
    //   "2026-04-14": "Present",
    //   // "2026-04-15": "Present",
    //   "2026-04-16": "On Leave",
    //   "2026-04-18": "Holiday",
    //   "2026-04-19": "Holiday",
    //   "2026-04-21": "On Leave",
    //   "2026-04-22": "On Leave",
    //   "2026-04-28": "Present",
    //   "2026-04-29": "Present",
    // };

    final Map<String, String> events = {};
    data.forEach((key, value) {
      events[key] = value.toString();
    });

    return events;
  }

  @override
  Future<AttendanceStatusModel> startBreak(String empid) async {
    final response = await dioClient.post(
      AttendanceApiConstants.startBreak,
      data: {"employee": empid},
    );

    final messageData = response.data['message'];

    return AttendanceStatusModel(
      punchedIn: true,
      onBreak: true,
      dayEnded: false,
      success: messageData['success'] == true,
      message: messageData['message'] as String?,
    );
  }

  @override
  Future<AttendanceStatusModel> endBreak(String empid) async {
    final response = await dioClient.post(
      AttendanceApiConstants.endBreak,
      data: {"employee": empid},
    );

    final messageData = response.data['message'];

    return AttendanceStatusModel(
      punchedIn: true,
      onBreak: false,
      dayEnded: false,
      success: messageData['success'] == true,
      message: messageData['message'] as String?,
    );
  }

  @override
  Future<AttendanceWorkDurationsModel> getWorkDurations(String empid) async {
    final response = await dioClient.post(
      AttendanceApiConstants.getWorkDurations,
      data: {"employee": empid},
    );
    return AttendanceWorkDurationsModel.fromJson(response.data['message']);
  }

  @override
  Future<AttendanceMonthSummaryModel> getAttendanceMonthSummary({
    required String employee,
    required int month,
    required int year,
  }) async {
    final response = await dioClient.post(
      AttendanceApiConstants.getAttendanceMonthSummary,
      data: {"employee": employee, "month": month, "year": year},
    );
    return AttendanceMonthSummaryModel.fromJson(response.data['message']);
  }

  @override
  Future<List<LeaveHistoryModel>> getLeaveHistory(String employee) async {
    final response = await dioClient.get(
      AttendanceApiConstants.getLeaveHistory,
      queryParameters: {
        'fields':
            '["name","employee","employee_name","leave_type","from_date","to_date","status","leave_approver","docstatus","leave_approver_name","total_leave_days"]',
        'filters': '[["employee","=","$employee"]]',
        'limit_start': 0,
        'limit_page_length': 10,
        'order_by': 'creation desc'
      },
    );
    final List data = response.data['data'] ?? [];
    debugPrint("Leave History Response: ${response.data}");
    return data.map((e) => LeaveHistoryModel.fromJson(e)).toList();
  }
}
