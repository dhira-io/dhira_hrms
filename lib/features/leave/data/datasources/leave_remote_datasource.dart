import 'package:dio/dio.dart';
import '../../../../core/constants/leave_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../../../../core/utils/date_time_utils.dart';
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
    String? workflowState,
  });
  Future<LeaveBalanceModel> getLeaveBalance(String employeeId, String todayDate, String gender);
  Future<LeaveStatisticsModel> getLeaveStatistics({
    required String employeeId,
    required String fromDate,
    required String toDate,
  });
  Future<String> uploadFile({
    required String filePath,
    required String fileName,
    required String employeeId,
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
    double? totalleavedays
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
        "total_leave_days": totalleavedays
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
    } else if (message?['error'] != null) {
      errorText = message?['error'].toString() ?? errorText;
    }

    throw Exception("message: $errorText");
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
    String? workflowState,
  }) async {
    final Map<String, dynamic> data = {
      "leave_application_name": leaveId,
      "from_date": fromDate,
      "to_date": toDate,
      "reason": reason,
      "half_day": halfDay,
      "half_day_date": halfDayDate,
      "custom_half_details": halfDaySegment,
      "total_leave_days": totalleavedays,
      "workflow_state": workflowState ?? "Pending",
    };

    if (employeeId != null) data["employee"] = employeeId;
    if (employeeName != null) data["employee_name"] = employeeName;
    if (leaveType != null) data["leave_type"] = leaveType;

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

    throw Exception("message: $errorText");
  }

  @override
  Future<LeaveBalanceModel> getLeaveBalance(String employeeId, String todayDate, String gender) async {
    // 1. Fetch Detailed Balance Breakdown
    final detailsResponse = await dioClient.post(
      LeaveApiConstants.getLeaveBalance,
      data: {
        "employee": employeeId,
        "date": todayDate,
      },
      options: Options(
        contentType: "application/x-www-form-urlencoded",
        headers: {"Accept": "application/json"},
      ),
    );

    // 2. Fetch Overall Monthly Statistics
    final now = DateTime.now();
    final fromDate = DateTimeUtils.formatDate(now.firstDayOfMonth);
    final toDate = DateTimeUtils.formatDate(now.lastDayOfMonth);

    final statsResponse = await dioClient.get(
      LeaveApiConstants.getLeaveStatistics,
      queryParameters: {
        "employee": employeeId,
        "from_date": fromDate,
        "to_date": toDate,
      },
    );

    // Process Details
    final detailsMessage = detailsResponse.data['message'];
    num totalAllocated = 0.0;
    num usedSum = 0.0;
    num pendingSum = 0.0;
    List<DetailedBalanceModel> details = [];

    if (detailsMessage != null && detailsMessage['leave_allocation'] is Map) {
      final allocations = detailsMessage['leave_allocation'] as Map<dynamic, dynamic>;
      allocations.forEach((key, value) {
        final leaveTypeName = key.toString();

        // Apply Gender Filter
        // Male: Hide Maternity, Female: Hide Paternity
        bool shouldInclude = true;
        if (gender.toLowerCase() == 'male' && leaveTypeName.contains(LeaveTypes.maternityLeave)) {
          shouldInclude = false;
        } else if (gender.toLowerCase() == 'female' && leaveTypeName.contains(LeaveTypes.paternityLeave)) {
          shouldInclude = false;
        }

        if (shouldInclude && value is Map<String, dynamic>) {
          final allocated = _parseNum(value['total_leaves']);
          final used = _parseNum(value['leaves_taken']);
          final pending = _parseNum(value['leaves_pending_approval']);

          totalAllocated += allocated;
          usedSum += used;
          pendingSum += pending;

          details.add(DetailedBalanceModel(
            leaveType: leaveTypeName,
            allocated: allocated.toDouble(),
            used: used.toDouble(),
            pending: pending.toDouble(),
          ));
        }
      });
    }

    // Process Overall Stats from Statistics API
    final statsMessage = statsResponse.data['message'];
    num approved = usedSum;
    num pendingValue = pendingSum;
    num appliedValue = usedSum + pendingSum;
    num rejected = 0;

    if (statsMessage != null && statsMessage['success'] == true) {
      final statistics = statsMessage['statistics'] as Map<String, dynamic>?;
      if (statistics != null) {
        appliedValue = _parseNum(statistics['applied_days']);
        approved = _parseNum(statistics['approved_days']);
        pendingValue = _parseNum(statistics['pending_days']);
        rejected = _parseNum(statistics['cancelled_days']);
      }
    }

    return LeaveBalanceModel(
      totalAllocated: totalAllocated,
      used: usedSum,
      pending: pendingValue,
      approved: approved,
      applied: appliedValue,
      rejected: rejected,
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
      options: Options(
        headers: {"Accept": "application/json"},
      ),
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

    if (response.data['message'] != null && response.data['message']['success'] == true) {
      final List data = response.data['message']['data'] ?? [];
      return data.map((e) => OverlapLeaveModel.fromJson(e)).toList();
    }

    return [];
  }

  @override
  Future<String> uploadFile({
    required String filePath,
    required String fileName,
    required String employeeId,
  }) async {
    final formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(filePath, filename: fileName),
      "doctype": "Employee",
      "docname": employeeId,
      "fieldname": "image",
      "folder": "Home",
      "is_private": 0,
    });

    final response = await dioClient.post(
      LeaveApiConstants.uploadFile,
      data: formData,
      options: Options(
        contentType: "multipart/form-data",
      ),
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