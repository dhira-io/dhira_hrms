import 'package:dhira_hrms/core/constants/app_constants.dart';
import 'package:dio/dio.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/constants/leave_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../constants/leave_api_constants.dart';
import '../models/leave_models.dart';
import '../models/leave_statistics_model.dart';
import '../models/overlap_leave_model.dart';

abstract class LeaveRemoteDataSource {
  Future<List<LeaveTypeModel>> fetchLeaveTypes();
  Future<bool> submitLeaveApplication({
    required String employeeId,
    required String employeeName,
    required String leaveType,
    required String fromDate,
    required String toDate,
    required String reason,
    required int halfDay,
    String? halfDayDate,
    String? halfDaySegment,
    double? totalleavedays,
    String? emergencyContactNumber,
    String? attachmentUrl,
  });
  Future<bool> updateLeaveApplication({
    required String leaveId,
    String? employeeId,
    String? employeeName,
    String? leaveType,
    required String fromDate,
    required String toDate,
    required String reason,
    required int halfDay,
    String? halfDayDate,
    String? halfDaySegment,
    double? totalleavedays,
    String? emergencyContactNumber,
    String? workflowState,
    String? attachmentUrl,
  });
  Future<LeaveBalanceModel> getLeaveBalance(
    String employeeId,
    String todayDate,
    String gender,
  );
  Future<LeaveStatisticsModel> getLeaveStatistics({
    required String employeeId,
    required String fromDate,
    required String toDate,
  });
  Future<String> uploadFile({
    required String filePath,
    required String fileName,
    String? leaveId,
  });
  Future<List<OverlapLeaveModel>> getApprovedLeavesSameProject({
    required String employeeId,
    required String fromDate,
    required String toDate,
  });
}

class LeaveRemoteDataSourceImpl implements LeaveRemoteDataSource {
  final DioClient dioClient;

