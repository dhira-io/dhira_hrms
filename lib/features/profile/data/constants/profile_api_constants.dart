class ProfileApiConstants {
  static const String getUserDetails = "api/resource/Employee";
  static const String uploadFile = "api/method/upload_file";
  static const String changePassword =
      "api/method/frappe.core.doctype.user.user.change_password";
  static const String deleteProfileImage =
      "api/method/dhira_hrms.api.file.delete_employee_profile_image";

  // Resume Endpoints
  static const String getEmployeeResume = "api/method/dhira_hrms.api.resume_management.get_employee_resume";
  static const String searchSkill = "api/resource/Skill";
  static const String getCustomSubSkills = "api/method/dhira_hrms.api.skill.get_custom_sub_skills";
  static const String upsertChildRow = "api/method/dhira_hrms.api.resume_row_crud.upsert_child_row";
  static const String deleteChildRow = "api/method/dhira_hrms.api.resume_row_crud.delete_child_row";
  static const String updateEmployeeResume = "api/method/dhira_hrms.api.resume_management.update_employee_resume";
  static const String searchDesignation = "api/resource/Designation";
}
