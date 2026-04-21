import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi'),
  ];

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @yourOverview.
  ///
  /// In en, this message translates to:
  /// **'Your Overview'**
  String get yourOverview;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @enterEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterEmail;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @enterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get enterValidEmail;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @enterPassword.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterPassword;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password too short'**
  String get passwordTooShort;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get forgotPassword;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @loginWith.
  ///
  /// In en, this message translates to:
  /// **'Login with'**
  String get loginWith;

  /// No description provided for @office365.
  ///
  /// In en, this message translates to:
  /// **'Office 365'**
  String get office365;

  /// No description provided for @attendance.
  ///
  /// In en, this message translates to:
  /// **'Attendance'**
  String get attendance;

  /// No description provided for @organizations.
  ///
  /// In en, this message translates to:
  /// **'Organizations'**
  String get organizations;

  /// No description provided for @myTasks.
  ///
  /// In en, this message translates to:
  /// **'My Tasks'**
  String get myTasks;

  /// No description provided for @noAttendanceFound.
  ///
  /// In en, this message translates to:
  /// **'No attendance logs found.'**
  String get noAttendanceFound;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @tasks.
  ///
  /// In en, this message translates to:
  /// **'Tasks'**
  String get tasks;

  /// No description provided for @timesheet.
  ///
  /// In en, this message translates to:
  /// **'Timesheet'**
  String get timesheet;

  /// No description provided for @leave.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get leave;

  /// No description provided for @team.
  ///
  /// In en, this message translates to:
  /// **'Team'**
  String get team;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @department.
  ///
  /// In en, this message translates to:
  /// **'Department'**
  String get department;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @priority.
  ///
  /// In en, this message translates to:
  /// **'Priority'**
  String get priority;

  /// No description provided for @due.
  ///
  /// In en, this message translates to:
  /// **'Due'**
  String get due;

  /// No description provided for @myProfile.
  ///
  /// In en, this message translates to:
  /// **'My Profile'**
  String get myProfile;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @birthDate.
  ///
  /// In en, this message translates to:
  /// **'Birth Date'**
  String get birthDate;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @deskTheme.
  ///
  /// In en, this message translates to:
  /// **'Desk Theme'**
  String get deskTheme;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get notAvailable;

  /// No description provided for @defaultVal.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defaultVal;

  /// No description provided for @viewOrgChart.
  ///
  /// In en, this message translates to:
  /// **'View Org Chart'**
  String get viewOrgChart;

  /// No description provided for @noOrganizationsFound.
  ///
  /// In en, this message translates to:
  /// **'No organizations found'**
  String get noOrganizationsFound;

  /// No description provided for @organizationChart.
  ///
  /// In en, this message translates to:
  /// **'Organization Chart'**
  String get organizationChart;

  /// No description provided for @noTasksFound.
  ///
  /// In en, this message translates to:
  /// **'No tasks found'**
  String get noTasksFound;

  /// No description provided for @punchIn.
  ///
  /// In en, this message translates to:
  /// **'Punch In'**
  String get punchIn;

  /// No description provided for @punchOut.
  ///
  /// In en, this message translates to:
  /// **'Punch Out'**
  String get punchOut;

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello, {name}!'**
  String hello(Object name);

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get goodEvening;

  /// No description provided for @todaysAttendance.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Attendance'**
  String get todaysAttendance;

  /// No description provided for @checkIn.
  ///
  /// In en, this message translates to:
  /// **'Check-In'**
  String get checkIn;

  /// No description provided for @checkOut.
  ///
  /// In en, this message translates to:
  /// **'Check-Out'**
  String get checkOut;

  /// No description provided for @onTime.
  ///
  /// In en, this message translates to:
  /// **'ON-TIME'**
  String get onTime;

  /// No description provided for @todayStatus.
  ///
  /// In en, this message translates to:
  /// **'Today Status'**
  String get todayStatus;

  /// No description provided for @employee.
  ///
  /// In en, this message translates to:
  /// **'Employee'**
  String get employee;

  /// No description provided for @hrDepartment.
  ///
  /// In en, this message translates to:
  /// **'HR Department'**
  String get hrDepartment;

  /// No description provided for @applyLeave.
  ///
  /// In en, this message translates to:
  /// **'Apply Leave'**
  String get applyLeave;

  /// No description provided for @halfDay.
  ///
  /// In en, this message translates to:
  /// **'Half Day'**
  String get halfDay;

  /// No description provided for @halfDayDate.
  ///
  /// In en, this message translates to:
  /// **'Half Day Date'**
  String get halfDayDate;

  /// No description provided for @fromDate.
  ///
  /// In en, this message translates to:
  /// **'From Date'**
  String get fromDate;

  /// No description provided for @toDate.
  ///
  /// In en, this message translates to:
  /// **'To Date'**
  String get toDate;

  /// No description provided for @reason.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get reason;

  /// No description provided for @enterReason.
  ///
  /// In en, this message translates to:
  /// **'Enter reason for leave'**
  String get enterReason;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get required;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'SUBMIT'**
  String get submit;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select Date'**
  String get selectDate;

  /// No description provided for @selectDateRangeError.
  ///
  /// In en, this message translates to:
  /// **'Please select from and to dates'**
  String get selectDateRangeError;

  /// No description provided for @selectHalfDayDateError.
  ///
  /// In en, this message translates to:
  /// **'Please select half-day date'**
  String get selectHalfDayDateError;

  /// No description provided for @selectLeaveTypeError.
  ///
  /// In en, this message translates to:
  /// **'Please select leave type'**
  String get selectLeaveTypeError;

  /// No description provided for @leaveApplications.
  ///
  /// In en, this message translates to:
  /// **'Leave Applications'**
  String get leaveApplications;

  /// No description provided for @noLeaveApplicationsFound.
  ///
  /// In en, this message translates to:
  /// **'No leave applications found.'**
  String get noLeaveApplicationsFound;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @used.
  ///
  /// In en, this message translates to:
  /// **'Used'**
  String get used;

  /// No description provided for @pending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get pending;

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'Days: {count}'**
  String days(Object count);

  /// No description provided for @dateRange.
  ///
  /// In en, this message translates to:
  /// **'{from} to {to}'**
  String dateRange(Object from, Object to);

  /// No description provided for @approved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get approved;

  /// No description provided for @rejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get rejected;

  /// No description provided for @logTime.
  ///
  /// In en, this message translates to:
  /// **'Log Time'**
  String get logTime;

  /// No description provided for @editTimesheet.
  ///
  /// In en, this message translates to:
  /// **'Edit Timesheet'**
  String get editTimesheet;

  /// No description provided for @approver.
  ///
  /// In en, this message translates to:
  /// **'Approver'**
  String get approver;

  /// No description provided for @projectAssignments.
  ///
  /// In en, this message translates to:
  /// **'Project Assignments'**
  String get projectAssignments;

  /// No description provided for @addProject.
  ///
  /// In en, this message translates to:
  /// **'Add Project'**
  String get addProject;

  /// No description provided for @noProjectsAdded.
  ///
  /// In en, this message translates to:
  /// **'No projects added yet.'**
  String get noProjectsAdded;

  /// No description provided for @totalExpected.
  ///
  /// In en, this message translates to:
  /// **'Total Expected'**
  String get totalExpected;

  /// No description provided for @totalSpent.
  ///
  /// In en, this message translates to:
  /// **'Total Spent'**
  String get totalSpent;

  /// No description provided for @addAssignment.
  ///
  /// In en, this message translates to:
  /// **'Add Assignment'**
  String get addAssignment;

  /// No description provided for @editAssignment.
  ///
  /// In en, this message translates to:
  /// **'Edit Assignment'**
  String get editAssignment;

  /// No description provided for @selectProject.
  ///
  /// In en, this message translates to:
  /// **'Select Project'**
  String get selectProject;

  /// No description provided for @expectedHours.
  ///
  /// In en, this message translates to:
  /// **'Expected Hours'**
  String get expectedHours;

  /// No description provided for @spentHours.
  ///
  /// In en, this message translates to:
  /// **'Spent Hours'**
  String get spentHours;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get select;

  /// No description provided for @addAtLeastOneProjectError.
  ///
  /// In en, this message translates to:
  /// **'Please add at least one project assignment.'**
  String get addAtLeastOneProjectError;

  /// No description provided for @timesheets.
  ///
  /// In en, this message translates to:
  /// **'Timesheets'**
  String get timesheets;

  /// No description provided for @searchTimesheets.
  ///
  /// In en, this message translates to:
  /// **'Search timesheets...'**
  String get searchTimesheets;

  /// No description provided for @noTimesheetsFound.
  ///
  /// In en, this message translates to:
  /// **'No timesheets found.'**
  String get noTimesheetsFound;

  /// No description provided for @totalHours.
  ///
  /// In en, this message translates to:
  /// **'Total Hours: {hours}'**
  String totalHours(Object hours);

  /// No description provided for @spentLabel.
  ///
  /// In en, this message translates to:
  /// **'Spent: {hours}'**
  String spentLabel(Object hours);

  /// No description provided for @draft.
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get draft;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @leaveBalance.
  ///
  /// In en, this message translates to:
  /// **'Leave Balance'**
  String get leaveBalance;

  /// No description provided for @weekHours.
  ///
  /// In en, this message translates to:
  /// **'Week Hours'**
  String get weekHours;

  /// No description provided for @daysCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Days'**
  String daysCount(Object count);

  /// No description provided for @entriesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} Entries'**
  String entriesCount(Object count);

  /// No description provided for @selectLanguage.
  ///
  /// In en, this message translates to:
  /// **'Select Language'**
  String get selectLanguage;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @hindi.
  ///
  /// In en, this message translates to:
  /// **'Hindi'**
  String get hindi;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordInstructions.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address and we\'ll send you a link to reset your password.'**
  String get forgotPasswordInstructions;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLink;

  /// No description provided for @verifyOtp.
  ///
  /// In en, this message translates to:
  /// **'Verify OTP'**
  String get verifyOtp;

  /// No description provided for @enterOtpSentTo.
  ///
  /// In en, this message translates to:
  /// **'Enter OTP sent to {email}'**
  String enterOtpSentTo(Object email);

  /// No description provided for @resendOtp.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get resendOtp;

  /// No description provided for @otpVerifiedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'OTP Verified Successfully'**
  String get otpVerifiedSuccessfully;

  /// No description provided for @pleaseEnterValidOtp.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid OTP'**
  String get pleaseEnterValidOtp;

  /// No description provided for @currentPassword.
  ///
  /// In en, this message translates to:
  /// **'Current Password'**
  String get currentPassword;

  /// No description provided for @newPassword.
  ///
  /// In en, this message translates to:
  /// **'New Password'**
  String get newPassword;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm New Password'**
  String get confirmPassword;

  /// No description provided for @changePassword.
  ///
  /// In en, this message translates to:
  /// **'Change Password'**
  String get changePassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get passwordsDoNotMatch;

  /// No description provided for @atLeastCharactersRequired.
  ///
  /// In en, this message translates to:
  /// **'At least {count} characters required.'**
  String atLeastCharactersRequired(Object count);

  /// No description provided for @inProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get inProgress;

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'HRMS'**
  String get appTitle;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @employeeDetails.
  ///
  /// In en, this message translates to:
  /// **'Employee Details'**
  String get employeeDetails;

  /// No description provided for @employeeName.
  ///
  /// In en, this message translates to:
  /// **'Employee Name'**
  String get employeeName;

  /// No description provided for @datesAndReason.
  ///
  /// In en, this message translates to:
  /// **'Dates & Reason'**
  String get datesAndReason;

  /// No description provided for @summary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get summary;

  /// No description provided for @totalAllocated.
  ///
  /// In en, this message translates to:
  /// **'Total Allocated'**
  String get totalAllocated;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @updateApplication.
  ///
  /// In en, this message translates to:
  /// **'UPDATE APPLICATION'**
  String get updateApplication;

  /// No description provided for @submitApplication.
  ///
  /// In en, this message translates to:
  /// **'SUBMIT APPLICATION'**
  String get submitApplication;

  /// No description provided for @pleaseProvideReason.
  ///
  /// In en, this message translates to:
  /// **'Please provide a reason...'**
  String get pleaseProvideReason;

  /// No description provided for @leaveType.
  ///
  /// In en, this message translates to:
  /// **'Leave Type'**
  String get leaveType;

  /// No description provided for @approve.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approve;

  /// No description provided for @reject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get reject;

  /// No description provided for @deleteLeave.
  ///
  /// In en, this message translates to:
  /// **'Delete Leave'**
  String get deleteLeave;

  /// No description provided for @deleteLeaveWarning.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this leave application?'**
  String get deleteLeaveWarning;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @totalDays.
  ///
  /// In en, this message translates to:
  /// **'Total Days'**
  String get totalDays;

  /// No description provided for @editLeaveApplication.
  ///
  /// In en, this message translates to:
  /// **'Edit Leave Application'**
  String get editLeaveApplication;

  /// No description provided for @leaveApplicationSubmitted.
  ///
  /// In en, this message translates to:
  /// **'Leave application submitted successfully'**
  String get leaveApplicationSubmitted;

  /// No description provided for @searchEmployeeLeaveType.
  ///
  /// In en, this message translates to:
  /// **'Search Employee or Leave Type'**
  String get searchEmployeeLeaveType;

  /// No description provided for @actionCompletedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Action completed successfully'**
  String get actionCompletedSuccessfully;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @calendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get calendar;

  /// No description provided for @searchServices.
  ///
  /// In en, this message translates to:
  /// **'Search services...'**
  String get searchServices;

  /// No description provided for @employeeActions.
  ///
  /// In en, this message translates to:
  /// **'Employee Actions'**
  String get employeeActions;

  /// No description provided for @companyInformation.
  ///
  /// In en, this message translates to:
  /// **'Company Information'**
  String get companyInformation;

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// No description provided for @softwareEngineer.
  ///
  /// In en, this message translates to:
  /// **'Software Engineer'**
  String get softwareEngineer;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @somethingWentWrong.
  ///
  /// In en, this message translates to:
  /// **'Something went wrong'**
  String get somethingWentWrong;

  /// No description provided for @punchOutEarlyWarning.
  ///
  /// In en, this message translates to:
  /// **'You\'re logging out before completing 9hr 30min'**
  String get punchOutEarlyWarning;

  /// No description provided for @confirmLogout.
  ///
  /// In en, this message translates to:
  /// **'Confirm Logout'**
  String get confirmLogout;

  /// No description provided for @punchOutConfirmation.
  ///
  /// In en, this message translates to:
  /// **'You\'ve worked {time} hrs. Are you sure you want to log out?'**
  String punchOutConfirmation(Object time);

  /// No description provided for @yesLogOut.
  ///
  /// In en, this message translates to:
  /// **'Yes, log out'**
  String get yesLogOut;

  /// No description provided for @onBreak.
  ///
  /// In en, this message translates to:
  /// **'On Break'**
  String get onBreak;

  /// No description provided for @present.
  ///
  /// In en, this message translates to:
  /// **'Present'**
  String get present;

  /// No description provided for @takeBreak.
  ///
  /// In en, this message translates to:
  /// **'Take a break'**
  String get takeBreak;

  /// No description provided for @thatsAllForToday.
  ///
  /// In en, this message translates to:
  /// **'That\'s all for today'**
  String get thatsAllForToday;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processing;

  /// No description provided for @companyName.
  ///
  /// In en, this message translates to:
  /// **'DHIRA'**
  String get companyName;

  /// No description provided for @companyWebsite.
  ///
  /// In en, this message translates to:
  /// **'www.dhira.ai'**
  String get companyWebsite;

  /// No description provided for @searchEmployeeOrLeaveType.
  ///
  /// In en, this message translates to:
  /// **'Search Employee or Leave Type'**
  String get searchEmployeeOrLeaveType;

  /// No description provided for @personalDetails.
  ///
  /// In en, this message translates to:
  /// **'Personal Details'**
  String get personalDetails;

  /// No description provided for @maritalStatus.
  ///
  /// In en, this message translates to:
  /// **'Marital Status'**
  String get maritalStatus;

  /// No description provided for @bloodGroup.
  ///
  /// In en, this message translates to:
  /// **'Blood Group'**
  String get bloodGroup;

  /// No description provided for @dateOfJoining.
  ///
  /// In en, this message translates to:
  /// **'Date of Joining'**
  String get dateOfJoining;

  /// No description provided for @companyDetails.
  ///
  /// In en, this message translates to:
  /// **'Company Details'**
  String get companyDetails;

  /// No description provided for @orgDepartment.
  ///
  /// In en, this message translates to:
  /// **'Org Department'**
  String get orgDepartment;

  /// No description provided for @division.
  ///
  /// In en, this message translates to:
  /// **'Division'**
  String get division;

  /// No description provided for @employmentType.
  ///
  /// In en, this message translates to:
  /// **'Employment Type'**
  String get employmentType;

  /// No description provided for @reportingDetails.
  ///
  /// In en, this message translates to:
  /// **'Reporting Details'**
  String get reportingDetails;

  /// No description provided for @reportsTo.
  ///
  /// In en, this message translates to:
  /// **'Reports To'**
  String get reportsTo;

  /// No description provided for @reportsToName.
  ///
  /// In en, this message translates to:
  /// **'Reports To Name'**
  String get reportsToName;

  /// No description provided for @updateProfileQuestion.
  ///
  /// In en, this message translates to:
  /// **'Need to update your profile details?'**
  String get updateProfileQuestion;

  /// No description provided for @updateProfileInstructions.
  ///
  /// In en, this message translates to:
  /// **'Please reach out to HR Department or your Admin for any changes to your personal or professional information.'**
  String get updateProfileInstructions;

  /// No description provided for @addressAndContact.
  ///
  /// In en, this message translates to:
  /// **'Address & Contact'**
  String get addressAndContact;

  /// No description provided for @contactInformation.
  ///
  /// In en, this message translates to:
  /// **'Contact Information'**
  String get contactInformation;

  /// No description provided for @companyEmail.
  ///
  /// In en, this message translates to:
  /// **'Company Email'**
  String get companyEmail;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @emergencyContact.
  ///
  /// In en, this message translates to:
  /// **'Emergency Contact'**
  String get emergencyContact;

  /// No description provided for @addressInformation.
  ///
  /// In en, this message translates to:
  /// **'Address Information'**
  String get addressInformation;

  /// No description provided for @currentAddress.
  ///
  /// In en, this message translates to:
  /// **'Current Address'**
  String get currentAddress;

  /// No description provided for @permanentAddress.
  ///
  /// In en, this message translates to:
  /// **'Permanent Address'**
  String get permanentAddress;

  /// No description provided for @userProfile.
  ///
  /// In en, this message translates to:
  /// **'User Profile'**
  String get userProfile;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @projectName.
  ///
  /// In en, this message translates to:
  /// **'Project Name'**
  String get projectName;

  /// No description provided for @projectLead.
  ///
  /// In en, this message translates to:
  /// **'Project Lead'**
  String get projectLead;

  /// No description provided for @noAssignmentsFound.
  ///
  /// In en, this message translates to:
  /// **'No assignments found'**
  String get noAssignmentsFound;

  /// No description provided for @designation.
  ///
  /// In en, this message translates to:
  /// **'Designation'**
  String get designation;

  /// No description provided for @notAssigned.
  ///
  /// In en, this message translates to:
  /// **'Not Assigned'**
  String get notAssigned;

  /// No description provided for @submissionFailed.
  ///
  /// In en, this message translates to:
  /// **'Submission failed'**
  String get submissionFailed;

  /// No description provided for @updateFailed.
  ///
  /// In en, this message translates to:
  /// **'Update failed'**
  String get updateFailed;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @executivePresence.
  ///
  /// In en, this message translates to:
  /// **'Executive Presence'**
  String get executivePresence;

  /// No description provided for @letsGo.
  ///
  /// In en, this message translates to:
  /// **'Let\'s Go!'**
  String get letsGo;

  /// No description provided for @empIdLabel.
  ///
  /// In en, this message translates to:
  /// **'EMP ID: {id}'**
  String empIdLabel(Object id);

  /// No description provided for @daysPresent.
  ///
  /// In en, this message translates to:
  /// **'Days Present'**
  String get daysPresent;

  /// No description provided for @upcomingHoliday.
  ///
  /// In en, this message translates to:
  /// **'Upcoming Holiday'**
  String get upcomingHoliday;

  /// No description provided for @viewAll.
  ///
  /// In en, this message translates to:
  /// **'VIEW ALL'**
  String get viewAll;

  /// No description provided for @compensatoryOff.
  ///
  /// In en, this message translates to:
  /// **'Compensatory Off'**
  String get compensatoryOff;

  /// No description provided for @attendanceRegularization.
  ///
  /// In en, this message translates to:
  /// **'Attendance Regularization'**
  String get attendanceRegularization;

  /// No description provided for @organizationHierarchy.
  ///
  /// In en, this message translates to:
  /// **'Organization Hierarchy'**
  String get organizationHierarchy;

  /// No description provided for @projectBasedServiceChart.
  ///
  /// In en, this message translates to:
  /// **'Project Based Service Chart'**
  String get projectBasedServiceChart;

  /// No description provided for @myOrg.
  ///
  /// In en, this message translates to:
  /// **'My Org'**
  String get myOrg;

  /// No description provided for @helloLabel.
  ///
  /// In en, this message translates to:
  /// **'Hello,'**
  String get helloLabel;

  /// No description provided for @welcomeName.
  ///
  /// In en, this message translates to:
  /// **'Welcome {name}!'**
  String welcomeName(Object name);

  /// No description provided for @timeElapsed.
  ///
  /// In en, this message translates to:
  /// **'Time Elapsed'**
  String get timeElapsed;

  /// No description provided for @startedDayAt.
  ///
  /// In en, this message translates to:
  /// **'Started day at {time}'**
  String startedDayAt(Object time);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'hi':
      return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
