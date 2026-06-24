import 'package:flutter/material.dart';

class AppColors {
  // Primary Palette
  static const Color primary = Color(0xFF0047CC);
  static const Color primaryContainer = Color(0xFF155DFC);
  static const Color primaryFixed = Color(0xFFDCE1FF);
  static const Color onPrimaryFixed = Color(0xFF00164E);
  static const Color secondary = Color(0xff0066FF);

  static const Color username = Color(0xFF111827);

  // Neutral Palette
  static const Color background = Color(0xFFF8F9FA);
  static const Color surface = Color(0xFFF8F9FA);
  static const Color onSurface = Color(0xFF191C1D);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF3F4F5);
  static const Color onSurfaceVariant = Color(0xFF434656);
  static const Color textPrimary = Color(0xff191C1D);
  static const Color textSecondary = Color(0xff4B5563);
  static const Color border = Color(0xffE5E7EB);
  static const Color bordergrey = Color(0xffE9E9E9);
  static const Color tableBorder = Color(0xFFCAD5E2);
  static const Color outlineVariant = Color(0xFFC3C5D9);
  static const Color onSecondaryFixedVariant = Color(0xFF3F484F);
  static const Color primaryBlue = Color(0xff1100CC);

  // HTML Mockup Colors
  static const Color onPrimary = Color(0xffffffff);
  static const Color onPrimaryContainer = Color(0xffeceeff);
  static const Color secondaryDark = Color(0xff575f67);
  static const Color onSecondary = Color(0xffffffff);
  static const Color secondaryContainer = Color(0xffd8e1ea);
  static const Color onSecondaryContainer = Color(0xff5b646b);
  static const Color tertiary = Color(0xff992f00);
  static const Color onTertiary = Color(0xffffffff);
  static const Color tertiaryContainer = Color(0xffc33e00);
  static const Color onTertiaryContainer = Color(0xffffebe5);
  static const Color onTertiaryFixed = Color(0xff390c00);
  static const Color surfaceContainer = Color(0xffedeeef);
  static const Color surfaceContainerHigh = Color(0xffe7e8e9);
  static const Color surfaceContainerHighest = Color(0xffe1e3e4);
  static const Color outline = Color(0xff737687);
  static const Color errorContainer = Color(0xffffdad6);
  static const Color onErrorContainer = Color(0xff93000a);
  static const Color successContainer = Color(0xFFDCFCE7);
  static const Color warningContainer = Color(0xFFFEF9C3);

  static const Color onPrimaryFixedVariant = Color(0xFF003BAF);

  // Status Colors
  static const Color success = Color(0xff10B981);
  static const Color successDark = Color(0xff15803d);
  static const Color error = Color(0xffba1a1a);
  static const Color errorDark = Color(0xffb91c1c);
  static const Color warning = Color(0xffF59E0B);
  static const Color warningLight = Color(0xffffedd5);
  static const Color warningDark = Color(0xffc2410c);
  static const Color pending = Color(0xffF59E0B);
  static const Color draft = Color(0xff6B7280);
  static const Color accent = Color(0xff18bbee);
  static const Color tertiaryFixed = Color(0xFFFFDBD0);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
  static const Color placeholdergrey = Color(0xff9E9E9E);
  static const Color confirmationRedBg = Color(0xFFFEF2F2);

  // Status Palettes (Tailwind-like)
  static const Color info = Color(0xFF0369A1);
  static const Color infoBg = Color(0xFFE0F2FE);
  static const Color infoBorder = Color(0xFFBAE6FD);
  static const Color quickStatsBg = Color(0xFFF0F9FF);

  static const Color successBg = Color(0xFFDCFCE7);
  static const Color successBorder = Color(0xFFBBF7D0);

  static const Color warningBg = Color(0xFFFEF9C3);
  static const Color warningBorder = Color(0xFFFEF08A);

  static const Color errorBg = Color(0xFFFEE2E2);
  static const Color errorBorder = Color(0xFFFECACA);

  //dashboard
  static const Color attendancebg = Color(0xFFEDE9FE);
  static const Color calendarupicon = Color(0xFF3D6300);
  static const Color timesheeticon = Color(0xFF00598A);
  static const Color compofficon = Color(0xFF005F5A);
  static const Color attendanceicon = Color(0xFF5D0EC0);

  // Icon Backgrounds
  static const Color iconbgblue = Color(0xffE3F2FD);
  static const Color iconbggreen = Color(0xffE8F5E9);
  static const Color iconbgviolet = Color(0xffF3E5F5);
  static const Color iconbgred = Color(0xffFFEBEE);
  static const Color iconbgorange = Color(0xffFFF3E0);

  // Profile Specific
  static const Color profileHeaderBg = Color(0xFFEBFDFF);
  static const Color profileTabBg = Color(0xFFF1F5F9);
  static const Color profileInfoCardBg = Color(0xFFF4F9FF);
  static const Color profileBadgeBorder = Color(0xFFB3E5FC);
  static const Color profileBadgeBg = Color(0xFFF3E5F5);
  static const Color updateCardBorder = Color(0xFFBBDEFB);

  // Welcome Screen Custom Glow Shadows
  static const Color welcomeShadow1 = Color(0x0DFFCCCC);
  static const Color welcomeShadow2 = Color(0x0AFFCCCC);
  static const Color welcomeShadow3 = Color(0x08FFCCCC);
  static const Color welcomeShadow4 = Color(0x03FFCCCC);

  // Welcome Screen Dark Mode
  static const Color _darkWelcomeScaffoldBg = Color(0xFF0D1117);
  static const Color _darkWelcomeTopBg = Color(0xFF0D2137);
  static const Color _darkWelcomeTitlePrimary = Color(0xFFE8EDF2);
  static const Color _darkWelcomeSubtitle = Color(0xFF8899AA);

  // Additional Utils
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate500Confirmation = Color(0xFF62748E);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);
  static const Color slate950 = Color(0xFF020618);
  static const Color gray400 = Color(0xFF99A1AF);
  static const Color darkGradientEnd = Color(0xFF0B0C10);
  static const Color lightGrey = Color(0xFFEEEEEE);
  static const Color charcoal = Color(0xFF101828);
  static const Color slateGrey = Color(0xFF475467);

  // Timesheet HTML Colors
  static const Color colorBlue50 = Color(0xFFEFF6FF);
  static const Color colorBlue200 = Color(0xFFBEDBFF);
  static const Color colorBlue300 = Color(0xFF8EC5FF);
  static const Color colorBlue400 = Color(0xFF51A2FF);
  static const Color colorBlue500 = Color(0xFF2B7FFF);
  static const Color colorBlue600 = Color(0xFF155DFC);
  static const Color colorNeutral100 = Color(0xFFF5F5F5);
  static const Color colorNeutral200 = Color(0xFFE5E5E5);
  static const Color colorNeutral400 = Color(0xFFA1A1A1);
  static const Color colorGreen50 = Color(0xFFF0FDF4);
  static const Color colorGreen200 = Color(0xFFB9F8CF);
  static const Color colorGreen300 = Color(0xFF7BF1A8);
  static const Color colorGreen600 = Color(0xFF00A63E);
  static const Color colorGreen700 = Color(0xFF008236);
  static const Color colorOrange50 = Color(0xFFFFF7ED);
  static const Color colorOrange200 = Color(0xFFFFD6A8);
  static const Color colorOrange300 = Color(0xFFFFB86A);
  static const Color colorOrange400 = Color(0xFFFF8904);
  static const Color colorOrange500 = Color(0xFFFF6900);
  static const Color colorOrange600 = Color(0xFFF54A00);
  static const Color colorEmerald400 = Color(0xFF00D492);
  static const Color colorEmerald500 = Color(0xFF008236);
  static const Color colorRed500 = Color(0xFFFB2C36);
  static const Color colorRed300 = Color(0xFFFF6467);
  static const Color colorRed600 = Color(0xFFE7000B);
  static const Color purpleHoliday = Color(0xFF9810FA);
  static const Color blueAttendance = Color(0xFF3B82F6);

  // Attendance Status Colors
  static const Color presentText = Color(0xFF00A63E);
  static const Color presentBg = Color(0xFFDCFCE7);
  static const Color holidayText = Color(0xFF9810FA);
  static const Color holidayBg = Color(0xFFF3E8FF);
  static const Color leaveText = Color(0xFF0084D1);
  static const Color leaveBg = Color(0xFFDFF2FE);
  static const Color absentText = Color(0xFFE7000B);
  static const Color absentBg = Color(0xFFFFE2E2);
  static const Color weekendText = Color(0xFF4A5565);
  static const Color weekendBg = Color(0xFFF4F4F5);
  static const Color slateBg = Color(0xFFF1F5F9);
  static const Color slateText = Color(0xFF64748B);
  static const Color blueIcon = Color(0xFF3B82F6);
  static const Color darkSlate = Color(0xFF1E293B);

  // New Calendar Colors
  static const Color calendarDefaultBg = Color(0xFFF8FAFC);
  static const Color calendarDefaultText = Color(0xFF45556C);
  static const Color calendarTodayBorder = Color(0xFF2B7FFF);
  static const Color calendarDayLabel = Color(0xFF475569);

  // Attendance Month Summary Colors
  static const Color monthSummaryPresentBg = Color(0xFFDCFCE7);
  static const Color monthSummaryPresentText = Color(0xFF00A63E);
  static const Color monthSummaryAbsentBg = Color(0xFFFFE2E2);
  static const Color monthSummaryAbsentText = Color(0xFFE7000B);
  static const Color monthSummaryLeaveBg = Color(0xFFDBEAFE);
  static const Color monthSummaryLeaveText = Color(0xFF1E40AF);
  static const Color monthSummaryHolidayBg = Color(0xFFF3E8FF);
  static const Color monthSummaryHolidayText = Color(0xFF6B21A8);

  // Legend Item Colors
  static const Color halfDayText = Color(0xFF9A3412);
  static const Color halfDayBg = Color(0xFFFFF7ED);

  // Leave Status Colors
  static const Color approvedBg = Color(0xFFDCFCE7);
  static const Color approvedText = Color(0xFF166534);
  static const Color pendingStatusBg = Color(0xFFFEF9C3);
  static const Color pendingStatusText = Color(0xFF854D0E);
  static const Color cancelledBg = Color(0xFFF6F3F4);
  static const Color cancelledText = Color(0xFF364153);
  static const Color rejectedBg = Color(0xFFFEEBEE);
  static const Color rejectedText = Color(0xFFC62828);

  // Leave Type Specific Palette
  static const Color bereavementProgress = Color(0xFF00BBA7);
  static const Color bereavementTrack = Color(0xFFCBFBF1);
  static const Color bereavementText = Color(0xFF00BBA7);

  static const Color casualProgress = Color(0xFFA855F7);
  static const Color casualTrack = Color(0xFFE9D5FF);
  static const Color casualText = Color(0xFF9333EA);

  static const Color earnedProgress = Color(0xFF3B82F6);
  static const Color earnedTrack = Color(0xFFBFDBFE);
  static const Color earnedText = Color(0xFF2563EB);

  static const Color restrictedProgress = Color(0xFFF3B81F);
  static const Color restrictedTrack = Color(0xFFFCE9B9);
  static const Color restrictedText = Color(0xFFF3B81F);

  static const Color sickProgress = Color(0xFF22C55E);
  static const Color sickTrack = Color(0xFFBBF7D0);
  static const Color sickText = Color(0xFF16A34A);

  static const Color paternityProgress = Color(0xFFF6339A);
  static const Color paternityTrack = Color(0xFFFFD0F0);
  static const Color paternityText = Color(0xFFF6339A);

  static const Color maternityProgress = Color(0xFF0047CC); // Current primary
  static const Color maternityTrack = Color(0xffE5E7EB); // Current border
  static const Color maternityText = Color(0xFF0047CC); // Current primary

  static const Color compensatoryProgress = Color(0xFF6366F1);
  static const Color compensatoryTrack = Color(0xFFE0E7FF);
  static const Color compensatoryText = Color(0xFF4338CA);

  // Shimmer Colors
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);

  // Brand Colors
  static const Color brandBlue = Color(0xFF0084D1);
  static const Color brandPurple = Color(0xFF8200DB);

  // Punch Card Colors
  // Punch Card Colors
  static const Color punchBreak = Color(0xFFff6900);
  static const Color punchOut = Color(0xFFda2529);
  static const Color pmsSuccess = Color(0xFF0F9D58);

  // Splash Screen Colors
  static const Color splashGradientStart = Color(0xFFBEDBFF);
  static const Color splashGradientMiddle = Color(0xFFFFFFFF);
  static const Color splashGradientEnd = Color(0xFFC4B4FF);

  static const Color _darkSplashGradientStart = Color(0xFF0F172A);
  static const Color _darkSplashGradientMiddle = Color(0xFF020617);
  static const Color _darkSplashGradientEnd = Color(0xFF1E293B);

  // --- Dark palette structural counterparts ---
  static const Color _darkBackground = Color(0xFF121212);
  static const Color _darkSurface = Color(0xFF1E1E1E);
  static const Color _darkTextPrimary = Color(0xFFE1E1E1);
  static const Color _darkTextSecondary = Color(0xFFA0A0A0);
  static const Color _darkBorder = Color(0xFF3A3A3A);
  static const Color _darkTableBorder = Color(0xFF3A3A3A);
  static const Color _darkSurfaceContainerLowest = Color(0xFF1A1A1A);
  static const Color _darkSurfaceContainerLow = Color(0xFF252525);
  static const Color _darkSurfaceContainerHigh = Color(0xFF333333);
  static const Color _darkSurfaceContainerHighest = Color(0xFF3E3E3E);
  static const Color _darkOutlineVariant = Color(0xFF555555);
  static const Color _darkOnSurfaceVariant = Color(0xFFB0B0B0);
  static const Color _darkOnSurface = Color(0xFFE1E1E1);
  static const Color _darkSurfaceContainer = Color(0xFF2C2C2C);
  static const Color _darkOutline = Color(0xFF6B7280);

  static const Color _darkCalendarDefaultBg = Color(0xFF1A1A1A);
  static const Color _darkCalendarDefaultText = Color(0xFFE1E1E1);
  static const Color _darkCalendarDayLabel = Color(0xFFA0A0A0);

  // Slate alternatives for dark mode
  static const Color _darkSlateBg = Color(0xFF1E293B);
  static const Color _darkSlate50 = Color(0xFF0F172A);
  static const Color _darkSlate100 = Color(0xFF1E293B);
  static const Color _darkSlate200 = Color(0xFF334155);

  // Timesheet colors for dark mode
  static const Color _darkColorBlue50 = Color(0xFF0F2D5C);
  static const Color _darkColorGreen50 = Color(0xFF0A3D1F);
  static const Color _darkColorOrange50 = Color(0xFF4A2C10);
  static const Color _darkColorNeutral100 = Color(0xFF2C2C2C);

  // Profile specific dark mode
  static const Color _darkProfileHeaderBg = Color(0xFF0A1929);
  static const Color _darkProfileTabBg = Color(0xFF1E293B);
  static const Color _darkProfileInfoCardBg = Color(0xFF1A2A3A);
  static const Color _darkQuickStatsBg = Color(0xFF1E2530);
  static const Color _darkMonthSummaryPresentBg = Color(0xFF0F2E1E);
  static const Color _darkMonthSummaryPresentText = Color(0xFF4ADE80);
  static const Color _darkMonthSummaryAbsentBg = Color(0xFF3B1516);
  static const Color _darkMonthSummaryAbsentText = Color(0xFFF87171);
  static const Color _darkMonthSummaryLeaveBg = Color(0xFF1A2536);
  static const Color _darkMonthSummaryLeaveText = Color(0xFF60A5FA);
  static const Color _darkMonthSummaryHolidayBg = Color(0xFF251A35);
  static const Color _darkMonthSummaryHolidayText = Color(0xFFC084FC);

  // --- Dark palette status counterparts ---
  static const Color _darkApprovedBg = Color(0xFF0F2E1E);
  static const Color _darkApprovedText = Color(0xFF4ADE80);
  static const Color _darkPendingStatusBg = Color(0xFF2C1E0A);
  static const Color _darkPendingStatusText = Color(0xFFFBBF24);
  static const Color _darkRejectedBg = Color(0xFF3B1516);
  static const Color _darkRejectedText = Color(0xFFF87171);
  static const Color _darkCancelledBg = Color(0xFF27272A);
  static const Color _darkCancelledText = Color(0xFFA1A1AA);

  // --- Dark palette leave balance counterparts ---
  static const Color _darkCasualTrack = Color(0xFF3B1E54);
  static const Color _darkCasualText = Color(0xFFD8B4FE);
  static const Color _darkSickTrack = Color(0xFF0F3E1E);
  static const Color _darkSickText = Color(0xFF86EFAC);
  static const Color _darkEarnedTrack = Color(0xFF1E3A8A);
  static const Color _darkEarnedText = Color(0xFF93C5FD);
  static const Color _darkRestrictedTrack = Color(0xFF451A03);
  static const Color _darkRestrictedText = Color(0xFFFCD34D);
  static const Color _darkPaternityTrack = Color(0xFF50072B);
  static const Color _darkPaternityText = Color(0xFFFBCFE8);
  static const Color _darkMaternityTrack = Color(0xFF1E293B);
  static const Color _darkMaternityText = Color(0xFFCBD5E1);
  static const Color _darkCompensatoryTrack = Color(0xFF312E81);
  static const Color _darkCompensatoryText = Color(0xFFC7D2FE);
  static const Color _darkBereavementTrack = Color(0xFF042F2C);
  static const Color _darkBereavementText = Color(0xFF99F6E4);
  static const Color _darkHalfDayBg = Color(0xFF451A03);
  static const Color _darkHalfDayText = Color(0xFFFDBA74);

  /// Context-aware color accessor
  static AppColorsResolved of(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    return brightness == Brightness.dark
        ? AppColorsResolved.dark()
        : AppColorsResolved.light();
  }
}

