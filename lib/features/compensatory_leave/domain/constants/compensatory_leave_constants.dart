class CompensatoryLeaveConstants {
  // Work type values
  static const String workTypeWeekend = "weekend";
  static const String workTypeHoliday = "holiday";
  static const String workTypeOvertime = "overtime";

  // Timesheet fill mode values
  static const String timesheetFillAuto = "auto";
  static const String timesheetFillManual = "manual";

  // UI Constants
  static const String hoursUnit = "hrs";

  // Request Payload Constants
  static const String workTypeDisplayWeekend = "Weekend";
  static const String workTypeDisplayHoliday = "Holiday";
  static const String workTypePayloadWeekend = "Weekend Work";
  static const String workTypePayloadHoliday = "Holiday Work";
  static const String workTypePayloadOvertime = "Overtime";
  static const String leaveTypeCompOff = "Compensatory Off";
  static const String autoFilledReason = "Auto-filled reason";
  static const String customAutofillManual = "0";
  static const String customAutofillAuto = "1";

  // Error Constants
  // these are internal error codes — UI maps them to localized messages
  static const String errorEmployeeIdNotFound = "error.employee_id_not_found";
  static const String errorPleaseSelectWorkDate = "error.select_work_date";
  static const String errorPleaseSelectProject = "error.select_project";
  static const String errorPleaseEnterTaskDescription =
      "error.enter_task_description";
  static const String errorPleaseEnterReason = "error.enter_reason";
}
