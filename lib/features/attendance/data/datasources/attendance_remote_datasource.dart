import '../../../../core/network/dio_client.dart';
import '../constants/attendance_api_constants.dart';
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
      AttendanceApiConstants.getAttendanceStatus,
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
      AttendanceApiConstants.punchIn,
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
      AttendanceApiConstants.punchOut,
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
      AttendanceApiConstants.getAttendanceLogs,
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
      AttendanceApiConstants.getCalendarEvents,
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