/// Resolved color set for the current theme
class AppColorsResolved {
  final Color primary;
  final Color primaryContainer;
  final Color primaryFixed;
  final Color onPrimaryFixed;
  final Color secondary;
  final Color username;
  final Color background;
  final Color surface;
  final Color onSurface;
  final Color surfaceContainerLowest;
  final Color surfaceContainerLow;
  final Color onSurfaceVariant;
  final Color textPrimary;
  final Color textSecondary;
  final Color border;
  final Color bordergrey;
  final Color tableBorder;
  final Color outlineVariant;
  final Color onSecondaryFixedVariant;
  final Color primaryBlue;
  final Color onPrimary;
  final Color onPrimaryContainer;
  final Color secondaryDark;
  final Color onSecondary;
  final Color secondaryContainer;
  final Color onSecondaryContainer;
  final Color tertiary;
  final Color onTertiary;
  final Color tertiaryContainer;
  final Color onTertiaryContainer;
  final Color onTertiaryFixed;
  final Color surfaceContainer;
  final Color surfaceContainerHigh;
  final Color surfaceContainerHighest;
  final Color outline;
  final Color errorContainer;
  final Color onErrorContainer;
  final Color successContainer;
  final Color warningContainer;
  final Color onPrimaryFixedVariant;
  final Color success;
  final Color successDark;
  final Color error;
  final Color errorDark;
  final Color warning;
  final Color warningLight;
  final Color warningDark;
  final Color pending;
  final Color draft;
  final Color accent;
  final Color tertiaryFixed;
  final Color white;
  final Color black;
  final Color transparent;
  final Color placeholdergrey;
  final Color info;
  final Color infoBg;
  final Color infoBorder;
  final Color quickStatsBg;
  final Color successBg;
  final Color successBorder;
  final Color warningBg;
  final Color warningBorder;
  final Color errorBg;
  final Color errorBorder;
  final Color attendancebg;
  final Color calendarupicon;
  final Color timesheeticon;
  final Color compofficon;
  final Color attendanceicon;
  final Color iconbgblue;
  final Color iconbggreen;
  final Color iconbgviolet;
  final Color iconbgred;
  final Color iconbgorange;
  final Color profileHeaderBg;
  final Color profileTabBg;
  final Color profileInfoCardBg;
  final Color profileBadgeBorder;
  final Color profileBadgeBg;
  final Color updateCardBorder;
  final Color slate50;
  final Color slate100;
  final Color slate200;
  final Color slate300;
  final Color slate400;
  final Color slate500;
  final Color slate500Confirmation;
  final Color slate600;
  final Color slate700;
  final Color slate800;
  final Color slate900;
  final Color slate950;
  final Color gray400;
  final Color darkGradientEnd;
  final Color lightGrey;
  final Color charcoal;
  final Color slateGrey;
  final Color purpleHoliday;
  final Color blueAttendance;
  final Color presentText;
  final Color presentBg;
  final Color holidayText;
  final Color holidayBg;
  final Color leaveText;
  final Color leaveBg;
  final Color absentText;
  final Color absentBg;
  final Color weekendText;
  final Color weekendBg;
  final Color slateBg;
  final Color slateText;
  final Color blueIcon;
  final Color darkSlate;
  final Color calendarDefaultBg;
  final Color calendarDefaultText;
  final Color calendarTodayBorder;
  final Color calendarDayLabel;
  final Color monthSummaryPresentBg;
  final Color monthSummaryPresentText;
  final Color monthSummaryAbsentBg;
  final Color monthSummaryAbsentText;
  final Color monthSummaryLeaveBg;
  final Color monthSummaryLeaveText;
  final Color monthSummaryHolidayBg;
  final Color monthSummaryHolidayText;
  final Color halfDayText;
  final Color halfDayBg;
  final Color approvedBg;
  final Color approvedText;
  final Color pendingStatusBg;
  final Color pendingStatusText;
  final Color cancelledBg;
  final Color cancelledText;
  final Color rejectedBg;
  final Color rejectedText;
  final Color bereavementProgress;
  final Color bereavementTrack;
  final Color bereavementText;
  final Color casualProgress;
  final Color casualTrack;
  final Color casualText;
  final Color earnedProgress;
  final Color earnedTrack;
  final Color earnedText;
  final Color restrictedProgress;
  final Color restrictedTrack;
  final Color restrictedText;
  final Color sickProgress;
  final Color sickTrack;
  final Color sickText;
  final Color paternityProgress;
  final Color paternityTrack;
  final Color paternityText;
  final Color maternityProgress;
  final Color maternityTrack;
  final Color maternityText;
  final Color compensatoryProgress;
  final Color compensatoryTrack;
  final Color compensatoryText;
  final Color shimmerBase;
  final Color shimmerHighlight;
  final Color brandBlue;
  final Color brandPurple;
  final Color punchBreak;
  final Color punchOut;
  final Color pmsSuccess;
  final Color splashGradientStart;
  final Color splashGradientMiddle;
  final Color splashGradientEnd;

