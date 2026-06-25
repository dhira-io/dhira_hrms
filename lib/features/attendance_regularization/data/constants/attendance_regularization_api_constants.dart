class AttendanceRegularizationApiConstants {
  static const String submitRegularization =
      "api/method/frappe.desk.form.save.savedocs";
  static const String uploadFile = "api/method/upload_file";
  static const String getAttendancePunchSummary =
      "api/method/dhira_hrms.api.attendance.get_attendance_punch_summary";
}

class AttendanceRegularizationReason {
  static const String missedPunch = 'Missed Punch';
  static const String systemError = 'System Error';
  static const String networkIssue = 'Network Issue';
  static const String onFieldDuty = 'On Field Duty';
}

class AttendanceRegularizationRequestTypeConstants {
  static const String forgotToPunch = 'forgot_to_punch';
  static const String systemError = 'system_error';
  static const String networkIssue = 'network_issue';
  static const String onFieldDuty = 'on_field_duty';
}

class AttendanceRegularizationSteps {
  static const int enterDetails = 0;
  static const int reviewDetails = 1;
  static const int confirmation = 2;
}
