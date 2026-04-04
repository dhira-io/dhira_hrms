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
    final response = await dioClient.post(
      "api/method/dhira_hrms.api.attendance.get_attendance_status",
      data: {"employee": empid},
    );

    final data = response.data['message'];
    return AttendanceStatusModel(
      isPunchedIn: data['is_punched_in'] ?? false,
      statusText: data['status_text'] ?? "Unknown",
    );
  }

  @override
  Future<AttendanceStatusModel> punchIn(String empid) async {
    final response = await dioClient.post(
      "api/method/dhira_hrms.api.attendance.punch_in",
      data: {"employee": empid},
    );

    final data = response.data['message'];
    return AttendanceStatusModel(
      isPunchedIn: true,
      statusText: data['message'] ?? "Successfully Punched In",
    );
  }

  @override
  Future<AttendanceStatusModel> punchOut(String empid) async {
    final response = await dioClient.post(
      "api/method/dhira_hrms.api.attendance.punch_out",
      data: {"employee": empid},
    );

    final data = response.data['message'];
    return AttendanceStatusModel(
      isPunchedIn: false,
      statusText: data['message'] ?? "Successfully Punched Out",
    );
  }

  @override
  Future<List<AttendanceLogModel>> getAttendanceLogs(String empid) async {
    final response = await dioClient.post(
      "api/method/dhira_hrms.api.attendance.get_attendance_logs",
      data: {"employee": empid},
    );

    final List data = response.data['message'] ?? [];
    return data.map((e) => AttendanceLogModel.fromJson(e)).toList();
  }

  @override
  Future<Map<DateTime, String>> getCalendarEvents({
    required String employee,
    required String fromDate,
    required String toDate,
  }) async {
    final response = await dioClient.post(
      "api/method/dhira_hrms.api.attendance.get_calendar_events",
      data: {
        "employee": employee,
        "from_date": fromDate,
        "to_date": toDate,
      },
    );

    final Map<String, dynamic> data = response.data['message'] ?? {};
    final Map<DateTime, String> events = {};
    data.forEach((key, value) {
      events[DateTime.parse(key)] = value.toString();
    });
    return events;
  }
}
