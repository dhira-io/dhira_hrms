class ApprovalsApiConstants {
  static const String canAccessApprovalPage = "api/method/dhira_hrms.api.leave_application.can_access_approval_page";
  static const String getAllPendingApprovalsSummary = "api/method/dhira_hrms.api.navbar.get_all_pending_approvals_summary";
  
  // Pending approvals listing (for later use if needed)
  static const String getPendingLeaves = "api/method/dhira_hrms.api.leave_application.get_pending_approvals";
  static const String getAttendanceRegularizations = "api/method/dhira_hrms.api.attendance.get_attendance_regularizations";
  static const String getTeamTimesheetApprovals = "api/method/dhira_hrms.api.employee_timesheet.get_team_timesheet_approvals";
  static const String getCompensatoryLeaveRequests = "api/method/dhira_hrms.api.compensatory_leave_request.get_compensatory_leave_requests";

  /// Endpoint for personal Leave Applications
  static const String getMyLeaveApplications = 'api/method/dhira_hrms.api.leave_application.get_my_leave_requests';
  static const String getMyAttendanceRegularizations = 'api/resource/Attendance%20Regularization%20Request';
  static const String getMyTimesheets = 'api/method/dhira_hrms.api.employee_timesheet.get_my_timesheets';
  static const String getMyCompOffRequests = 'api/resource/Compensatory%20Leave%20Request';
}