  // Welcome screen semantic colors (theme-aware)
  final Color welcomeScaffoldBg;
  final Color welcomeTopBg;
  final Color welcomeTitlePrimary;
  final Color welcomeSubtitleColor;

  // Timesheet card colors (theme-aware)
  final Color colorBlue50;
  final Color colorGreen50;
  final Color colorOrange50;
  final Color colorNeutral100;

  const AppColorsResolved._({
    required this.primary,
    required this.primaryContainer,
    required this.primaryFixed,
    required this.onPrimaryFixed,
    required this.secondary,
    required this.username,
    required this.background,
    required this.surface,
    required this.onSurface,
    required this.surfaceContainerLowest,
    required this.surfaceContainerLow,
    required this.onSurfaceVariant,
    required this.textPrimary,
    required this.textSecondary,
    required this.border,
    required this.bordergrey,
    required this.tableBorder,
    required this.outlineVariant,
    required this.onSecondaryFixedVariant,
    required this.primaryBlue,
    required this.onPrimary,
    required this.onPrimaryContainer,
    required this.secondaryDark,
    required this.onSecondary,
    required this.secondaryContainer,
    required this.onSecondaryContainer,
    required this.tertiary,
    required this.onTertiary,
    required this.tertiaryContainer,
    required this.onTertiaryContainer,
    required this.onTertiaryFixed,
    required this.surfaceContainer,
    required this.surfaceContainerHigh,
    required this.surfaceContainerHighest,
    required this.outline,
    required this.errorContainer,
    required this.onErrorContainer,
    required this.successContainer,
    required this.warningContainer,
    required this.onPrimaryFixedVariant,
    required this.success,
    required this.successDark,
    required this.error,
    required this.errorDark,
    required this.warning,
    required this.warningLight,
    required this.warningDark,
    required this.pending,
    required this.draft,
    required this.accent,
    required this.tertiaryFixed,
    required this.white,
    required this.black,
    required this.transparent,
    required this.placeholdergrey,
    required this.info,
    required this.infoBg,
    required this.infoBorder,
    required this.quickStatsBg,
    required this.successBg,
    required this.successBorder,
    required this.warningBg,
    required this.warningBorder,
    required this.errorBg,
    required this.errorBorder,
    required this.attendancebg,
    required this.calendarupicon,
    required this.timesheeticon,
    required this.compofficon,
    required this.attendanceicon,
    required this.iconbgblue,
    required this.iconbggreen,
    required this.iconbgviolet,
    required this.iconbgred,
    required this.iconbgorange,
    required this.profileHeaderBg,
    required this.profileTabBg,
    required this.profileInfoCardBg,
    required this.profileBadgeBorder,
    required this.profileBadgeBg,
    required this.updateCardBorder,
    required this.slate50,
    required this.slate100,
    required this.slate200,
    required this.slate300,
    required this.slate400,
    required this.slate500,
    required this.slate500Confirmation,
    required this.slate600,
    required this.slate700,
    required this.slate800,
    required this.slate900,
    required this.slate950,
    required this.gray400,
    required this.darkGradientEnd,
    required this.lightGrey,
    required this.charcoal,
    required this.slateGrey,
    required this.purpleHoliday,
    required this.blueAttendance,
    required this.presentText,
    required this.presentBg,
    required this.holidayText,
    required this.holidayBg,
    required this.leaveText,
    required this.leaveBg,
    required this.absentText,
    required this.absentBg,
    required this.weekendText,
    required this.weekendBg,
    required this.slateBg,
    required this.slateText,
    required this.blueIcon,
    required this.darkSlate,
    required this.calendarDefaultBg,
    required this.calendarDefaultText,
    required this.calendarTodayBorder,
    required this.calendarDayLabel,
    required this.monthSummaryPresentBg,
    required this.monthSummaryPresentText,
    required this.monthSummaryAbsentBg,
    required this.monthSummaryAbsentText,
    required this.monthSummaryLeaveBg,
    required this.monthSummaryLeaveText,
    required this.monthSummaryHolidayBg,
    required this.monthSummaryHolidayText,
    required this.halfDayText,
    required this.halfDayBg,
    required this.approvedBg,
    required this.approvedText,
    required this.pendingStatusBg,
    required this.pendingStatusText,
    required this.cancelledBg,
    required this.cancelledText,
    required this.rejectedBg,
    required this.rejectedText,
    required this.bereavementProgress,
    required this.bereavementTrack,
    required this.bereavementText,
    required this.casualProgress,
    required this.casualTrack,
    required this.casualText,
    required this.earnedProgress,
    required this.earnedTrack,
    required this.earnedText,
    required this.restrictedProgress,
    required this.restrictedTrack,
    required this.restrictedText,
    required this.sickProgress,
    required this.sickTrack,
    required this.sickText,
    required this.paternityProgress,
    required this.paternityTrack,
    required this.paternityText,
    required this.maternityProgress,
    required this.maternityTrack,
    required this.maternityText,
    required this.compensatoryProgress,
    required this.compensatoryTrack,
    required this.compensatoryText,
    required this.shimmerBase,
    required this.shimmerHighlight,
    required this.brandBlue,
    required this.brandPurple,
    required this.punchBreak,
    required this.punchOut,
    required this.pmsSuccess,
    required this.splashGradientStart,
    required this.splashGradientMiddle,
    required this.splashGradientEnd,
    required this.welcomeScaffoldBg,
    required this.welcomeTopBg,
    required this.welcomeTitlePrimary,
    required this.welcomeSubtitleColor,
    required this.colorBlue50,
    required this.colorGreen50,
    required this.colorOrange50,
    required this.colorNeutral100,
  });

