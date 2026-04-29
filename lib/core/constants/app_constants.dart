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
  static const double p56 = 56.0;
  static const double p100 = 100.0;
  static const double p140 = 140.0;
  static const double p150 = 150.0;
  static const double p180 = 180.0;
  static const double p250 = 250.0;

  // Border Radius
  static const double r8 = 8.0;
  static const double r10 = 10.0;
  static const double r12 = 12.0;
  static const double r16 = 16.0;
  static const double r20 = 20.0;
  static const double r24 = 24.0;

  // Icon Sizes
  static const double iconSmall = 18.0;
  static const double iconMedium = 24.0;
  static const double iconLarge = 32.0;
  static const double iconXSmall = 20.0;
  static const double iconXXSmall = 28.0;
  static const double iconXLarge = 56.0;

  // Animation durations
  static const int animFast = 200;
  static const int animNormal = 300;
  static const int animSlow = 500;

  // Formatting
  static const String dateFormatDefault = 'dd-MM-yyyy';
  static const String apiDateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String timeFormat12hr = 'h:mm a';
  static const String dateDisplayFormat = 'MMM dd, yyyy';
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

  // Doc Status
  static const int docStatusDraft = 0;

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

class TimesheetStatus {
  static const String draft = 'Draft';
  static const String approved = 'Approved';
}
