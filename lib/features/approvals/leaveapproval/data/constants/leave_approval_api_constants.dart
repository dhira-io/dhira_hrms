class LeaveApprovalApiConstants {
  static const String canAccessApprovalPage = "api/method/dhira_hrms.api.leave_application.can_access_approval_page";
  static const String leaveBulkWorkflowAction = "api/method/dhira_hrms.api.leave_application.bulk_workflow_action";
  
  // Team Approval
  static const String getPendingLeaves = "api/method/dhira_hrms.api.leave_application.get_pending_approvals";
  
  // Raised Request
  static const String getMyLeaveApplications = 'api/method/dhira_hrms.api.leave_application.get_my_leave_requests';
  
  // Comments (Shared but used here)
  static const String addComment = "api/method/frappe.desk.form.utils.add_comment";
  static const String commentResource = "api/resource/Comment";
  
  // Doctypes
  static const String doctypeLeaveApplication = "Leave Application";
}
