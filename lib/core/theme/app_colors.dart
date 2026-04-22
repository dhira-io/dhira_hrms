import 'package:flutter/material.dart';

class AppColors {
  // Primary Palette
  static const Color primary = Color(0xFF0047CC);
  static const Color primaryContainer = Color(0xFF155DFC);
  static const Color primaryFixed = Color(0xFFDCE1FF);
  static const Color onPrimaryFixed = Color(0xFF00164E);
  static const Color secondary = Color(0xff0066FF);
  
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
  static const Color primaryContainer = Color(0xff155dfc);
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
  static const Color surfaceContainerLowest = Color(0xffffffff);
  static const Color surfaceContainerLow = Color(0xfff3f4f5);
  static const Color surfaceContainer = Color(0xffedeeef);
  static const Color surfaceContainerHigh = Color(0xffe7e8e9);
  static const Color surfaceContainerHighest = Color(0xffe1e3e4);
  static const Color onSurface = Color(0xff191c1d);
  static const Color onSurfaceVariant = Color(0xff434656);
  static const Color outline = Color(0xff737687);
  static const Color outlineVariant = Color(0xffc3c5d9);
  static const Color errorContainer = Color(0xffffdad6);
  static const Color onErrorContainer = Color(0xff93000a);
  static const Color primaryFixed = Color(0xffdce1ff);

  // Status Colors
  static const Color success = Color(0xff10B981);
  static const Color error = Color(0xffba1a1a);
  static const Color warning = Color(0xffF59E0B);
  static const Color pending = Color(0xffF59E0B);
  static const Color draft = Color(0xff6B7280);
  static const Color accent = Color(0xff18bbee);
  static const Color tertiary = Color(0xFF992F00);
  static const Color tertiaryFixed = Color(0xFFFFDBD0);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color transparent = Colors.transparent;
  static const Color placeholdergrey = Color(0xff9E9E9E);

  // Status Palettes (Tailwind-like)
  static const Color info = Color(0xFF0369A1);
  static const Color infoBg = Color(0xFFE0F2FE);
  static const Color infoBorder = Color(0xFFBAE6FD);

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
  static const Color presentBg = Color(0xFFF0FDF4);
  static const Color presentText = Color(0xFF166534);
  static const Color holidayBg = Color(0xFFFAF5FF);
  static const Color holidayText = Color(0xFF6B21A8);
  static const Color leaveBg = Color(0xFFEFF6FF);
  static const Color leaveText = Color(0xFF1E40AF);
  static const Color absentBg = Color(0xFFFEF2F2);
  static const Color absentText = Color(0xFF991B1B);
  static const Color weekendBg = Color(0xFFF8FAFC);
  static const Color weekendText = Color(0xFF94A3B8);
  static const Color slateBg = Color(0xFFF1F5F9);
  static const Color slateText = Color(0xFF64748B);
  static const Color slate200 = Color(0xFFE2E8F0);
  static const Color slate600 = Color(0xFF475569);
  static const Color blueIcon = Color(0xFF3B82F6);
  static const Color darkSlate = Color(0xFF1E293B);

  // Leave Status Colors
  static const Color approvedBg = Color(0xFFE8F9EE);
  static const Color approvedText = Color(0xFF1B5E20);
  static const Color pendingStatusBg = Color(0xFFFFF9E6);
  static const Color pendingStatusText = Color(0xFFE65100);
  static const Color rejectedBg = Color(0xFFFEEBEE);
  static const Color rejectedText = Color(0xFFC62828);

  // Leave Type Specific Palette
  static const Color bereavementBg = Color(0xFFF1FBFA);
  static const Color bereavementTrack = Color(0xFFD6F6F2);
  static const Color bereavementProgress = Color(0xFF90EDDE);
  static const Color casualBg = Color(0xFFF7F3FF);
  static const Color casualTrack = Color(0xFFEDE1FF);
  static const Color casualProgress = Color(0xFFD2B0FF);
  static const Color earnedBg = Color(0xFFEAF4FF);
  static const Color earnedTrack = Color(0xFFD3E8FF);
  static const Color earnedProgress = Color(0xFFA9D0FF);
  static const Color restrictedBg = Color(0xFFFFF9E6);
  static const Color restrictedTrack = Color(0xFFFFF0B3);
  static const Color restrictedProgress = Color(0xFFFFE066);
  static const Color sickBg = Color(0xFFE8F9EE);
  static const Color sickTrack = Color(0xFFD1F2DB);
  static const Color sickProgress = Color(0xFFA1E7B6);
}