  factory AppColorsResolved.light() => const AppColorsResolved._(
    primary: AppColors.primary,
    primaryContainer: AppColors.primaryContainer,
    primaryFixed: AppColors.primaryFixed,
    onPrimaryFixed: AppColors.onPrimaryFixed,
    secondary: AppColors.secondary,
    username: AppColors.username,
    background: AppColors.background,
    surface: AppColors.surface,
    onSurface: AppColors.onSurface,
    surfaceContainerLowest: AppColors.surfaceContainerLowest,
    surfaceContainerLow: AppColors.surfaceContainerLow,
    onSurfaceVariant: AppColors.onSurfaceVariant,
    textPrimary: AppColors.textPrimary,
    textSecondary: AppColors.textSecondary,
    border: AppColors.border,
    bordergrey: AppColors.bordergrey,
    tableBorder: AppColors.tableBorder,
    outlineVariant: AppColors.outlineVariant,
    onSecondaryFixedVariant: AppColors.onSecondaryFixedVariant,
    primaryBlue: AppColors.primaryBlue,
    onPrimary: AppColors.onPrimary,
    onPrimaryContainer: AppColors.onPrimaryContainer,
    secondaryDark: AppColors.secondaryDark,
    onSecondary: AppColors.onSecondary,
    secondaryContainer: AppColors.secondaryContainer,
    onSecondaryContainer: AppColors.onSecondaryContainer,
    tertiary: AppColors.tertiary,
    onTertiary: AppColors.onTertiary,
    tertiaryContainer: AppColors.tertiaryContainer,
    onTertiaryContainer: AppColors.onTertiaryContainer,
    onTertiaryFixed: AppColors.onTertiaryFixed,
    surfaceContainer: AppColors.surfaceContainer,
    surfaceContainerHigh: AppColors.surfaceContainerHigh,
    surfaceContainerHighest: AppColors.surfaceContainerHighest,
    outline: AppColors.outline,
    errorContainer: AppColors.errorContainer,
    onErrorContainer: AppColors.onErrorContainer,
    successContainer: AppColors.successContainer,
    warningContainer: AppColors.warningContainer,
    onPrimaryFixedVariant: AppColors.onPrimaryFixedVariant,
    success: AppColors.success,
    successDark: AppColors.successDark,
    error: AppColors.error,
    errorDark: AppColors.errorDark,
    warning: AppColors.warning,
    warningLight: AppColors.warningLight,
    warningDark: AppColors.warningDark,
    pending: AppColors.pending,
    draft: AppColors.draft,
    accent: AppColors.accent,
    tertiaryFixed: AppColors.tertiaryFixed,
    white: AppColors.white,
    black: AppColors.black,
    transparent: AppColors.transparent,
    placeholdergrey: AppColors.placeholdergrey,
    info: AppColors.info,
    infoBg: AppColors.infoBg,
    infoBorder: AppColors.infoBorder,
    quickStatsBg: AppColors.quickStatsBg,
    successBg: AppColors.successBg,
    successBorder: AppColors.successBorder,
    warningBg: AppColors.warningBg,
    warningBorder: AppColors.warningBorder,
    errorBg: AppColors.errorBg,
    errorBorder: AppColors.errorBorder,
    attendancebg: AppColors.attendancebg,
    calendarupicon: AppColors.calendarupicon,
    timesheeticon: AppColors.timesheeticon,
    compofficon: AppColors.compofficon,
    attendanceicon: AppColors.attendanceicon,
    iconbgblue: AppColors.iconbgblue,
    iconbggreen: AppColors.iconbggreen,
    iconbgviolet: AppColors.iconbgviolet,
    iconbgred: AppColors.iconbgred,
    iconbgorange: AppColors.iconbgorange,
    profileHeaderBg: AppColors.profileHeaderBg,
    profileTabBg: AppColors.profileTabBg,
    profileInfoCardBg: AppColors.profileInfoCardBg,
    profileBadgeBorder: AppColors.profileBadgeBorder,
    profileBadgeBg: AppColors.profileBadgeBg,
    updateCardBorder: AppColors.updateCardBorder,
    slate50: AppColors.slate50,
    slate100: AppColors.slate100,
    slate200: AppColors.slate200,
    slate300: AppColors.slate300,
    slate400: AppColors.slate400,
    slate500: AppColors.slate500,
    slate500Confirmation: AppColors.slate500Confirmation,
    slate600: AppColors.slate600,
    slate700: AppColors.slate700,
    slate800: AppColors.slate800,
    slate900: AppColors.slate900,
    slate950: AppColors.slate950,
    gray400: AppColors.gray400,
    darkGradientEnd: AppColors.darkGradientEnd,
    lightGrey: AppColors.lightGrey,
    charcoal: AppColors.charcoal,
    slateGrey: AppColors.slateGrey,
    purpleHoliday: AppColors.purpleHoliday,
    blueAttendance: AppColors.blueAttendance,
    presentText: AppColors.presentText,
    presentBg: AppColors.presentBg,
    holidayText: AppColors.holidayText,
    holidayBg: AppColors.holidayBg,
    leaveText: AppColors.leaveText,
    leaveBg: AppColors.leaveBg,
    absentText: AppColors.absentText,
    absentBg: AppColors.absentBg,
    weekendText: AppColors.weekendText,
    weekendBg: AppColors.weekendBg,
    slateBg: AppColors.slateBg,
    slateText: AppColors.slateText,
    blueIcon: AppColors.blueIcon,
    darkSlate: AppColors.darkSlate,
    calendarDefaultBg: AppColors.calendarDefaultBg,
    calendarDefaultText: AppColors.calendarDefaultText,
    calendarTodayBorder: AppColors.calendarTodayBorder,
    calendarDayLabel: AppColors.calendarDayLabel,
    monthSummaryPresentBg: AppColors.monthSummaryPresentBg,
    monthSummaryPresentText: AppColors.monthSummaryPresentText,
    monthSummaryAbsentBg: AppColors.monthSummaryAbsentBg,
    monthSummaryAbsentText: AppColors.monthSummaryAbsentText,
    monthSummaryLeaveBg: AppColors.monthSummaryLeaveBg,
    monthSummaryLeaveText: AppColors.monthSummaryLeaveText,
    monthSummaryHolidayBg: AppColors.monthSummaryHolidayBg,
    monthSummaryHolidayText: AppColors.monthSummaryHolidayText,
    halfDayText: AppColors.halfDayText,
    halfDayBg: AppColors.halfDayBg,
    approvedBg: AppColors.approvedBg,
    approvedText: AppColors.approvedText,
    pendingStatusBg: AppColors.pendingStatusBg,
    pendingStatusText: AppColors.pendingStatusText,
    cancelledBg: AppColors.cancelledBg,
    cancelledText: AppColors.cancelledText,
    rejectedBg: AppColors.rejectedBg,
    rejectedText: AppColors.rejectedText,
    bereavementProgress: AppColors.bereavementProgress,
    bereavementTrack: AppColors.bereavementTrack,
    bereavementText: AppColors.bereavementText,
    casualProgress: AppColors.casualProgress,
    casualTrack: AppColors.casualTrack,
    casualText: AppColors.casualText,
    earnedProgress: AppColors.earnedProgress,
    earnedTrack: AppColors.earnedTrack,
    earnedText: AppColors.earnedText,
    restrictedProgress: AppColors.restrictedProgress,
    restrictedTrack: AppColors.restrictedTrack,
    restrictedText: AppColors.restrictedText,
    sickProgress: AppColors.sickProgress,
    sickTrack: AppColors.sickTrack,
    sickText: AppColors.sickText,
    paternityProgress: AppColors.paternityProgress,
    paternityTrack: AppColors.paternityTrack,
    paternityText: AppColors.paternityText,
    maternityProgress: AppColors.maternityProgress,
    maternityTrack: AppColors.maternityTrack,
    maternityText: AppColors.maternityText,
    compensatoryProgress: AppColors.compensatoryProgress,
    compensatoryTrack: AppColors.compensatoryTrack,
    compensatoryText: AppColors.compensatoryText,
    shimmerBase: AppColors.shimmerBase,
    shimmerHighlight: AppColors.shimmerHighlight,
    brandBlue: AppColors.brandBlue,
    brandPurple: AppColors.brandPurple,
    punchBreak: AppColors.punchBreak,
    punchOut: AppColors.punchOut,
    pmsSuccess: AppColors.pmsSuccess,
    splashGradientStart: AppColors.splashGradientStart,
    splashGradientMiddle: AppColors.splashGradientMiddle,
    splashGradientEnd: AppColors.splashGradientEnd,
    welcomeScaffoldBg: AppColors.white,
    welcomeTopBg: AppColors.leaveBg,
    welcomeTitlePrimary: AppColors.slate900,
    welcomeSubtitleColor: AppColors.slate500,
    colorBlue50: AppColors.colorBlue50,
    colorGreen50: AppColors.colorGreen50,
    colorOrange50: AppColors.colorOrange50,
    colorNeutral100: AppColors.colorNeutral100,
  );

