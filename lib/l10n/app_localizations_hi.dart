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
  String get passwordsDoNotMatch => 'पासवर्ड मेल একসাথে।';

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
  String get employeeDetails => 'कर्मचारी विवरण';

  @override
  String get employeeName => 'कर्मचारी का नाम';

  @override
  String get datesAndReason => 'तारीखें और कारण';

  @override
  String get summary => 'सारांश';

  @override
  String get totalAllocated => 'कुल आवंटित';

  @override
  String get update => 'अपडेट करें';

  @override
  String get updateApplication => 'आवेदन अपडेट करें';

  @override
  String get submitApplication => 'आवेदन जमा करें';

  @override
  String get pleaseProvideReason => 'कृपया कारण बताएं...';

  @override
  String get leaveType => 'छुट्टी का प्रकार';

  @override
  String get approve => 'अनुमोदित करें';

  @override
  String get reject => 'अस्वीकार करें';

  @override
  String get deleteLeave => 'छुट्टी हटाएं';

  @override
  String get deleteLeaveWarning =>
      'क्या आप वाकई इस छुट्टी आवेदन को हटाना चाहते हैं?';

  @override
  String get yes => 'हाँ';

  @override
  String get no => 'नहीं';

  @override
  String get duration => 'अवधि';

  @override
  String get totalDays => 'कुल दिन';

  @override
  String get editLeaveApplication => 'छुट्टी आवेदन संपादित करें';

  @override
  String get leaveApplicationSubmitted =>
      'छुट्टी का आवेदन सफलतापूर्वक जमा किया गया';

  @override
  String get searchEmployeeLeaveType => 'कर्मचारी या छुट्टी के प्रकार खोजें';

  @override
  String get actionCompletedSuccessfully => 'कार्य सफलतापूर्वक पूरा हुआ';

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

  @override
  String get somethingWentWrong => 'कुछ गलत हो गया';

  @override
  String get punchOutEarlyWarning =>
      'आप 9 घंटे 30 मिनट पूरे करने से पहले लॉग आउट कर रहे हैं';

  @override
  String get confirmLogout => 'लॉग आउट की पुष्टि करें';

  @override
  String punchOutConfirmation(Object time) {
    return 'आपने $time घंटे काम किया है। क्या आप वाकई लॉग आउट करना चाहते हैं?';
  }

  @override
  String get yesLogOut => 'हाँ, लॉग आउट करें';

  @override
  String get onBreak => 'ब्रेक पर';

  @override
  String get present => 'उपस्थित';

  @override
  String get takeBreak => 'ब्रेक लें';

  @override
  String get thatsAllForToday => 'आज के लिए बस इतना ही';

  @override
  String get resume => 'फिर से शुरू करें';

  @override
  String get processing => 'प्रसंस्करण...';

  @override
  String get companyName => 'धीरा';

  @override
  String get companyWebsite => 'www.dhira.ai';

  @override
  String get searchEmployeeOrLeaveType => 'कर्मचारी या छुट्टी का प्रकार खोजें';

  @override
  String get personalDetails => 'व्यक्तिगत विवरण';

  @override
  String get maritalStatus => 'वैवाहिक स्थिति';

  @override
  String get bloodGroup => 'रक्त समूह';

  @override
  String get dateOfJoining => 'शामिल होने की तिथि';

  @override
  String get companyDetails => 'कंपनी विवरण';

  @override
  String get orgDepartment => 'संगठन विभाग';

  @override
  String get division => 'प्रभाग';

  @override
  String get employmentType => 'रोजगार प्रकार';

  @override
  String get reportingDetails => 'रिपोर्टिंग विवरण';

  @override
  String get reportsTo => 'इन्हें रिपोर्ट करें';

  @override
  String get reportsToName => 'रिपोर्टिंग अधिकारी का नाम';

  @override
  String get updateProfileQuestion =>
      'अपनी प्रोफ़ाइल विवरण अपडेट करना चाहते हैं?';

  @override
  String get updateProfileInstructions =>
      'कृपया अपनी व्यक्तिगत या व्यावसायिक जानकारी में किसी भी बदलाव के लिए मानव संसाधन विभाग या अपने एडमिन से संपर्क करें।';

  @override
  String get addressAndContact => 'पता और संपर्क';

  @override
  String get contactInformation => 'संपर्क जानकारी';

  @override
  String get companyEmail => 'कंपनी ईमेल';

  @override
  String get phone => 'फ़ोन';

  @override
  String get emergencyContact => 'आपातकालीन संपर्क';

  @override
  String get addressInformation => 'पता जानकारी';

  @override
  String get currentAddress => 'वर्तमान पता';

  @override
  String get permanentAddress => 'स्थायी पता';

  @override
  String get userProfile => 'उपयोगकर्ता प्रोफ़ाइल';

  @override
  String get overview => 'अवलोकन';

  @override
  String get projectName => 'परियोजना का नाम';

  @override
  String get projectLead => 'परियोजना लीड';

  @override
  String get noAssignmentsFound => 'कोई असाइनमेंट नहीं मिला';

  @override
  String get designation => 'पद';

  @override
  String get notAssigned => 'सौंपा नहीं गया';

  @override
  String get submissionFailed => 'प्रस्तुति विफल रही';

  @override
  String get updateFailed => 'अपडेट विफल रहा';

  @override
  String get delete => 'हटाएं';

  @override
  String get open => 'खुला';

  @override
  String get myAction => 'मेरे कार्य';

  @override
  String get leaveRequest => 'छुट्टी का अनुरोध';

  @override
  String get attendanceRequest => 'उपस्थिति अनुरोध';

  @override
  String get timesheetRequest => 'समय पत्रक अनुरोध';

  @override
  String get comOff => 'कॉम-ऑफ';
}
