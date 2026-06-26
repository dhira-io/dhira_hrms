import 'package:dhira_hrms/l10n/app_localizations.dart';

class ApprovalsApiConstants {
  static const String canAccessApprovalPage =
      "api/method/dhira_hrms.api.leave_application.can_access_approval_page";
  static const String getAllPendingApprovalsSummary =
      "api/method/dhira_hrms.api.navbar.get_all_pending_approvals_summary";
  static const String addComment =
      "api/method/frappe.desk.form.utils.add_comment";
  static const String leaveBulkWorkflowAction =
      "api/method/dhira_hrms.api.leave_application.bulk_workflow_action";
  static const String attendanceBulkWorkflowApproval =
      "api/method/frappe.model.workflow.bulk_workflow_approval";
  static const String timesheetBulkApprove =
      "api/method/dhira_hrms.api.employee_timesheet.bulk_approve_timesheets";

  // Pending approvals listing (for later use if needed)
  static const String getPendingLeaves =
      "api/method/dhira_hrms.api.leave_application.get_pending_approvals";
  static const String getAttendanceRegularizations =
      "api/method/dhira_hrms.api.attendance.get_attendance_regularizations";
  static const String getTeamTimesheetApprovals =
      "api/method/dhira_hrms.api.employee_timesheet.get_team_timesheet_approvals";
  static const String getCompensatoryLeaveRequests =
      "api/method/dhira_hrms.api.compensatory_leave_request.get_compensatory_leave_requests";

  /// Endpoint for personal Leave Applications
  static const String getMyLeaveApplications =
      'api/method/dhira_hrms.api.leave_application.get_my_leave_requests';
  static const String getMyAttendanceRegularizations =
      'api/resource/Attendance%20Regularization%20Request';
  static const String getMyTimesheets =
      'api/method/dhira_hrms.api.employee_timesheet.get_my_timesheets';
  static const String getMyCompOffRequests =
      'api/resource/Compensatory%20Leave%20Request';

  // Default pagination offset length
  static const int getRecordsLimit = 20;

  static const String commentResource = "api/resource/Comment";

  // Doctypes
  static const String doctypeAttendanceRegularization =
      "Attendance Regularization Request";
  static const String doctypeCompensatoryLeave = "Compensatory Leave Request";
  static const String doctypeLeaveApplication = "Leave Application";
  static const String doctypeEmployeeTimesheet = "Employee Timesheet";

  // Common Detail Keys
  static const String keyDays = 'days';
  static const String keyHours = 'hours';

  // File Extensions
  static const List<String> imageExtensions = ['.png', '.jpg', '.jpeg', '.gif', '.webp'];
  static const List<String> officeExtensions = ['.xlsx', '.xls', '.docx', '.doc', '.pptx', '.ppt'];
  static const String pdfExtension = '.pdf';

  static bool isImageFile(String path) => imageExtensions.any((ext) => path.toLowerCase().endsWith(ext));
  static bool isOfficeFile(String path) => officeExtensions.any((ext) => path.toLowerCase().endsWith(ext));
  static bool isPdfFile(String path) => path.toLowerCase().endsWith(pdfExtension);

  // Status Constants
  static const String statusOpen = 'open';
  static const String statusDraft = 'draft';
  static const String statusPending = 'pending';

  // Messages
  static const String msgTimesheetUpdated = 'Timesheet updated successfully';
  static const String msgTimesheetUpdateFailed = 'Failed to update timesheet';
  static const String msgTimesheetDeleted = 'Timesheet deleted successfully';
  static const String msgTimesheetDeleteFailed = 'Failed to delete timesheet';
  static const String msgBulkActionPartialError = 'Some requests failed to process';
  static const String msgBulkActionSuccess = 'Bulk action completed successfully';
  static const String msgFailedToRefreshPrefix = 'FAILED_TO_REFRESH_PREFIX:';

  static String getLocalizedLabel(AppLocalizations l10n, String label) {
    switch (label) {
      case 'Leave Type':
        return l10n.leaveType;
      case 'From Date':
        return l10n.fromDate;
      case 'To Date':
        return l10n.toDate;
      case 'Duration':
        return l10n.duration;
      case 'Days':
        return l10n.daysLabel;
      case 'Reason':
        return l10n.reason;
      case 'Date':
        return l10n.date;
      case 'In Time':
        return l10n.inTimeLabel;
      case 'Out Time':
        return l10n.outTimeLabel;
      case 'Attachments':
        return l10n.attachmentsLabel;
      case 'Week':
        return l10n.week;
      case 'Expected':
        return l10n.expectedLabel;
      case 'Actual':
        return l10n.actualLabel;
      case 'Projects':
        return l10n.projectsLabel;
      case 'Worked Date':
        return l10n.workedDateLabel;
      case 'Hours':
        return l10n.hoursLabel;
      case 'Req ID':
        return l10n.reqIdLabel;
      case 'Comments':
        return l10n.commentsLabel;
      case 'Week Range':
        return l10n.weekRangeLabel;
      case 'Total Hours':
        return l10n.totalHours("");
      case 'Submitted Date':
        return l10n.submittedDateLabel;
      case 'Approver':
        return l10n.approver;
      case 'Remarks':
        return l10n.remarksLabel;
      case 'Comp-off Date':
        return l10n.compOffDateLabel;
      case 'Day Segment':
        return l10n.daySegment;
      default:
        return label;
    }
  }

  static String getLocalizedValue(
    AppLocalizations l10n,
    String lowerLabel,
    String value,
  ) {
    if (value == "Unknown" || value == "N/A") {
      return l10n.notAvailable;
    } else if (value == "None") {
      return l10n.noneLabel;
    } else if (lowerLabel.contains('hours') ||
        lowerLabel == 'expected' ||
        lowerLabel == 'actual') {
      return "$value ${l10n.hoursLabel}";
    } else if (lowerLabel == 'days') {
      return "$value ${l10n.daysLabel}";
    }
    return value;
  }
}