  factory AppColorsResolved.dark() => const AppColorsResolved._(
    primary: AppColors.primary,
    primaryContainer: AppColors.primaryContainer,
    primaryFixed: AppColors.primaryFixed,
    onPrimaryFixed: AppColors.onPrimaryFixed,
    secondary: AppColors.secondary,
    username: AppColors.username,
    background: AppColors._darkBackground,
    surface: AppColors._darkSurface,
    onSurface: AppColors._darkOnSurface,
    surfaceContainerLowest: AppColors._darkSurfaceContainerLowest,
    surfaceContainerLow: AppColors._darkSurfaceContainerLow,
    onSurfaceVariant: AppColors._darkOnSurfaceVariant,
    textPrimary: AppColors._darkTextPrimary,
    textSecondary: AppColors._darkTextSecondary,
    border: AppColors._darkBorder,
    bordergrey: AppColors.bordergrey,
    tableBorder: AppColors._darkTableBorder,
    outlineVariant: AppColors._darkOutlineVariant,
    onSecondaryFixedVariant: AppColors.onSecondaryFixedVariant,
    primaryBlue: AppColors.primaryBlue,
    onPrimary: AppColors.onPrimary,
    onPrimaryContainer: AppColors.onPrimaryContainer,
    secondaryDark: AppColors.secondaryDark,
    onSecondary: AppColors.onSecondary,
    secondaryContainer: AppColors.secondaryContainer,
    onSecondaryContainer: AppColors.onSecondaryContainer,
    tertiary: AppColors.tertiary,
    onTertiary: AppColors.onTertiary,
    tertiaryContainer: AppColors.tertiaryContainer,
    onTertiaryContainer: AppColors.onTertiaryContainer,
    onTertiaryFixed: AppColors.onTertiaryFixed,
    surfaceContainer: AppColors._darkSurfaceContainer,
    surfaceContainerHigh: AppColors._darkSurfaceContainerHigh,
    surfaceContainerHighest: AppColors._darkSurfaceContainerHighest,
    outline: AppColors._darkOutline,
    errorContainer: AppColors._darkRejectedBg,
    onErrorContainer: AppColors.onErrorContainer,
    successContainer: AppColors._darkApprovedBg,
    warningContainer: AppColors._darkPendingStatusBg,
    onPrimaryFixedVariant: AppColors.onPrimaryFixedVariant,
    success: AppColors.success,
    successDark: AppColors.successDark,
    error: AppColors.error,
    errorDark: AppColors.errorDark,
    warning: AppColors.warning,
    warningLight: AppColors.warningLight,
    warningDark: AppColors.warningDark,
    pending: AppColors.pending,
    draft: AppColors.draft,
    accent: AppColors.accent,
    tertiaryFixed: AppColors.tertiaryFixed,
    white: AppColors._darkSurface,
    black: AppColors.black,
    transparent: AppColors.transparent,
    placeholdergrey: AppColors.placeholdergrey,
    info: AppColors.info,
    infoBg: AppColors.infoBg,
    infoBorder: AppColors.infoBorder,
    quickStatsBg: AppColors._darkQuickStatsBg,
    successBg: AppColors.successBg,
    successBorder: AppColors.successBorder,
    warningBg: AppColors.warningBg,
    warningBorder: AppColors.warningBorder,
    errorBg: AppColors.errorBg,
    errorBorder: AppColors.errorBorder,
    attendancebg: AppColors.attendancebg,
    calendarupicon: AppColors.calendarupicon,
    timesheeticon: AppColors.timesheeticon,
    compofficon: AppColors.compofficon,
    attendanceicon: AppColors.attendanceicon,
    iconbgblue: AppColors.iconbgblue,
    iconbggreen: AppColors.iconbggreen,
    iconbgviolet: AppColors.iconbgviolet,
    iconbgred: AppColors.iconbgred,
    iconbgorange: AppColors.iconbgorange,
    profileHeaderBg: AppColors._darkProfileHeaderBg,
    profileTabBg: AppColors._darkProfileTabBg,
    profileInfoCardBg: AppColors._darkProfileInfoCardBg,
    profileBadgeBorder: AppColors._darkBorder,
    profileBadgeBg: AppColors.profileBadgeBg,
    updateCardBorder: AppColors._darkBorder,
    slate50: AppColors._darkSlate50,
    slate100: AppColors._darkSlate100,
    slate200: AppColors._darkSlate200,
    slate300: AppColors.slate300,
    slate400: AppColors.slate400,
    slate500: AppColors.slate400,
    slate500Confirmation: AppColors.slate500Confirmation,
    slate600: AppColors.slate200,
    slate700: AppColors.slate300,
    slate800: AppColors.slate200,
    slate900: AppColors.white,
    slate950: AppColors.white,
    gray400: AppColors.gray400,
    darkGradientEnd: AppColors.darkGradientEnd,
    lightGrey: AppColors.lightGrey,
    charcoal: AppColors._darkTextPrimary,
    slateGrey: AppColors._darkTextSecondary,
    purpleHoliday: AppColors.purpleHoliday,
    blueAttendance: AppColors.blueAttendance,
    presentText: AppColors.presentText,
    presentBg: AppColors.presentBg,
    holidayText: AppColors.holidayText,
    holidayBg: AppColors.holidayBg,
    leaveText: AppColors.leaveText,
    leaveBg: AppColors.leaveBg,
    absentText: AppColors.absentText,
    absentBg: AppColors.absentBg,
    weekendText: AppColors.weekendText,
    weekendBg: AppColors.weekendBg,
    slateBg: AppColors._darkSlateBg,
    slateText: AppColors.slateText,
    blueIcon: AppColors.blueIcon,
    darkSlate: AppColors.slate100,
    calendarDefaultBg: AppColors._darkCalendarDefaultBg,
    calendarDefaultText: AppColors._darkCalendarDefaultText,
    calendarTodayBorder: AppColors.calendarTodayBorder,
    calendarDayLabel: AppColors._darkCalendarDayLabel,
    monthSummaryPresentBg: AppColors._darkMonthSummaryPresentBg,
    monthSummaryPresentText: AppColors._darkMonthSummaryPresentText,
    monthSummaryAbsentBg: AppColors._darkMonthSummaryAbsentBg,
    monthSummaryAbsentText: AppColors._darkMonthSummaryAbsentText,
    monthSummaryLeaveBg: AppColors._darkMonthSummaryLeaveBg,
    monthSummaryLeaveText: AppColors._darkMonthSummaryLeaveText,
    monthSummaryHolidayBg: AppColors._darkMonthSummaryHolidayBg,
    monthSummaryHolidayText: AppColors._darkMonthSummaryHolidayText,
    halfDayText: AppColors._darkHalfDayText,
    halfDayBg: AppColors._darkHalfDayBg,
    approvedBg: AppColors._darkApprovedBg,
    approvedText: AppColors._darkApprovedText,
    pendingStatusBg: AppColors._darkPendingStatusBg,
    pendingStatusText: AppColors._darkPendingStatusText,
    cancelledBg: AppColors._darkCancelledBg,
    cancelledText: AppColors._darkCancelledText,
    rejectedBg: AppColors._darkRejectedBg,
    rejectedText: AppColors._darkRejectedText,
    bereavementProgress: AppColors.bereavementProgress,
    bereavementTrack: AppColors._darkBereavementTrack,
    bereavementText: AppColors._darkBereavementText,
    casualProgress: AppColors.casualProgress,
    casualTrack: AppColors._darkCasualTrack,
    casualText: AppColors._darkCasualText,
    earnedProgress: AppColors.earnedProgress,
    earnedTrack: AppColors._darkEarnedTrack,
    earnedText: AppColors._darkEarnedText,
    restrictedProgress: AppColors.restrictedProgress,
    restrictedTrack: AppColors._darkRestrictedTrack,
    restrictedText: AppColors._darkRestrictedText,
    sickProgress: AppColors.sickProgress,
    sickTrack: AppColors._darkSickTrack,
    sickText: AppColors._darkSickText,
    paternityProgress: AppColors.paternityProgress,
    paternityTrack: AppColors._darkPaternityTrack,
    paternityText: AppColors._darkPaternityText,
    maternityProgress: AppColors.maternityProgress,
    maternityTrack: AppColors._darkMaternityTrack,
    maternityText: AppColors._darkMaternityText,
    compensatoryProgress: AppColors.compensatoryProgress,
    compensatoryTrack: AppColors._darkCompensatoryTrack,
    compensatoryText: AppColors._darkCompensatoryText,
    shimmerBase: AppColors.shimmerBase,
    shimmerHighlight: AppColors.shimmerHighlight,
    brandBlue: AppColors.brandBlue,
    brandPurple: AppColors.brandPurple,
    punchBreak: AppColors.punchBreak,
    punchOut: AppColors.punchOut,
    pmsSuccess: AppColors.pmsSuccess,
    splashGradientStart: AppColors._darkSplashGradientStart,
    splashGradientMiddle: AppColors._darkSplashGradientMiddle,
    splashGradientEnd: AppColors._darkSplashGradientEnd,
    welcomeScaffoldBg: AppColors._darkWelcomeScaffoldBg,
    welcomeTopBg: AppColors._darkWelcomeTopBg,
    welcomeTitlePrimary: AppColors._darkWelcomeTitlePrimary,
    welcomeSubtitleColor: AppColors._darkWelcomeSubtitle,
    colorBlue50: AppColors._darkColorBlue50,
    colorGreen50: AppColors._darkColorGreen50,
    colorOrange50: AppColors._darkColorOrange50,
    colorNeutral100: AppColors._darkColorNeutral100,
  );
}
