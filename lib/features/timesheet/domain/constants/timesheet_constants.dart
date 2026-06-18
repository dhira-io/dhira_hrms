class TimesheetConstants {
  TimesheetConstants._();

  // Validation keys
  static const String selectProjectValidation = 'selectProjectValidation';
  static const String taskValidation = 'taskValidation';
  static const String expectedHoursValidation = 'expectedHoursValidation';
  static const String actualHoursValidation = 'actualHoursValidation';
  static const String descriptionValidation = 'descriptionValidation';
  static const String noChangesDone = 'noChangesDone';
  static const String noDraftTaskFound = 'noDraftTaskFound';

  // Success message keys
  static const String taskAddedToDay = 'taskAddedToDay';
  static const String timesheetSubmittedSuccessfully = 'timesheetSubmittedSuccessfully';
  static const String taskUpdatedSuccessfully = 'taskUpdatedSuccessfully';
  static const String taskDeletedSuccessfully = 'taskDeletedSuccessfully';
  static const String timesheetDeletedSuccessfully = 'timesheetDeletedSuccessfully';

  // System & logic states
  static const String draftStatus = 'draft';
  static const String blocLogName = 'TimesheetBloc';
  static const String fetchOverviewErrorMsg = 'Failed to fetch timesheet overview: ';
  static const String defaultHoursHint = '0.0';

  // Business rules (project-level constants, not configurable)
  static const double weeklyTargetHours = 48.0;
  static const double dailyTargetHours = 9.5;

  // Icon Assets
  static const String chevronLeftIcon = 'assets/icons/chevron_left.png';
  static const String chevronRightIcon = 'assets/icons/chevron_right.png';
  static const String clockSvgIcon = 'assets/svg/clock.svg';

  // Attachment extensions
  static const List<String> pdfDocExtensions = [
    '.pdf',
    '.docx',
    '.doc',
    '.xlsx',
    '.xls',
    '.pptx',
    '.ppt'
  ];
  static const List<String> imageExtensions = [
    '.png',
    '.jpg',
    '.jpeg',
    '.gif',
    '.webp'
  ];
}

