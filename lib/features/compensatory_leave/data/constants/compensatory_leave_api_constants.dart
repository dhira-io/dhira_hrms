class CompensatoryLeaveApiConstants {
  static const String getSummary =
      "api/method/dhira_hrms.api.compensatory_leave_request.get_compensatory_balance";
  static const String getEligibleDates =
      "api/method/dhira_hrms.api.compensatory_leave_request.get_eligible_compoff_dates";
  static const String submitRequest = "api/resource/Compensatory Leave Request";
}

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
}
