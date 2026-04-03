import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/network/dio_client.dart';
import '../models/attendance_models.dart';

abstract class AttendanceRemoteDataSource {
  Future<AttendanceStatusModel> getCheckinStatus(String empid);
  Future<AttendanceStatusModel> punchIn(String empid);
  Future<AttendanceStatusModel> punchOut(String empid);
  Future<List<AttendanceLogModel>> getAttendanceLogs(String empid);
  Future<Map<DateTime, String>> getCalendarEvents({
    required String employee,
    required String fromDate,
    required String toDate,
  });
}

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  final DioClient dioClient;

  AttendanceRemoteDataSourceImpl(this.dioClient);

  @override
  Future<AttendanceStatusModel> getCheckinStatus(String empid) async {
    try {
      final response = await dioClient.post(
        "api/method/dhira_hrms.api.attendance.get_attendance_status",
        data: {"employee": empid},
      );

      if (response.statusCode == 200) {
        final data = response.data['message'];
        return AttendanceStatusModel(
          isPunchedIn: data['is_punched_in'] ?? false,
          statusText: data['status_text'] ?? "Unknown",
        );
      } else {
        throw const ServerException("Failed to fetch attendance status");
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? "Exception in getAttendanceStatus");
    }
  }

  @override
  Future<AttendanceStatusModel> punchIn(String empid) async {
    try {
      final response = await dioClient.post(
        "api/method/dhira_hrms.api.attendance.punch_in",
        data: {"employee": empid},
      );

      if (response.statusCode == 200) {
        final data = response.data['message'];
        return AttendanceStatusModel(
          isPunchedIn: true,
          statusText: data['message'] ?? "Successfully Punched In",
        );
      } else {
        throw ServerException(response.data['message'] ?? "Punch In Failed");
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? "Exception in punchIn");
    }
  }

  @override
  Future<AttendanceStatusModel> punchOut(String empid) async {
    try {
      final response = await dioClient.post(
        "api/method/dhira_hrms.api.attendance.punch_out",
        data: {"employee": empid},
      );

      if (response.statusCode == 200) {
        final data = response.data['message'];
        return AttendanceStatusModel(
          isPunchedIn: false,
          statusText: data['message'] ?? "Successfully Punched Out",
        );
      } else {
        throw ServerException(response.data['message'] ?? "Punch Out Failed");
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? "Exception in punchOut");
    }
  }

  @override
  Future<List<AttendanceLogModel>> getAttendanceLogs(String empid) async {
    try {
      final response = await dioClient.post(
        "api/method/dhira_hrms.api.attendance.get_attendance_logs",
        data: {"employee": empid},
      );

      if (response.statusCode == 200) {
        final List data = response.data['message'] ?? [];
        return data.map((e) => AttendanceLogModel.fromJson(e)).toList();
      } else {
        throw const ServerException("Failed to fetch logs");
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? "Exception in getAttendanceLogs");
    }
  }

  @override
  Future<Map<DateTime, String>> getCalendarEvents({
    required String employee,
    required String fromDate,
    required String toDate,
  }) async {
    try {
      final response = await dioClient.post(
        "api/method/dhira_hrms.api.attendance.get_calendar_events",
        data: {
          "employee": employee,
          "from_date": fromDate,
          "to_date": toDate,
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = response.data['message'] ?? {};
        final Map<DateTime, String> events = {};
        data.forEach((key, value) {
          events[DateTime.parse(key)] = value.toString();
        });
        return events;
      } else {
        throw const ServerException("Failed to fetch calendar events");
      }
    } on DioException catch (e) {
      throw ServerException(e.message ?? "Exception in getCalendarEvents");
    }
  }
}
