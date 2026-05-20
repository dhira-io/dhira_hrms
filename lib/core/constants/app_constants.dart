class AppConstants {
  // Padding
  static const double p4 = 4.0;
  static const double p6 = 6.0;
  static const double p8 = 8.0;
  static const double p10 = 10.0;
  static const double p12 = 12.0;
  static const double p14 = 14.0;
  static const double p15 = 15.0;
  static const double p16 = 16.0;
  static const double p18 = 18.0;
  static const double p20 = 20.0;
  static const double p22 = 22.0;
  static const double p24 = 24.0;
  static const double p32 = 32.0;
  static const double p40 = 40.0;
  static const double p48 = 48.0;
  static const double p56 = 56.0;
  static const double p60 = 60.0;
  static const double p80 = 80.0;
  static const double p100 = 100.0;
  static const double p120 = 120.0;
  static const double p140 = 140.0;
  static const double p150 = 150.0;
  static const double p180 = 180.0;
  static const double p250 = 250.0;

  // Border Radius
  static const double r2 = 2.0;
  static const double r4 = 4.0;
  static const double r8 = 8.0;
  static const double r10 = 10.0;
  static const double r12 = 12.0;
  static const double r16 = 16.0;
  static const double r20 = 20.0;
  static const double r24 = 24.0;
  static const double r32 = 32.0;
  static const double full = 999.0;

  // Icon Sizes
  static const double iconSmall = 18.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
  static const double iconXSmall = 20.0;
  static const double iconXXSmall = 28.0;
  static const double iconXLarge = 56.0;
  static const double iconXMedium = 15.0;

  // Animation durations
  static const int animFast = 200;
  static const int animNormal = 300;
  static const int animSlow = 500;

  // Formatting
  static const String dateFormatDefault = 'dd-MM-yyyy';
  static const String apiDateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String timeFormat12hr = 'h:mm a';
  static const String timeFormat12hrPadded = 'hh:mm a';
  static const String dateDisplayFormat = 'MMM dd, yyyy';
  static const String dateFormatDayMonthYear = 'dd MMM yyyy';
  static const int decimalPlaces = 2;

  // Design
  static const double opacityMedium = 0.3;
  static const double opacityLow = 0.1;
  static const double opacityVeryLow = 0.05;
  static const double opacityExtraLow = 0.06;
  static const double opacitySlight = 0.2;
  static const double opacityFaded = 0.24;
  static const double opacityMuted = 0.7;

  // Base URL
  static const String baseUrl = 'https://erp.dhira.ai';

  // Common Strings
  static const String placeholderText = '--';
  static const String timePlaceholder = '--:--';
  static const String datePlaceholder = 'dd - mm - yyyy';
  static const String httpPrefix = 'http';
  static const String cookieSeparator = '; ';
  static const String cookieKeyValueSeparator = '=';
  static const String cookieHeaderKey = 'Cookie';
  static const String mandatoryIndicator = ' *';
  static const String emptyString = '';
  static const String serverErrorStateKey = '__server_error__';
  static const String maxFileSizeText = '50MB';

  // File Extensions
  static const List<String> imageExtensions = ['.png', '.jpg', '.jpeg'];
  static const List<String> documentExtensions = [
    '.xlsx',
    '.xlxx',
    '.xls',
    '.csv'
  ];

  // Storage Paths (Android)
  static const String androidDownloadFolder = 'Download';
  static const String androidPathSeparator = '/';
  static const String androidDataFolder = 'Android';

  // Doc Status
  static const int docStatusDraft = 0;
  static const int docStatusSubmitted = 1;

  // Font Sizes
  static const double fs10 = 10.0;
  static const double fs11 = 11.0;
  static const double fs12 = 12.0;
  static const double fs13 = 13.0;
  static const double fs14 = 14.0;
  static const double fs16 = 16.0;
  static const double fs18 = 18.0;
  static const double fs20 = 20.0;
  static const double fs24 = 24.0;
  static const double fs32 = 32.0;
  static const double fs36 = 36.0;

  // File Upload
  static const int maxAttachmentBytes = 10 * 1024 * 1024;

  // Error Messages
  static const String invalidDateTitle = 'Invalid date selected';
  static const String weekendHolidayError =
      'Weekends and holidays cannot be selected for leave.';
  static const String employeeIdNotFound = 'Employee ID not found';
  static const String rating1 = '1';
  static const String rating2 = '2';
  static const String rating3 = '3';
  static const String rating4 = '4';
  static const String defaultProgress = '0% (0/0)';
  static const String hundredPercent = '100%';
  static const String passwordResetSent =
      "Password reset instructions sent to your email";
}

