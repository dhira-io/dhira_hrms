import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../constants/attendance_api_constants.dart';
import '../models/attendance_models.dart';
import '../models/attendance_regularization_model.dart';

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
  Future<LeaveDetailsModel> getLeaveDetails({
    required String employee,
    required String date,
  });
  Future<List<TeamLeaveModel>> getTeamLeaves({
    required String employee,
    required String fromDate,
    required String toDate,
  });
  Future<HolidayListLeavePolicyModel> getHolidayListLeavePolicy(
    String employee,
  );
  Future<void> submitRegularization(
    AttendanceRegularizationModel regularization,
  );
  Future<String> uploadFile({
    required String filePath,
    required String fileName,
  });
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
      punchedIn: messageData['punched_in'] ?? true,
      onBreak: messageData['on_break'] ?? false,
      dayEnded: messageData['day_ended'] ?? false,
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
      punchedIn: messageData['punched_in'] ?? false,
      onBreak: messageData['on_break'] ?? false,
      dayEnded: messageData['day_ended'] ?? true,
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
      punchedIn: messageData['punched_in'] ?? true,
      onBreak: messageData['on_break'] ?? true,
      dayEnded: messageData['day_ended'] ?? false,
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
      punchedIn: messageData['punched_in'] ?? true,
      onBreak: messageData['on_break'] ?? false,
      dayEnded: messageData['day_ended'] ?? false,
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

  @override
  Future<LeaveDetailsModel> getLeaveDetails({
    required String employee,
    required String date,
  }) async {
    final response = await dioClient.post(
      AttendanceApiConstants.getLeaveDetails,
      data: {"employee": employee, "date": date},
    );
    return LeaveDetailsModel.fromJson(response.data['message']);
  }

  @override
  Future<List<TeamLeaveModel>> getTeamLeaves({
    required String employee,
    required String fromDate,
    required String toDate,
  }) async {
    final response = await dioClient.get(
      AttendanceApiConstants.getTeamLeaves,
      queryParameters: {
        "employee": employee,
        "from_date": fromDate,
        "to_date": toDate,
      },
    );
    final List data = response.data['message']['data'] ?? [];
    return data.map((e) => TeamLeaveModel.fromJson(e)).toList();
  }

  @override
  Future<HolidayListLeavePolicyModel> getHolidayListLeavePolicy(
    String employee,
  ) async {
    final response = await dioClient.get(
      AttendanceApiConstants.getHolidayListLeavePolicy,
      queryParameters: {"employee": employee},
    );
    return HolidayListLeavePolicyModel.fromJson(response.data['message']);
  }

  @override
  Future<void> submitRegularization(
    AttendanceRegularizationModel regularization,
  ) async {
    final payload = regularization.toJson();
    log('Submitting regularization: $payload');
    
    final formData = FormData.fromMap({
      'doc': jsonEncode(payload),
      'action': 'Save',
    });

    await dioClient.post(
      AttendanceApiConstants.submitRegularization,
      data: formData,
    );
  }

  @override
  Future<String> uploadFile({
    required String filePath,
    required String fileName,
  }) async {
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath, filename: fileName),
      'doctype': 'Attendance Regularization Request',
      'docname':
          'new-attendance-regularization-request-${DateTime.now().millisecondsSinceEpoch}',
      'fieldname': 'supporting_document',
      'folder': 'Home',
      'is_private': 0,
    });

    final response = await dioClient.post(
      AttendanceApiConstants.uploadFile,
      data: formData,
    );

    return response.data['message']['file_url'] as String;
  }
}
