class NotificationSettingsConstants {
  // Section IDs
  static const String sectionPush = 'push';
  static const String sectionEmail = 'email';

  // Field Names (API IDs)
  static const String pushAttendance = 'push_attendance_regularization_request';
  static const String pushLeave = 'push_leave_application';
  static const String pushTimesheet = 'push_employee_timesheet';
  static const String pushCompOff = 'push_compensatory_leave_request';

  static const String emailAttendance = 'email_attendance_regularization_request';
  static const String emailLeave = 'email_leave_application';
  static const String emailTimesheet = 'email_employee_timesheet';
  static const String emailCompOff = 'email_compensatory_leave_request';

  // Localization Keys
  static const String l10nPushNotifications = 'pushNotifications';
  static const String l10nEmailAlerts = 'emailAlerts';
  static const String l10nAttendance = 'attendance';
  static const String l10nLeave = 'leave';
  static const String l10nTimesheetReminders = 'timesheetReminders';
  static const String l10nGeneralAnnouncements = 'generalAnnouncements';

  static const String l10nAttendancePushDesc = 'attendancePushDesc';
  static const String l10nLeavePushDesc = 'leavePushDesc';
  static const String l10nTimesheetPushDesc = 'timesheetPushDesc';
  static const String l10nGeneralPushDesc = 'generalPushDesc';

  static const String l10nAttendanceEmailDesc = 'attendanceEmailDesc';
  static const String l10nLeaveEmailDesc = 'leaveEmailDesc';
  static const String l10nTimesheetEmailDesc = 'timesheetEmailDesc';
  static const String l10nGeneralEmailDesc = 'generalEmailDesc';

  // Icon Keys
  static const String iconNotificationsActive = 'notifications_active';
  static const String iconMail = 'mail';
  static const String iconSettings = 'settings';

  // API Request Keys
  static const String apiKeyField = 'field';
  static const String apiKeyValue = 'value';
}