class AttendanceStatus {
  static const String present = 'present';
  static const String holiday = 'holiday';
  static const String onLeave = 'on leave';
  static const String leave = 'leave';
  static const String absent = 'absent';
  static const String weekend = 'weekend';
  static const String halfDay = 'half day';
  static const String halfDayAlt = 'half-day';
}

class LeaveType {
  static const String bereavement = 'bereavement';
  static const String casual = 'casual';
  static const String earned = 'earned';
  static const String privileged = 'privileged';
  static const String paternity = 'paternity';
  static const String maternity = 'maternity';
  static const String restricted = 'restricted';
  static const String sick = 'sick';
  static const String compensatory = 'compensatory';
  static const String vacation = 'vacation';
}

class PerformanceStatus {
  static const String draft = 'Draft';
  static const String submitted = 'Submitted';
  static const String pending = 'Pending';
  static const String approved = 'Approved';
  static const String rejected = 'Rejected';
  static const String completed = 'Completed';
  static const String allDepartment = 'All Department';
  static const String allStatus = 'All Status';
  static const String statusActive = 'Active';
}

class PerformanceRatingRanges {
  static const double r1Min = 0.0;
  static const double r1Max = 70.0;
  static const double r2Min = 71.0;
  static const double r2Max = 80.0;
  static const double r3Min = 81.0;
  static const double r3Max = 95.0;
  static const double r4Min = 96.0;
  static const double r4Max = 105.0;

  static const List<double> r1Steps = [0, 20, 40, 60, 70];
  static const List<double> r2Steps = [71, 73, 75, 78, 80];
  static const List<double> r3Steps = [81, 85, 88, 92, 95];
  static const List<double> r4Steps = [96, 98, 100, 102, 105];
  static const List<double> defaultSteps = [0, 25, 50, 75, 100];
}

class TimesheetStatus {
  static const String draft = 'Draft';
  static const String pending = 'Pending';
  static const String approved = 'Approved';
  static const String rejected = 'Rejected';
}

class PerformanceApiKeys {
  static const String noData = 'no_data';
  static const String incompleteSelfAssessmentAnswer =
      'incomplete_self_assessment_answer';
  static const String assessmentDetailsNotLoaded =
      'assessment_details_not_loaded';
  static const String name = 'name';
  static const String goal = 'goal';
  static const String weightage = 'weightage';
  static const String target = 'target';
  static const String achieved = 'achieved';
  static const String selfRating = 'self_rating';
  static const String selfComment = 'self_comment';
  static const String employeeComment = 'employee_comment';
  static const String managerRating = 'manager_rating';
  static const String managerPercentage = 'manager_percentage';
  static const String managerComment = 'manager_comment';
  static const String weightedScore = 'weighted_score';
  static const String parent = 'parent';
  static const String parentField = 'parentfield';
  static const String parentType = 'parenttype';
  static const String docType = 'doctype';
  static const String docStatus = 'docstatus';
  static const String index = 'idx';
  static const String kras = 'kras';
  static const String progress = 'progress';
  static const String competency = 'competency';
  static const String timeline = 'timeline';
  static const String stageName = 'stage_name';
  static const String date = 'date';
  static const String status = 'stauts';
  static const String employee = 'employee';
  static const String employeeName = 'employee_name';
  static const String department = 'department';
  static const String cycle = 'cycle';
  static const String submissionDate = 'submission_date';
  static const String achievements = 'achievements';
  static const String challenges = 'challenges';
  static const String developmentNeeds = 'development_needs';
  static const String goalRatings = 'goal_ratings';
  static const String goalReview = 'goal_review';
  static const String competencyReview = 'competency_review';
  static const String pmsEvaluation = 'PMS Evaluation';
  static const String pmsSelfAssessment = 'PMS Self Assesment';
  static const String goalRatingsDocType = 'Goal Ratings';
  static const String goalReviewDocType = 'Goal Review';
  static const String competencyReviewDocType = 'Competency Review';
  static const String pmsCycleTimeline = 'PMS Cycle Timeline';
}

class TimesheetApiKeys {
  static const String name = 'name';
  static const String date = 'date';
  static const String project = 'project';
  static const String taskData = 'task_data';
  static const String description = 'description';
  static const String expectedHours = 'expected_hours';
  static const String spentHours = 'spent_hours';
  static const String status = 'status';
  static const String changes = 'changes';
}

class AppFormats {
  static const String dateWithDay = 'EEEE, dd-MM-yyyy';
}

class ApprovalStatus {
  static const String pending = 'Pending';
  static const String approved = 'Approved';
  static const String rejected = 'Rejected';
  static const String cancelled = 'Cancelled';
}

class ApprovalActions {
  static const String approve = 'Approve';
  static const String reject = 'Reject';
  static const String cancel = 'Cancel';
}


