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

  // Icon Backgrounds
  static const Color iconbgblue = Color(0xffE3F2FD);
  static const Color iconbggreen = Color(0xffE8F5E9);
  static const Color iconbgviolet = Color(0xffF3E5F5);
  static const Color iconbgred = Color(0xffFFEBEE);

  // Profile Specific
  static const Color profileHeaderBg = Color(0xFFEBFDFF);
  static const Color profileTabBg = Color(0xFFF1F5F9);
  static const Color profileInfoCardBg = Color(0xFFF4F9FF);
  static const Color profileBadgeBorder = Color(0xFFB3E5FC);
  static const Color profileBadgeBg = Color(0xFFF3E5F5);
  static const Color updateCardBorder = Color(0xFFBBDEFB);

  // Additional Utils
  static const Color slate50 = Color(0xFFF8FAFC);
  static const Color slate100 = Color(0xFFF1F5F9);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate300 = Color(0xFFCBD5E1);
  static const Color slate400 = Color(0xFF94A3B8);
  static const Color slate500 = Color(0xFF64748B);
  static const Color slate600 = Color(0xFF475569);
  static const Color slate700 = Color(0xFF334155);
  static const Color slate800 = Color(0xFF1E293B);
  static const Color slate900 = Color(0xFF0F172A);

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
  static const Color punchBreak = Color(0xFFff6900);
  static const Color punchOut = Color(0xFFda2529);
}
