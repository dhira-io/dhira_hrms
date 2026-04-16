// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get home => 'होम';

  @override
  String get yourOverview => 'आपका अवलोकन';

  @override
  String get signIn => 'साइन इन करें';

  @override
  String get email => 'ईमेल';

  @override
  String get emailAddress => 'ईमेल पता';

  @override
  String get enterEmail => 'अपना ईमेल दर्ज करें';

  @override
  String get emailRequired => 'ईमेल आवश्यक है';

  @override
  String get enterValidEmail => 'मान्य ईमेल दर्ज करें';

  @override
  String get password => 'पासवर्ड';

  @override
  String get enterPassword => 'अपना पासवर्ड दर्ज करें';

  @override
  String get passwordRequired => 'पासवर्ड आवश्यक है';

  @override
  String get passwordTooShort => 'पासवर्ड बहुत छोटा है';

  @override
  String get forgotPassword => 'पासवर्ड भूल गए?';

  @override
  String get or => 'या';

  @override
  String get loginWith => 'लॉगिन करें';

  @override
  String get office365 => 'ऑफिस 365';

  @override
  String get attendance => 'उपस्थिति';

  @override
  String get organizations => 'संगठन';

  @override
  String get myTasks => 'मेरे कार्य';

  @override
  String get noAttendanceFound => 'कोई उपस्थिति लॉग नहीं मिला।';

  @override
  String get quickActions => 'त्वरित कार्य';

  @override
  String get tasks => 'कार्य';

  @override
  String get timesheet => 'टाइमशीट';

  @override
  String get leave => 'छुट्टी';

  @override
  String get team => 'टीम';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get department => 'विभाग';

  @override
  String get location => 'स्थान';

  @override
  String get priority => 'प्राथमिकता';

  @override
  String get due => 'नियत';

  @override
  String get myProfile => 'मेरी प्रोफ़ाइल';

  @override
  String get gallery => 'गैलरी';

  @override
  String get camera => 'कैमरा';

  @override
  String get firstName => 'पहला नाम';

  @override
  String get lastName => 'अंतिम नाम';

  @override
  String get birthDate => 'जन्म तिथि';

  @override
  String get gender => 'लिंग';

  @override
  String get deskTheme => 'डेस्क थीम';

  @override
  String get notAvailable => 'लागू नहीं';

  @override
  String get defaultVal => 'डिफ़ॉल्ट';

  @override
  String get viewOrgChart => 'संगठन चार्ट देखें';

  @override
  String get noOrganizationsFound => 'कोई संगठन नहीं मिला';

  @override
  String get organizationChart => 'संगठन चार्ट';

  @override
  String get noTasksFound => 'कोई कार्य नहीं मिला';

  @override
  String get punchIn => 'पंच इन';

  @override
  String get punchOut => 'पंच आउट';

  @override
  String hello(Object name) {
    return 'नमस्ते, $name!';
  }

  @override
  String get goodMorning => 'सुप्रभात';

  @override
  String get goodAfternoon => 'नमस्कार';

  @override
  String get goodEvening => 'शुभ संध्या';

  @override
  String get todaysAttendance => 'आज की उपस्थिति';

  @override
  String get checkIn => 'चेक-इन';

  @override
  String get checkOut => 'चेक-आउट';

  @override
  String get onTime => 'समय पर';

  @override
  String get todayStatus => 'आज की स्थिति';

  @override
  String get employee => 'कर्मचारी';

  @override
  String get hrDepartment => 'मानव संसाधन विभाग';

  @override
  String get applyLeave => 'छुट्टी के लिए आवेदन करें';

  @override
  String get halfDay => 'आधा दिन';

  @override
  String get halfDayDate => 'आधे दिन की तारीख';

  @override
  String get fromDate => 'शुरूआत की तारीख';

  @override
  String get toDate => 'अंतिम तारीख';

  @override
  String get reason => 'कारण';

  @override
  String get enterReason => 'छुट्टी का कारण दर्ज करें';

  @override
  String get required => 'आवश्यक';

  @override
  String get submit => 'जमा करें';

  @override
  String get selectDate => 'तारीख चुनें';

  @override
  String get selectDateRangeError => 'कृपया शुरू और अंतिम तारीख चुनें';

  @override
  String get selectHalfDayDateError => 'कृपया आधे दिन की तारीख चुनें';

  @override
  String get selectLeaveTypeError => 'कृपया छुट्टी का प्रकार चुनें';

  @override
  String get leaveApplications => 'छुट्टी के आवेदन';

  @override
  String get noLeaveApplicationsFound => 'कोई छुट्टी आवेदन नहीं मिला।';

  @override
  String get total => 'कुल';

  @override
  String get used => 'उपयोग किया गया';

  @override
  String get pending => 'लंबित';

  @override
  String get available => 'उपलब्ध';

  @override
  String days(Object count) {
    return 'दिन: $count';
  }

  @override
  String dateRange(Object from, Object to) {
    return '$from से $to';
  }

  @override
  String get approved => 'स्वीकृत';

  @override
  String get rejected => 'अस्वीकृत';

  @override
  String get logTime => 'समय दर्ज करें';

  @override
  String get editTimesheet => 'टाइमशीट संपादित करें';

  @override
  String get approver => 'अनुमोदक';

  @override
  String get projectAssignments => 'परियोजना असाइनमेंट';

  @override
  String get addProject => 'परियोजना जोड़ें';

  @override
  String get noProjectsAdded => 'अभी तक कोई परियोजना नहीं जोड़ी गई है।';

  @override
  String get totalExpected => 'कुल अपेक्षित';

  @override
  String get totalSpent => 'कुल खर्च';

  @override
  String get addAssignment => 'असाइनमेंट जोड़ें';

  @override
  String get editAssignment => 'असाइनमेंट संपादित करें';

  @override
  String get selectProject => 'परियोजना चुनें';

  @override
  String get expectedHours => 'अपेक्षित घंटे';

  @override
  String get spentHours => 'खर्च किए गए घंटे';

  @override
  String get description => 'विवरण';

  @override
  String get cancel => 'रद्द करें';

  @override
  String get save => 'सहेजें';

  @override
  String get select => 'चुनें';

  @override
  String get addAtLeastOneProjectError =>
      'कृपया कम से कम एक परियोजना असाइनमेंट जोड़ें।';

  @override
  String get timesheets => 'टाइमशीट';

  @override
  String get searchTimesheets => 'टाइमशीट खोजें...';

  @override
  String get noTimesheetsFound => 'कोई टाइमशीट नहीं मिली।';

  @override
  String totalHours(Object hours) {
    return 'कुल घंटे: $hours';
  }

  @override
  String spentLabel(Object hours) {
    return 'खर्च: $hours';
  }

  @override
  String get draft => 'ड्राफ्ट';

  @override
  String get saved => 'सहेजा गया';

  @override
  String get edit => 'संपादित करें';

  @override
  String get leaveBalance => 'छुट्टी का शेष';

  @override
  String get weekHours => 'सप्ताह के घंटे';

  @override
  String daysCount(Object count) {
    return '$count दिन';
  }

  @override
  String entriesCount(Object count) {
    return '$count प्रविष्टियाँ';
  }

  @override
  String get selectLanguage => 'भाषा चुनें';

  @override
  String get english => 'English';

  @override
  String get hindi => 'हिन्दी';

  @override
  String get forgotPasswordTitle => 'पासवर्ड भूल गए?';

  @override
  String get forgotPasswordInstructions =>
      'अपना ईमेल पता दर्ज करें और हम आपको अपना पासवर्ड रीसेट करने के लिए एक लिंक भेजेंगे।';

  @override
  String get sendResetLink => 'रीसेट लिंक भेजें';

  @override
  String get verifyOtp => 'ओटीपी सत्यापित करें';

  @override
  String enterOtpSentTo(Object email) {
    return '$email पर भेजे गए ओटीपी को दर्ज करें';
  }

  @override
  String get resendOtp => 'ओटीपी पुनः भेजें';

  @override
  String get otpVerifiedSuccessfully => 'ओटीपी सफलतापूर्वक सत्यापित किया गया';

  @override
  String get pleaseEnterValidOtp => 'कृपया एक मान्य ओटीपी दर्ज करें';

  @override
  String get currentPassword => 'वर्तमान पासवर्ड';

  @override
  String get newPassword => 'नया पासवर्ड';

  @override
  String get confirmPassword => 'नए पासवर्ड की पुष्टि करें';

  @override
  String get changePassword => 'पासवर्ड बदलें';

  @override
  String get passwordsDoNotMatch => 'पासवर्ड मेल नहीं खाते।';

  @override
  String atLeastCharactersRequired(Object count) {
    return 'कम से कम $count वर्ण आवश्यक हैं।';
  }

  @override
  String get inProgress => 'प्रगति में';

  @override
  String get appTitle => 'HRMS';

  @override
  String get ok => 'ठीक';

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
  String get signOut => 'साइन आउट';

  @override
  String get calendar => 'कैलेंडर';

  @override
  String get searchServices => 'सेवाएँ खोजें...';

  @override
  String get employeeActions => 'कर्मचारी कार्य';

  @override
  String get companyInformation => 'कंपनी की जानकारी';

  @override
  String get noResultsFound => 'कोई परिणाम नहीं मिला';

  @override
  String get softwareEngineer => 'सॉफ्टवेयर इंजीनियर';

  @override
  String get user => 'उपयोगकर्ता';
}
