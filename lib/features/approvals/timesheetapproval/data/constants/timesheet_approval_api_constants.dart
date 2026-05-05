class TimesheetApprovalApiConstants {
  static const String timesheet = "api/resource/Employee%20Timesheet";
  static const String employee = "api/resource/Employee";
  static const String getTimesheetDetails = "api/method/dhira_hrms.api.employee_timesheet.get_timesheet_details";
  static const String syncTimesheetWeekWise = "api/method/dhira_hrms.api.employee_timesheet.sync_timesheet_week_wise";
  static const String deleteTimesheet = "api/method/dhira_hrms.api.employee_timesheet.delete_employee_timesheet";

  // Team Approval
  static const String getTeamTimesheetApprovals = "api/method/dhira_hrms.api.employee_timesheet.get_team_timesheet_approvals";
  
  // Raised Request
  static const String getMyTimesheets = 'api/method/dhira_hrms.api.employee_timesheet.get_my_timesheets';
  
  // Actions
  static const String timesheetBulkApprove = "api/method/dhira_hrms.api.employee_timesheet.bulk_approve_timesheets";
}
