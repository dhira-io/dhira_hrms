class AttendanceApiConstants {
  static const String getCheckinStatus =
      "api/method/dhira_hrms.api.navbar.get_checkin_status";
  static const String punchIn = "api/method/dhira_hrms.api.navbar.punch_in";
  static const String punchOut = "api/method/dhira_hrms.api.navbar.punch_out";
  static const String getAttendanceLogs =
      "api/method/dhira_hrms.api.navbar.get_last_5_days_attendance";
  static const String getCalendarEvents =
      "api/method/hrms.api.get_attendance_calendar_events";
  static const String startBreak =
      "api/method/dhira_hrms.api.navbar.start_break";
  static const String endBreak = "api/method/dhira_hrms.api.navbar.end_break";
  static const String getWorkDurations =
      "api/method/dhira_hrms.api.navbar.get_work_durations";
  static const String getAttendanceMonthSummary =
      "api/method/dhira_hrms.api.attendance.get_attendance_month_summary_v2";
  static const String getLeaveDetails =
      "api/method/hrms.hr.doctype.leave_application.leave_application.get_leave_details";
  static const String getLeaveHistory = "api/resource/Leave Application";
  static const String getTeamLeaves =
      "api/method/dhira_hrms.api.leave_application.get_approved_leaves_same_project";
  static const String getHolidayListLeavePolicy =
      "api/method/erpnext_projectlayer.api.get_holiday_list_leave_policy";
  static const String submitRegularization =
      "api/method/frappe.desk.form.save.savedocs";
  static const String uploadFile = "api/method/upload_file";
}

class RegularizationReason {
  static const String missedPunch = 'Missed Punch';
  static const String incorrectPunch = 'Incorrect Punch';
  static const String lateArrival = 'Late Arrival';
  static const String earlyDeparture = 'Early Departure';
  static const String systemError = 'System Error';
  static const String networkIssue = 'Network Issue';
  static const String other = 'Other';
  static const String onFieldDuty = 'On Field Duty';
}

class RegularizationRequestTypeConstants {
  static const String forgotToPunch = 'forgot_to_punch';
  static const String wrongPunchTime = 'wrong_punch_time';
  static const String lateArrival = 'late_arrival';
  static const String earlyDeparture = 'early_departure';
  static const String systemError = 'system_error';
  static const String networkIssue = 'network_issue';
  static const String other = 'other';
  static const String onFieldDuty = 'on_field_duty';
}
