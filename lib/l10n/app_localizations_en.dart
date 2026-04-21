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
  String get passwordTooShort => 'Password too short';

  @override
  String get forgotPassword => 'Forgot password?';

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
  String get checkIn => 'Check-In';

  @override
  String get checkOut => 'Check-Out';

  @override
  String get onTime => 'ON-TIME';

  @override
  String get todayStatus => 'Today Status';

  @override
  String get employee => 'Employee';

  @override
  String get hrDepartment => 'HR Department';

  @override
  String get applyLeave => 'Apply Leave';

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
  String get submit => 'SUBMIT';

  @override
  String get selectDate => 'Select Date';

  @override
  String get selectDateRangeError => 'Please select from and to dates';

  @override
  String get selectHalfDayDateError => 'Please select half-day date';

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
    return '$count Days';
  }

  @override
  String entriesCount(Object count) {
    return '$count Entries';
  }

  @override
  String get selectLanguage => 'Select Language';

  @override
  String get english => 'English';

  @override
  String get hindi => 'Hindi';

  @override
  String get forgotPasswordTitle => 'Forgot Password';

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
  String get otpVerifiedSuccessfully => 'OTP Verified Successfully';

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
  String get employeeDetails => 'Employee Details';

  @override
  String get employeeName => 'Employee Name';

  @override
  String get datesAndReason => 'Dates & Reason';

  @override
  String get summary => 'Summary';

  @override
  String get totalAllocated => 'Total Allocated';

  @override
  String get update => 'Update';

  @override
  String get updateApplication => 'UPDATE APPLICATION';

  @override
  String get submitApplication => 'SUBMIT APPLICATION';

  @override
  String get pleaseProvideReason => 'Please provide a reason...';

  @override
  String get leaveType => 'Leave Type';

  @override
  String get approve => 'Approve';

  @override
  String get reject => 'Reject';

  @override
  String get deleteLeave => 'Delete Leave';

  @override
  String get deleteLeaveWarning =>
      'Are you sure you want to delete this leave application?';

  @override
  String get yes => 'Yes';

  @override
  String get no => 'No';

  @override
  String get duration => 'Duration';

  @override
  String get totalDays => 'Total Days';

  @override
  String get editLeaveApplication => 'Edit Leave Application';

  @override
  String get leaveApplicationSubmitted =>
      'Leave application submitted successfully';

  @override
  String get searchEmployeeLeaveType => 'Search Employee or Leave Type';

  @override
  String get actionCompletedSuccessfully => 'Action completed successfully';

  @override
  String get signOut => 'Sign Out';

  @override
  String get calendar => 'Calendar';

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
  String get somethingWentWrong => 'Something went wrong';

  @override
  String get punchOutEarlyWarning =>
      'You\'re logging out before completing 9hr 30min';

  @override
  String get confirmLogout => 'Confirm Logout';

  @override
  String punchOutConfirmation(Object time) {
    return 'You\'ve worked $time hrs. Are you sure you want to log out?';
  }

  @override
  String get yesLogOut => 'Yes, log out';

  @override
  String get onBreak => 'On Break';

  @override
  String get present => 'Present';

  @override
  String get takeBreak => 'Take a break';

  @override
  String get thatsAllForToday => 'That\'s all for today';

  @override
  String get resume => 'Resume';

  @override
  String get processing => 'Processing...';

  @override
  String get companyName => 'DHIRA';

  @override
  String get companyWebsite => 'www.dhira.ai';

  @override
  String get searchEmployeeOrLeaveType => 'Search Employee or Leave Type';

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
  String get updateProfileQuestion => 'Need to update your profile details?';

  @override
  String get updateProfileInstructions =>
      'Please reach out to HR Department or your Admin for any changes to your personal or professional information.';

  @override
  String get addressAndContact => 'Address & Contact';

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
  String get projectName => 'Project Name';

  @override
  String get projectLead => 'Project Lead';

  @override
  String get noAssignmentsFound => 'No assignments found';

  @override
  String get designation => 'Designation';

  @override
  String get notAssigned => 'Not Assigned';

  @override
  String get submissionFailed => 'Submission failed';

  @override
  String get updateFailed => 'Update failed';

  @override
  String get delete => 'Delete';

  @override
  String get open => 'Open';

  @override
  String get myAction => 'My Action';

  @override
  String get leaveRequest => 'Leave Request';

  @override
  String get attendanceRequest => 'Attendance Request';

  @override
  String get timesheetRequest => 'Timesheet Request';

  @override
  String get comOff => 'Com-off';
}
