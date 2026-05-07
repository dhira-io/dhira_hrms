class LeaveApiConstants {
  static const String leaveApplication = "api/resource/Leave Application";
  static const String leaveType = "api/resource/Leave Type";
  static const String applyLeave = "api/method/dhira_hrms.api.leave_application.create_leave_application";
  static const String updateLeave = "api/method/dhira_hrms.api.leave_application.update_leave_application";
  static const String cancelLeave = "api/method/frappe.desk.form.save.cancel";
  static const String getLeaveBalance = "api/method/hrms.hr.doctype.leave_application.leave_application.get_leave_details";
  static const String getLeaveStatistics = "api/method/erpnext_projectlayer.api.get_leave_statistics";
  static const String updateLeaveStatus = "api/method/dhira_hrms.api.leave_application.update_leave_application_status";
  static const String getApprovedLeavesSameProject = "api/method/dhira_hrms.api.leave_application.get_approved_leaves_same_project";
  static const String uploadFile = "api/method/upload_file";
}
