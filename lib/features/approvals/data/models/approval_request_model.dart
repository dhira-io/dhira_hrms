import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:intl/intl.dart';
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
    required List<String> availableActions,
    @Default(false) bool isMainApprover,
  }) = _ApprovalRequestModel;

  const ApprovalRequestModel._();

  factory ApprovalRequestModel.fromJson(
      Map<String, dynamic> json,
      ApprovalType type,
      ApprovalCategory category,
      ) {
    // 1. Extract Employee Info
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

    // 2. Extract Available Actions
    final List<String> actions = (json['available_actions'] as List?)
        ?.map((e) => e.toString())
        .toList() ?? [];

    // 3. Map Details dynamically
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
      availableActions: actions,
      isMainApprover: json['is_main_approver'] ?? false,
    );
  }

  // --- FORMATTING HELPERS ---

  static String _formatDate(String? date) {
    if (date == null || date.isEmpty) return "";
    try {
      return DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
    } catch (e) { return date; }
  }

  static String _formatTime(String? dateTimeStr) {
    if (dateTimeStr == null || dateTimeStr.isEmpty) return "N/A";
    try {
      final DateTime dt = DateTime.parse(dateTimeStr);
      return DateFormat('hh:mm a').format(dt);
    } catch (e) { return "N/A"; }
  }

  static String _formatDays(dynamic days) {
    if (days == null) return "0 Days";
    double val = double.tryParse(days.toString()) ?? 0.0;
    String formattedNum = val == val.toInt() ? val.toInt().toString() : val.toString();
    String label = val == 1 ? "Day" : "Days";
    return "$formattedNum $label";
  }

  // --- MAPPING LOGIC ---

  static void _mapTeamDetails(Map<String, String> details, Map<String, dynamic> json, ApprovalType type) {
    switch (type) {
      case ApprovalType.leave:
        details['Leave Type'] = json['leave_type'] ?? "";
        details['From Date'] = _formatDate(json['from_date']);
        details['To Date'] = _formatDate(json['to_date']);
        details['Days'] = _formatDays(json['days'] ?? json['total_leave_days']);
        details['Reason'] = json['description'] ?? "N/A";
        break;
      case ApprovalType.attendance:
        details['Date'] = _formatDate(json['attendance_date']);
        details['In Time'] = _formatTime(json['manual_in_time']);
        details['Out Time'] = _formatTime(json['manual_out_time']);
        details['Reason'] = json['reason_category'] ?? "N/A";
        details['Attachments'] = (json['supporting_document'] != null) ? "View" : "None";
        break;
      case ApprovalType.timesheet:
        details['Week'] = json['week_range'] ?? "";
        details['Expected'] = "${json['expected_hours']} hrs";
        details['Actual'] = "${json['actual_hours']} hrs";
        details['Projects'] = (json['projects'] as List?)?.join(', ') ?? "N/A";
        break;
      case ApprovalType.compOff:
        details['Worked Date'] = _formatDate(json['work_from_date']);
        details['Hours'] = "${json['total_working_hours']} hrs";
        details['Reason'] = json['reason'] ?? "N/A";
        break;
    }
  }

  static void _mapRaisedDetails(Map<String, String> details, Map<String, dynamic> json, ApprovalType type) {
    details['Req ID'] = json['name'] ?? json['id'] ?? "";
    switch (type) {
      case ApprovalType.leave:
        details['Leave Type'] = json['leave_type'] ?? "";
        details['From Date'] = _formatDate(json['from_date']);
        details['To Date'] = _formatDate(json['to_date']);
        details['Days'] = _formatDays(json['days'] ?? json['total_leave_days']);
        details['Status'] = json['workflow_state'] ?? json['status'] ?? "";
        details['Attachments'] = (json['supporting_document'] != null) ? "View" : "None";
        details['Comments'] = json['description'] ?? "N/A";
        break;
      case ApprovalType.attendance:
        details['Date'] = _formatDate(json['attendance_date']);
        details['System Record'] = json['original_status'] ?? "N/A";
        details['Req Time'] = "${_formatTime(json['manual_in_time'])} - ${_formatTime(json['manual_out_time'])}";
        details['Reason'] = json['reason_category'] ?? "N/A";
        details['Status'] = json['workflow_state'] ?? json['status'] ?? "";
        details['Attachments'] = (json['supporting_document'] != null) ? "View" : "None";
        details['Comments'] = json['explanation'] ?? "N/A";
        break;
      case ApprovalType.timesheet:
        details['Week Range'] = "${_formatDate(json['from_date'])} to ${_formatDate(json['to_date'])}";
        details['Total Hours'] = "${json['total_spent_hours'] ?? 0} hrs";
        details['Submitted Date'] = _formatDate(json['creation']);
        details['Approver'] = json['approver_name'] ?? "N/A";
        details['Status'] = json['workflow_state'] ?? json['status'] ?? "";
        details['Remarks'] = json['remarks'] ?? "N/A";
        details['Comments'] = json['description'] ?? "N/A";
        break;
      case ApprovalType.compOff:
        details['Worked Date'] = _formatDate(json['work_from_date']);
        details['Comp-off Date'] = _formatDate(json['half_day_date']);
        details['Reason'] = json['reason'] ?? "N/A";
        details['Status'] = json['workflow_state'] ?? json['status'] ?? "";
        details['Comments'] = json['description'] ?? "N/A";
        break;
    }
  }

  ApprovalRequestEntity toEntity(ApprovalType type) {
    return ApprovalRequestEntity(
      id: name,
      employeeName: employeeName,
      employeeRole: employeeRole ?? '',
      profileImage: profileImage != null ? "https://dev-api.hrms.dhira.io$profileImage" : null,
      status: status,
      category: category,
      type: type,
      availableActions: availableActions,
      displayDetails: displayDetails,
      isMainApprover: isMainApprover,
    );
  }
}