  LeaveRemoteDataSourceImpl(this.dioClient);

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
    required String employeeName,
    required String leaveType,
    required String fromDate,
    required String toDate,
    required String reason,
    required int halfDay,
    String? halfDayDate,
    String? halfDaySegment,
    double? totalleavedays,
    String? emergencyContactNumber,
    String? attachmentUrl,
  }) async {
    final response = await dioClient.post(
      LeaveApiConstants.applyLeave,
      data: {
        "employee": employeeId,
        "employee_name": employeeName,
        "leave_type": leaveType,
        "from_date": fromDate,
        "to_date": toDate,
        "reason": reason,
        "half_day": halfDay,
        "half_day_date": halfDayDate,
        "custom_half_details": halfDaySegment,
        "half_day_segment": halfDaySegment,
        "total_leave_days": totalleavedays,
        "custom_emergency_contact_number": emergencyContactNumber,
        "custom_attach_document": attachmentUrl,
      },
    );

    final message = response.data['message'];
    if (message != null && message['success'] == true) {
      return true;
    }

    // Extract nested error message and strip HTML tags
    final nestedMsg = message?['message'];
    String errorText = LeaveErrorConstants.submissionFailed;

    if (nestedMsg is Map<String, dynamic> && nestedMsg['message'] != null) {
      errorText = (nestedMsg['message'] as String)
          .replaceAll(RegExp(r'<[^>]*>'), '')
          .split(':')
          .first
          .trim();
    }

    throw ServerException(message: errorText);
  }

  @override
  Future<bool> updateLeaveApplication({
    required String leaveId,
    String? employeeId,
    String? employeeName,
    String? leaveType,
    required String fromDate,
    required String toDate,
    required String reason,
    required int halfDay,
    String? halfDayDate,
    String? halfDaySegment,
    double? totalleavedays,
    String? emergencyContactNumber,
    String? workflowState,
    String? attachmentUrl,
  }) async {
    final Map<String, dynamic> data = {
      "leave_application_name": leaveId,
      "employee": employeeId,
      "employee_name": employeeName,
      "leave_type": leaveType,
      "from_date": fromDate,
      "to_date": toDate,
      "reason": reason,
      "half_day": halfDay,
      "half_day_date": halfDayDate,
      "custom_half_details": halfDaySegment,
      "half_day_segment": halfDaySegment,
      "total_leave_days": totalleavedays,
      "custom_emergency_contact_number": emergencyContactNumber,
      "custom_attach_document": attachmentUrl,
    };

    final response = await dioClient.post(
      LeaveApiConstants.updateLeave,
      data: data,
    );

    final message = response.data['message'];
    if (message != null && message['success'] == true) {
      return true;
    }

    // Extract nested error message and strip HTML tags
    String errorText = LeaveErrorConstants.updateFailed;

    if (message != null && message['message'] is Map<String, dynamic>) {
      final nestedMsg = message['message'];
      if (nestedMsg['message'] != null) {
        errorText = (nestedMsg['message'] as String)
            .replaceAll(RegExp(r'<[^>]*>'), '')
            .split(':')
            .first
            .trim();
      }
    }

    throw ServerException(message: errorText);
  }

  @override
  Future<LeaveBalanceModel> getLeaveBalance(
    String employeeId,
    String todayDate,
    String gender,
  ) async {
    final response = await dioClient.post(
      LeaveApiConstants.getEmployeeLeaveData,
      data: {"employee_id": employeeId},
    );

    final message = response.data['message'];
    if (message == null || message['success'] != true) {
      throw Exception(LeaveErrorConstants.fetchBalanceFailed);
    }

    final List<dynamic> allocatedLeaves = message['allocated_leaves'] ?? [];
    final Map<String, dynamic> summary = message['summary'] ?? {};

    num totalAllocatedSum = 0.0;
    num usedSum = 0.0;
    num pendingSum = 0.0;
    num availableSum = 0.0;
    List<DetailedBalanceModel> details = [];

    for (var item in allocatedLeaves) {
      final leaveTypeName = item['leave_type']?.toString() ?? "";

      // Apply Gender Filter
      // Male: Hide Maternity, Female: Hide Paternity
      bool shouldInclude = true;
      if (gender.toLowerCase() == Gender.male &&
          leaveTypeName.contains(LeaveTypes.maternityLeave)) {
        shouldInclude = false;
      } else if (gender.toLowerCase() == Gender.female &&
          leaveTypeName.contains(LeaveTypes.paternityLeave)) {
        shouldInclude = false;
      }

      if (shouldInclude) {
        final allocated = _parseNum(item['total_allocated_leaves']);
        final used = _parseNum(item['used_leaves']);
        final pending = _parseNum(item['leaves_pending_approval']);
        final available = _parseNum(item['available_leaves']);

        totalAllocatedSum += allocated;
        usedSum += used;
        pendingSum += pending;
        availableSum += available;

        details.add(
          DetailedBalanceModel(
            leaveType: leaveTypeName,
            allocated: allocated.toDouble(),
            used: used.toDouble(),
            pending: pending.toDouble(),
            available: available.toDouble(),
          ),
        );
      }
    }

    // Use calculated sums or fallback to summary if available and sums are zero
    // This ensures robustness across different API response versions
    final finalTotalAllocated = totalAllocatedSum > 0
        ? totalAllocatedSum
        : _parseNum(summary['total_allocated']);
    final finalTotalAvailable = availableSum > 0
        ? availableSum
        : _parseNum(summary['total_available']);

    return LeaveBalanceModel(
      totalAllocated: finalTotalAllocated,
      used: usedSum,
      pending: pendingSum,
      available: finalTotalAvailable,
      approved: usedSum,
      applied: usedSum + pendingSum,
      rejected: 0,
      details: details,
    );
  }

  @override
  Future<LeaveStatisticsModel> getLeaveStatistics({
    required String employeeId,
    required String fromDate,
    required String toDate,
  }) async {
    final response = await dioClient.get(
      LeaveApiConstants.getLeaveStatistics,
      queryParameters: {
        "employee": employeeId,
        "from_date": fromDate,
        "to_date": toDate,
      },
      options: Options(headers: {"Accept": "application/json"}),
    );

    if (response.data['message'] != null) {
      return LeaveStatisticsModel.fromJson(response.data['message']);
    }

    throw Exception(LeaveErrorConstants.fetchStatisticsFailed);
  }

  @override
  Future<List<OverlapLeaveModel>> getApprovedLeavesSameProject({
    required String employeeId,
    required String fromDate,
    required String toDate,
  }) async {
    final response = await dioClient.get(
      LeaveApiConstants.getApprovedLeavesSameProject,
      queryParameters: {
        "employee": employeeId,
        "from_date": fromDate,
        "to_date": toDate,
      },
    );

    if (response.data['message'] != null &&
        response.data['message']['success'] == true) {
      final List data = response.data['message']['data'] ?? [];
      return data.map((e) => OverlapLeaveModel.fromJson(e)).toList();
    }

    return [];
  }

  @override
  Future<String> uploadFile({
    required String filePath,
    required String fileName,
    String? leaveId,
  }) async {
    final Map<String, dynamic> params = {
      "file": await MultipartFile.fromFile(filePath, filename: fileName),
      "fieldname": "custom_attach_document",
      "folder": "Home",
      "is_private": 0,
    };

    if (leaveId != null && leaveId.isNotEmpty) {
      params["doctype"] = "Leave Application";
      params["docname"] = leaveId;
    }

    final formData = FormData.fromMap(params);

    final response = await dioClient.post(
      LeaveApiConstants.uploadFile,
      data: formData,
      options: Options(contentType: "multipart/form-data"),
    );

    if (response.data['message'] != null) {
      final fileUrl = response.data['message']['file_url'];
      if (fileUrl != null) {
        return fileUrl as String;
      }
    }

    throw Exception(LeaveErrorConstants.uploadFailed);
  }

  num _parseNum(dynamic value) {
    if (value == null) return 0;
    if (value is num) return value;
    if (value is String) return num.tryParse(value) ?? 0;
    return 0;
  }
}
