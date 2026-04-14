import 'dart:developer';

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
    print("empid ${AttendanceApiConstants.getCheckinStatus}");
    final response = await dioClient.post(
      AttendanceApiConstants.getCheckinStatus,
      data: {"employee": empid},
    );

    final data = response.data['message'];
    log('api success');
    log(data.toString());
    return AttendanceStatusModel(
      punchedIn: data['punched_in'] ?? false,
      firstIn: data['first_in'],
      success: data['success'] ?? false,
      lastOut: data['last_out'],
    );
  }

  @override
  Future<AttendanceStatusModel> punchIn(String empid) async {
    // final response = await dioClient.post(
    //   AttendanceApiConstants.punchIn,
    //   data: {"employee": empid},
    // );

    // final data = response.data['message'];
    // return AttendanceStatusModel(
    //   isPunchedIn: true,
    //   statusText: data['message'] ?? "Successfully Punched In",
    // );
    return AttendanceStatusModel(
      punchedIn: true,
      firstIn: "",
      success: true,
      lastOut: "",
    );
  }

  @override
  Future<AttendanceStatusModel> punchOut(String empid) async {
    // final response = await dioClient.post(
    //   AttendanceApiConstants.punchOut,
    //   data: {"employee": empid},
    // );

    // final data = response.data['message'];
    // return AttendanceStatusModel(
    //   isPunchedIn: false,
    //   statusText: data['message'] ?? "Successfully Punched Out",
    // );
    return AttendanceStatusModel(
      punchedIn: false,
      firstIn: "",
      success: true,
      lastOut: "",
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
      data: {"employee": employee, "from_date": fromDate, "to_date": toDate},
    );

    final Map<String, dynamic> data = response.data['message'] ?? {};
    final Map<DateTime, String> events = {};
    data.forEach((key, value) {
      events[DateTime.parse(key)] = value.toString();
    });
    return events;
  }
}
