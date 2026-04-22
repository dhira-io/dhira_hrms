import 'package:dio/dio.dart';
import '../../../../core/network/dio_client.dart';
import '../constants/leave_api_constants.dart';
import '../models/leave_models.dart';
import '../models/leave_details_model.dart';

abstract class LeaveRemoteDataSource {
  Future<List<LeaveModel>> fetchLeaveApplicationsList({
    required int start,
    required int length,
  });
  Future<List<LeaveTypeModel>> fetchLeaveTypes();
  Future<bool> submitLeaveApplication({
    required String employeeId,
    required String leaveType,
    required String fromDate,
    required String toDate,
    required String reason,
    required int halfDay,
    String? halfDayDate,
  });
  Future<bool> updateLeaveApplication({
    required String leaveId,
    required String fromDate,
    required String toDate,
    required String reason,
    required int halfDay,
    String? halfDayDate,
  });
  Future<bool> deleteLeaveApplication(String name);
  Future<bool> cancelLeaveApplication(String name);
  Future<LeaveDetailsModel> getLeaveDetails({
    required String employee,
    required String date,
  });
  Future<bool> updateLeaveApplicationStatus({
    required String leaveApplicationName,
    required String newStatus,
  });
}

class LeaveRemoteDataSourceImpl implements LeaveRemoteDataSource {
  final DioClient dioClient;

  LeaveRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<LeaveModel>> fetchLeaveApplicationsList({
    required int start,
    required int length,
  }) async {
    final response = await dioClient.get(
      LeaveApiConstants.leaveApplication,
      queryParameters: {
        "fields":
            '["name", "employee", "employee_name", "leave_type", "from_date", "to_date", "status", "leave_approver", "docstatus", "leave_approver_name", "total_leave_days", "half_day", "half_day_date", "description"]',
        "limit_start": start,
        "limit_page_length": length,
        "order_by": "creation desc",
      },
    );

    final List data = response.data['data'] ?? [];
    return data.map((e) => LeaveModel.fromJson(e)).toList();
  }

  @override
  Future<List<LeaveTypeModel>> fetchLeaveTypes() async {
    final response = await dioClient.get(
      LeaveApiConstants.leaveType,
      queryParameters: {"fields": '["name", "leave_type_name"]'},
    );

    final List data = response.data['data'] ?? [];
    return data.map((e) => LeaveTypeModel.fromJson(e)).toList();
  }

  @override
  Future<bool> submitLeaveApplication({
    required String employeeId,
    required String leaveType,
    required String fromDate,
    required String toDate,
    required String reason,
    required int halfDay,
    String? halfDayDate,
  }) async {
    final response = await dioClient.post(
      LeaveApiConstants.applyLeave,
      data: {
        "employee": employeeId,
        "leave_type": leaveType,
        "from_date": fromDate,
        "to_date": toDate,
        "reason": reason,
        "half_day": halfDay,
        "half_day_date": halfDayDate,
      },
    );

    final message = response.data['message'];
    if (message['success'] == true) {
      return true;
    }

    // Extract nested error message and strip HTML tags
    final nestedMsg = message['message'];
    if (nestedMsg is Map<String, dynamic> && nestedMsg['message'] != null) {
      final errorMsg = (nestedMsg['message'] as String).replaceAll(
        RegExp(r'<[^>]*>'),
        '',
      );
      throw Exception(errorMsg);
    }
    throw Exception(message['error'] ?? 'Submission failed');
  }

  @override
  Future<bool> updateLeaveApplication({
    required String leaveId,
    required String fromDate,
    required String toDate,
    required String reason,
    required int halfDay,
    String? halfDayDate,
  }) async {
    final response = await dioClient.put(
      "${LeaveApiConstants.updateLeave}/$leaveId",
      data: {
        "from_date": fromDate,
        "to_date": toDate,
        "reason": reason,
        "half_day": halfDay,
        "half_day_date": halfDayDate,
      },
    );

    return response.statusCode == 200;
  }

  @override
  Future<bool> deleteLeaveApplication(String name) async {
    final response = await dioClient.delete(
      "${LeaveApiConstants.leaveApplication}/$name",
    );
    return response.statusCode == 202 || response.statusCode == 200;
  }

  @override
  Future<bool> cancelLeaveApplication(String name) async {
    final response = await dioClient.post(
      LeaveApiConstants.cancelLeave,
      data: {"doctype": "Leave Application", "name": name},
    );
    return response.statusCode == 200;
  }

  @override
  Future<LeaveDetailsModel> getLeaveDetails({
    required String employee,
    required String date,
  }) async {
    final response = await dioClient.post(
      LeaveApiConstants.getLeaveBalance,
      data: {"employee": employee, "date": date},
    );

    return LeaveDetailsModel.fromJson(response.data['message']);
  }

  @override
  Future<bool> updateLeaveApplicationStatus({
    required String leaveApplicationName,
    required String newStatus,
  }) async {
    final response = await dioClient.post(
      LeaveApiConstants.updateLeaveStatus,
      data: {
        'leave_application_name': leaveApplicationName,
        'new_status': newStatus,
      },
    );

    if (response.statusCode == 200) {
      final message = response.data['message'];
      return message != null && message['success'] == true;
    }
    return false;
  }
}
