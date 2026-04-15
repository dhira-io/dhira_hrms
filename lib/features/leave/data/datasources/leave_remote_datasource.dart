import '../../../../core/network/dio_client.dart';
import '../constants/leave_api_constants.dart';
import '../models/leave_models.dart';

abstract class LeaveRemoteDataSource {
  Future<List<LeaveModel>> fetchLeaveApplicationsList({required int start, required int length});
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
  Future<LeaveBalanceModel> getLeaveBalance(String employeeId, String todayDate);
  Future<bool> updateLeaveApplicationStatus({
    required String leaveApplicationName,
    required String newStatus,
  });
}

class LeaveRemoteDataSourceImpl implements LeaveRemoteDataSource {
  final DioClient dioClient;

  LeaveRemoteDataSourceImpl(this.dioClient);

  @override
  Future<List<LeaveModel>> fetchLeaveApplicationsList({required int start, required int length}) async {
    final response = await dioClient.get(
      LeaveApiConstants.leaveApplication,
      queryParameters: {
        "fields": '["name", "employee", "employee_name", "leave_type", "from_date", "to_date", "status", "leave_approver", "docstatus", "leave_approver_name", "total_leave_days"]',
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
        "description": reason,
        "half_day": halfDay,
        "half_day_date": halfDayDate,
      },
    );

    final message = response.data['message'];
    return message['success'] == true;
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
        "description": reason,
        "half_day": halfDay,
        "half_day_date": halfDayDate,
      },
    );

    return response.statusCode == 200;
  }

  @override
  Future<bool> deleteLeaveApplication(String name) async {
    final response = await dioClient.delete("${LeaveApiConstants.leaveApplication}/$name");
    return response.statusCode == 202 || response.statusCode == 200;
  }

  @override
  Future<bool> cancelLeaveApplication(String name) async {
    final response = await dioClient.post(
      LeaveApiConstants.cancelLeave,
      data: {"name": name},
    );
    return response.statusCode == 200;
  }

  @override
  Future<LeaveBalanceModel> getLeaveBalance(String employeeId, String todayDate) async {
    // Note: The user's API expects x-www-form-urlencoded for this specific endpoint
    final response = await dioClient.post(
      LeaveApiConstants.getLeaveBalance,
      queryParameters: {"employee": employeeId, "date": todayDate},
    );

    final message = response.data['message'];
    final allocations = message['leave_allocation'] as Map<String, dynamic>;
    if (allocations.containsKey('Vacation')) {
      return LeaveBalanceModel.fromJson(allocations['Vacation']);
    } else {
      return const LeaveBalanceModel(totalAllocated: 0, used: 0, pending: 0);
    }
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
