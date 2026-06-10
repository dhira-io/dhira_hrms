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
  static const String searchProject = "api/resource/Project";
  static const String searchEmployees = "api/method/dhira_hrms.api.resume_management.search_employees";
  static const String saveSubSkillsForSkill = "api/method/dhira_hrms.api.resume_management.save_sub_skills_for_skill";

  // Resume Sections
  static const String sectionSkills = "skills";
  static const String sectionWorkExperience = "work_experience";
  static const String sectionProjects = "projects";
  static const String sectionLanguages = "languages";
  static const String sectionEducation = "education";
  static const String sectionCertifications = "certifications";
  static const String sectionConsultingExperience = "consulting_experience";

  // Resume Data Keys - Experience
  static const String keyDesignation = "designation";
  static const String keyCompanyName = "company_name";
  static const String keyCustomFromDate = "custom_from_date";
  static const String keyCustomToDate = "custom_to_date";
  static const String keyCustomCurrentlyWorking = "custom_currently_working";
  static const String keyCustomEmploymentType = "custom_employment_type";
  static const String keyCustomAssignmentSummary = "custom_assignment_summary";

  // Resume Data Keys - Education
  static const String keyQualification = "qualification";
  static const String keySchoolUniv = "school_univ";
  static const String keyYearOfPassing = "year_of_passing";
  static const String keyLevel = "level";

  // Resume Data Keys - Certifications
  static const String keyCertificationName = "certification_name";
  static const String keyIssuingInstitute = "issuing_institute";
  static const String keyYearObtained = "year_obtained";
  static const String keyCertificationUrl = "certification_url";

  // Resume Data Keys - Skills
  static const String keySkill = "skill";
  static const String keyProficiency = "proficiency";
  static const String keyYearsOfExperience = "years_of_experience";
  static const String keyCustomSubSkill = "custom_sub_skill";
  static const String keySubSkill = "sub_skill";

  // Resume Data Keys - Languages
  static const String keyLanguage = "language";
  static const String keySpeaking = "speaking";
  static const String keyReading = "reading";
  static const String keyWriting = "writing";

  // Resume Data Keys - Consulting Experience
  static const String keyParentCompany = "parent_company";
  static const String keyClientName = "client_name";
  static const String keyProject = "project";
  static const String keyFromDate = "from_date";
  static const String keyToDate = "to_date";
  static const String keyDuration = "duration";
  static const String keyProjectOverview = "project_overview";
  static const String keyBusinessImpact = "business_impact";
  static const String keyToolsAndTechnologies = "tools_and_technologies";

  // Resume Data Keys - Projects (Assignments)
  static const String keyProjectName = "project_name";
  static const String keyRole = "role";
  static const String keyReportToName = "report_to_name";
  static const String keyStartDate = "start_date";
  static const String keyEndDate = "end_date";
  static const String keyAllocation = "allocation";
  static const String keyStatus = "status";

  // Project Statuses
  static const String statusActive = "Active";
  static const String statusInactive = "Inactive";
  static const String statusCompleted = "Completed";
  static const String statusOnHold = "On Hold";

  // Messages
  static const String errProfileDataNotFound = "Profile data not found";
  static const String errProfilePicUpdateFailed = "Failed to update profile picture";
  static const String msgProfilePicUpdated = "Profile picture updated successfully";
  static const String errResumeDataNotFound = "Resume data not found";
  static const String errFailedToSaveRow = "Failed to save row";
  static const String errFailedToDeleteRow = "Failed to delete row";
  static const String errFailedToUpdateResume = "Failed to update resume";
  static const String errFailedToUpdateSubSkills = "Failed to update sub skills";
  static const String errFailedToSaveSubSkills = "Failed to save sub skills";
  static const String errFailedToUpdateProjectAssignments = "Failed to update project assignments";

  // Education Levels
  static const List<String> educationLevels = [
    "High School / Secondary",
    "Diploma",
    "Under Graduate",
    "Graduate",
    "Post Graduate",
    "Doctorate / PhD",
    "Professional Certification",
    "Other"
  ];

  // Default Designations
  static const List<String> defaultDesignations = [
    "Founder & CEO",
    "Software Developer",
    "VP - Data Engineering & Analytics",
    "Head of Solutions",
    "Data Engineer",
    "Talent Acquisition Specialist",
    "General Manager",
    "CEO",
    "VP - Data Engineering",
    "Software Engineer",
  ];

  // Default Locations
  static const List<String> defaultLocations = [
    'New York, New York, United States',
    'London, England, United Kingdom',
    'Tokyo, Tokyo, Japan',
    'Paris, Île-de-France, France',
    'Mumbai, Maharashtra, India',
    'Dubai, Dubai, United Arab Emirates',
    'Singapore, Singapore',
    'Sydney, New South Wales, Australia',
    'Toronto, Ontario, Canada',
    'Berlin, Berlin, Germany',
  ];
}
