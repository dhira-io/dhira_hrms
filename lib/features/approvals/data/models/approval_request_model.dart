import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/approval_request_entity.dart';
import '../../domain/entities/approval_type.dart';

part 'approval_request_model.freezed.dart';

@freezed
abstract class ApprovalRequestModel with _$ApprovalRequestModel {
  // FIXED: The constructor must exactly match the fields you want to use
  const factory ApprovalRequestModel({
    required String name,
    required String employeeName,
    String? employeeRole,
    String? profileImage,
    required String status,
    required Map<String, String> displayDetails,
    required ApprovalCategory category,
  }) = _ApprovalRequestModel;

  const ApprovalRequestModel._();

  // FIXED: Updated fromJson to accept 3 arguments as required by your logic
  factory ApprovalRequestModel.fromJson(
      Map<String, dynamic> json,
      ApprovalType type,
      ApprovalCategory category,
      ) {
    String empName = "Unknown";
    String? role;
    String? img;

    if (json['employee'] is Map<String, dynamic>) {
      final emp = json['employee'] as Map<String, dynamic>;
      empName = emp['name'] ?? "Unknown";
      role = emp['designation'];
      img = emp['image'];
    } else {
      empName = json['employee_name'] ?? json['employee'] ?? "Unknown";
      role = json['designation'];
      img = json['image'];
    }

    final Map<String, String> details = {};
    if (category == ApprovalCategory.team) {
      _mapTeamDetails(details, json, type);
    } else {
      _mapRaisedDetails(details, json, type);
    }

    return ApprovalRequestModel(
      name: json['name'] ?? json['id'] ?? "",
      employeeName: empName,
      employeeRole: role,
      profileImage: img,
      status: json['workflow_state'] ?? json['status'] ?? "Pending",
      displayDetails: details,
      category: category,
    );
  }

  // Helper methods for mapping (keep these from previous snippet)
  static void _mapTeamDetails(Map<String, String> details, Map<String, dynamic> json, ApprovalType type) {
    switch (type) {
      case ApprovalType.leave:
        details['Leave Type'] = json['leave_type'] ?? "";
        details['From Date'] = json['from_date'] ?? "";
        details['To Date'] = json['to_date'] ?? "";
        details['Days'] = "${json['days'] ?? json['total_leave_days']}";
        details['Reason'] = json['description'] ?? "N/A";
        break;
      case ApprovalType.attendance:
        details['Date'] = json['attendance_date'] ?? "";
        details['In Time'] = json['manual_in_time'] ?? "";
        details['Out Time'] = json['manual_out_time'] ?? "";
        details['Reason'] = json['reason_category'] ?? "";
        break;
      case ApprovalType.timesheet:
        details['Week'] = json['week_range'] ?? "";
        details['Expect'] = "${json['expected_hours']} hrs";
        details['Actual'] = "${json['actual_hours']} hrs";
        details['Project'] = json['projects'] ?? "";

        break;
      case ApprovalType.compOff:
        details['Date'] = json['work_from_date'] ?? "";
        details['Hours'] = "${json['total_working_hours']} hrs";
        details['Reason'] = json['description'] ?? "N/A";
        details['Status'] = json['workflow_state'] ?? json['status'] ?? "";
        break;
    }
  }

  static void _mapRaisedDetails(Map<String, String> details, Map<String, dynamic> json, ApprovalType type) {
    // Mapping as requested for Raised Requests
    details['Req ID'] = json['name'] ?? json['id'] ?? "";
    if (type == ApprovalType.leave) details['Type'] = json['leave_type'] ?? "";
    if (type == ApprovalType.attendance) details['Date'] = json['attendance_date'] ?? "";
  }

  ApprovalRequestEntity toEntity() {
    return ApprovalRequestEntity(
      id: name,
      employeeName: employeeName,
      employeeRole: employeeRole ?? '',
      profileImage: profileImage != null ? "https://dev-api.hrms.dhira.io$profileImage" : null,
      status: status,
      category: category,
      displayDetails: displayDetails,
    );
  }
}