// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get yourOverview => 'Your Overview';

  @override
  String get signIn => 'Sign In';

  @override
  String get email => 'Email';

  @override
  String get emailAddress => 'Email Address';

  @override
  String get enterEmail => 'Enter your email';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get enterValidEmail => 'Enter a valid email';

  @override
  String get password => 'Password';

  @override
  String get enterPassword => 'Enter your password';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordTooShort => 'Password is too short';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get or => 'OR';

  @override
  String get loginWith => 'Login with';

  @override
  String get office365 => 'Office 365';

  @override
  String get attendance => 'Attendance';

  @override
  String get organizations => 'Organizations';

  @override
  String get myTasks => 'My Tasks';

  @override
  String get noAttendanceFound => 'No attendance logs found.';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get tasks => 'Tasks';

  @override
  String get timesheet => 'Timesheet';

  @override
  String get leave => 'Leave';

  @override
  String get team => 'Team';

  @override
  String get settings => 'Settings';

  @override
  String get department => 'Department';

  @override
  String get location => 'Location';

  @override
  String get priority => 'Priority';

  @override
  String get due => 'Due';

  @override
  String get myProfile => 'My Profile';

  @override
  String get gallery => 'Gallery';

  @override
  String get camera => 'Camera';

  @override
  String get firstName => 'First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get birthDate => 'Birth Date';

  @override
  String get gender => 'Gender';

  @override
  String get deskTheme => 'Desk Theme';

  @override
  String get notAvailable => 'N/A';

  @override
  String get defaultVal => 'Default';

  @override
  String get viewOrgChart => 'View Org Chart';

  @override
  String get noOrganizationsFound => 'No organizations found';

  @override
  String get organizationChart => 'Organization Chart';

  @override
  String get noTasksFound => 'No tasks found';

  @override
  String get punchIn => 'Punch In';

  @override
  String get punchOut => 'Punch Out';

  @override
  String hello(Object name) {
    return 'Hello, $name!';
  }

  @override
  String get goodMorning => 'Good Morning';

  @override
  String get goodAfternoon => 'Good Afternoon';

  @override
  String get goodEvening => 'Good Evening';

  @override
  String get todaysAttendance => 'Today\'s Attendance';

  @override
  String get checkIn => 'Check-in';

  @override
  String get checkOut => 'Check-out';

  @override
  String get onTime => 'On Time';

  @override
  String get todayStatus => 'Today\'s Status';

  @override
  String get employee => 'Employee';

  @override
  String get hrDepartment => 'HR Department';

  @override
  String get applyLeave => 'Leave Request Application';

  @override
  String get approvalPending => 'Approval Pending';

  @override
  String get pendingApproval => 'Pending Approval';

  @override
  String get leavesRejected => 'Leaves Rejected';

  @override
  String get daysLabel => 'Days';

  @override
  String get halfDay => 'Half Day';

  @override
  String get halfDayDate => 'Half Day Date';

  @override
  String get fromDate => 'From Date';

  @override
  String get toDate => 'To Date';

  @override
  String get reason => 'Reason';

  @override
  String get enterReason => 'Enter reason for leave';

  @override
  String get required => 'Required';

  @override
  String get submit => 'Submit';

  @override
  String get selectDate => 'Select Date';

  @override
  String get selectDateRangeError => 'Please select from and to dates';

  @override
  String get selectHalfDayDateError => 'Please select half day date';

  @override
  String get selectLeaveTypeError => 'Please select leave type';

  @override
  String get leaveApplications => 'Leave Applications';

  @override
  String get noLeaveApplicationsFound => 'No leave applications found.';

  @override
  String get total => 'Total';

  @override
  String get used => 'Used';

  @override
  String get pending => 'Pending';

  @override
  String get applied => 'Applied';

  @override
  String get available => 'Available';

  @override
  String days(Object count) {
    return 'Days: $count';
  }

  @override
  String dateRange(Object from, Object to) {
    return '$from to $to';
  }

  @override
  String get approved => 'Approved';

  @override
  String get rejected => 'Rejected';

  @override
  String get logTime => 'Log Time';

  @override
  String get editTimesheet => 'Edit Timesheet';

  @override
  String get approver => 'Approver';

  @override
  String get projectAssignments => 'Project Assignments';

  @override
  String get addProject => 'Add Project';

  @override
  String get noProjectsAdded => 'No projects added yet.';

  @override
  String get totalExpected => 'Total Expected';

  @override
  String get totalSpent => 'Total Spent';

  @override
  String get addAssignment => 'Add Assignment';

  @override
  String get editAssignment => 'Edit Assignment';

  @override
  String get selectProject => 'Select Project';

  @override
  String get expectedHours => 'Expected Hours';

  @override
  String get spentHours => 'Spent Hours';

  @override
  String get description => 'Description';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get select => 'Select';

  @override
  String get addAtLeastOneProjectError =>
      'Please add at least one project assignment.';

  @override
  String get assignmentDateOutsideRangeError =>
      'One or more project dates are outside the selected range.';

  @override
  String get timesheets => 'Timesheets';

  @override
  String get searchTimesheets => 'Search timesheets...';

  @override
  String get noTimesheetsFound => 'No timesheets found.';

  @override
  String totalHours(Object hours) {
    return 'Total Hours: $hours';
  }

  @override
  String spentLabel(Object hours) {
    return 'Spent: $hours';
  }

  @override
  String get draft => 'Draft';

  @override
  String get saved => 'Saved';

  @override
  String get edit => 'Edit';

  @override
  String get leaveBalance => 'Leave Balance';

  @override
  String get weekHours => 'Week Hours';

  @override
  String daysCount(Object count) {
    return '$count days';
  }

  @override
  String entriesCount(Object count) {
    return '$count entries';
  }

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get english => 'English';

  @override
  String get hindi => 'Hindi';

  @override
  String get forgotPasswordTitle => 'Forgot Password?';

  @override
  String get forgotPasswordInstructions =>
      'Enter your email address and we\'ll send you a link to reset your password.';

  @override
  String get sendResetLink => 'Send Reset Link';

  @override
  String get verifyOtp => 'Verify OTP';

  @override
  String enterOtpSentTo(Object email) {
    return 'Enter OTP sent to $email';
  }

  @override
  String get resendOtp => 'Resend OTP';

  @override
  String get otpVerifiedSuccessfully => 'OTP verified successfully';

  @override
  String get pleaseEnterValidOtp => 'Please enter a valid OTP';

  @override
  String get currentPassword => 'Current Password';

  @override
  String get newPassword => 'New Password';

  @override
  String get confirmPassword => 'Confirm New Password';

  @override
  String get changePassword => 'Change Password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match.';

  @override
  String atLeastCharactersRequired(Object count) {
    return 'At least $count characters required.';
  }

  @override
  String get inProgress => 'In Progress';

  @override
  String get appTitle => 'HRMS';

  @override
  String get ok => 'OK';

  @override
  String get employeeName => 'Employee Name';

  @override
  String get addEditProject => 'Add / Edit Project';

  @override
  String get projectName => 'Project Name';

  @override
  String get task => 'Task';

  @override
  String get taskHint => 'Enter task name';

  @override
  String get date => 'Date';

  @override
  String get hoursDetails => 'Hours Details';

  @override
  String get raisedBy => 'Raised By';

  @override
  String get id => 'ID:';

  @override
  String get statusLabel => 'Status:';

  @override
  String get signOut => 'Sign Out';

  @override
  String get calendar => 'Calendar';

  @override
  String get deleteConfirmation =>
      'Are you sure you want to delete this project?';

  @override
  String get delete => 'Delete';

  @override
  String get searchServices => 'Search services...';

  @override
  String get employeeActions => 'Employee Actions';

  @override
  String get companyInformation => 'Company Information';

  @override
  String get noResultsFound => 'No results found';

  @override
  String get softwareEngineer => 'Software Engineer';

  @override
  String get user => 'User';

  @override
  String get leaveType => 'Leave Type';

  @override
  String get selectLeaveType => 'Select leave type';

  @override
  String get reasonRequired => 'Reason is required';

  @override
  String get submitApplication => 'Submit Application';

  @override
  String get updateApplication => 'Update Application';

  @override
  String get editLeaveApplication => 'Edit Leave Application';

  @override
  String get leaveSubmitSuccess => 'Leave application submitted successfully';

  @override
  String get actionSuccess => 'Action successful';

  @override
  String get searchLeaveHint => 'Search employees or leave types';

  @override
  String get duration => 'Duration';

  @override
  String get totalDays => 'Total Days';

  @override
  String get approve => 'Approve';

  @override
  String get reject => 'Reject';

  @override
  String get deleteLeave => 'Delete Leave';

  @override
  String get deleteLeaveConfirmation =>
      'Are you sure you want to delete this leave application?';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get hoursPlaceholder => '0.00';

  @override
  String get employeeDetails => 'Employee Details';

  @override
  String get datesAndReason => 'Dates and Reason';

  @override
  String get summary => 'Summary';

  @override
  String get totalAllocated => 'Total Allocated';

  @override
  String get update => 'Update';

  @override
  String get pleaseProvideReason => 'Please provide a reason...';

  @override
  String get searchEmployeeLeaveType => 'Search employees or leave types';

  @override
  String get notAssigned => 'Not Assigned';

  @override
  String get submissionFailed => 'Submission failed';

  @override
  String get updateFailed => 'Update failed';

  @override
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get punchOutEarlyWarning =>
      'You are logging out before completing 9 hours 30 mins';

  @override
  String get confirmLogout => 'Confirm Logout';

  @override
  String punchOutConfirmation(Object time) {
    return 'You have worked $time hours. Are you sure you want to log out?';
  }

  @override
  String get yesLogOut => 'Yes, Log Out';

  @override
  String get onBreak => 'On Break';

  @override
  String get present => 'Present';

  @override
  String get absent => 'Absent';

  @override
  String get takeBreak => 'Take Break';

  @override
  String get thatsAllForToday => 'That\'s all for today';

  @override
  String get resume => 'Resume';

  @override
  String get processing => 'Processing...';

  @override
  String get companyName => 'Dhira';

  @override
  String get companyWebsite => 'www.dhira.ai';

  @override
  String get actionCompletedSuccessfully => 'Action completed successfully';

  @override
  String get searchEmployeeOrLeaveType => 'Search employees or leave type';

  @override
  String get personalDetails => 'Personal Details';

  @override
  String get maritalStatus => 'Marital Status';

  @override
  String get bloodGroup => 'Blood Group';

  @override
  String get dateOfJoining => 'Date of Joining';

  @override
  String get companyDetails => 'Company Details';

  @override
  String get orgDepartment => 'Org Department';

  @override
  String get division => 'Division';

  @override
  String get employmentType => 'Employment Type';

  @override
  String get reportingDetails => 'Reporting Details';

  @override
  String get reportsTo => 'Reports To';

  @override
  String get reportsToName => 'Reports To Name';

  @override
  String get updateProfileQuestion => 'Want to update your profile details?';

  @override
  String get updateProfileInstructions =>
      'Please contact HR or your admin for any changes to your personal or professional information.';

  @override
  String get addressAndContact => 'Address and Contact';

  @override
  String get contactInformation => 'Contact Information';

  @override
  String get companyEmail => 'Company Email';

  @override
  String get phone => 'Phone';

  @override
  String get emergencyContact => 'Emergency Contact';

  @override
  String get addressInformation => 'Address Information';

  @override
  String get currentAddress => 'Current Address';

  @override
  String get permanentAddress => 'Permanent Address';

  @override
  String get userProfile => 'User Profile';

  @override
  String get overview => 'Overview';

  @override
  String get projectLead => 'Project Lead';

  @override
  String get noAssignmentsFound => 'No assignments found';

  @override
  String get designation => 'Designation';

  @override
  String get executivePresence => 'Executive Presence';

  @override
  String get letsGo => 'Let\'s Go!';

  @override
  String empIdLabel(Object id) {
    return 'EMP ID: $id';
  }

  @override
  String get daysPresent => 'Present Days';

  @override
  String get upcomingHoliday => 'Upcoming Holiday';

  @override
  String get viewAll => 'View All';

  @override
  String get compensatoryOff => 'Compensatory Off';

  @override
  String get attendanceRegularization => 'Attendance Regularization';

  @override
  String get organizationHierarchy => 'Organization Hierarchy';

  @override
  String get projectBasedServiceChart => 'Project Based Service Chart';

  @override
  String get myOrg => 'My Org';

  @override
  String get helloLabel => 'Hello,';

  @override
  String welcomeName(Object name) {
    return 'Welcome, $name!';
  }

  @override
  String get timeElapsed => 'Time Elapsed';

  @override
  String startedDayAt(Object time) {
    return 'Started day at $time';
  }

  @override
  String get logYourHours => 'Log your hours';

  @override
  String get requestTimeOff => 'Request time off';

  @override
  String get viewAttendanceRecords => 'View records';

  @override
  String get leadersBoard => 'Leaders Board';

  @override
  String get monthSummary => 'Month Summary';

  @override
  String get presentDays => 'Present Days';

  @override
  String get absentDays => 'Absent Days';

  @override
  String get onLeave => 'On Leave';

  @override
  String get holidays => 'Holidays';

  @override
  String get weekendDays => 'Weekend Days';

  @override
  String get backToHome => 'Back to Home';

  @override
  String get leavePolicy => 'Leave Policy';

  @override
  String get holidayList => 'Holiday List';

  @override
  String get attendanceCalendar => 'Attendance Calendar';

  @override
  String get open => 'Open';

  @override
  String get leaveHistory => 'Leave History';

  @override
  String get day => 'Day';

  @override
  String get month => 'Month';

  @override
  String get week => 'Week';

  @override
  String get weekend => 'Weekend';

  @override
  String get holiday => 'Holiday';

  @override
  String get noLogsFound => 'No logs found for the selected period';

  @override
  String get leaveBalanceOverview => 'Leave Balance Overview';

  @override
  String get requestDetails => 'Request Details';

  @override
  String get halfDayToggle => 'Applying for half day';

  @override
  String get reasonForLeave => 'Reason for Leave';

  @override
  String get supportingDocuments => 'Supporting Documents';

  @override
  String get dragAndDrop => 'Drag and drop file here';

  @override
  String get browseFiles => 'Browse Files';

  @override
  String get medicalWarning =>
      'A medical certificate is required for sick leave requests exceeding 2 consecutive days.';

  @override
  String get leaveRequestGuidelines => 'Leave Request Guidelines';

  @override
  String get guideline1 =>
      'Requests should be submitted at least 48 hours in advance for planned leaves.';

  @override
  String get guideline2 =>
      'Ensure all handovers are documented in the task management system.';

  @override
  String get submitRequest => 'Submit Request';

  @override
  String get allocated => 'Allocated';

  @override
  String get allocatedLabel => 'Allocated:';

  @override
  String get usedLabel => 'Used:';

  @override
  String get availableLabel => 'Available:';

  @override
  String availableStatus(Object count) {
    return 'Available: $count Days';
  }
}
