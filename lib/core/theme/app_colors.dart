import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class AppColors {
  static final ValueNotifier<ThemeMode> themeModeNotifier = ValueNotifier(ThemeMode.system);

  static bool get isDark {
    final mode = themeModeNotifier.value;
    if (mode == ThemeMode.dark) return true;
    if (mode == ThemeMode.light) return false;
    return SchedulerBinding.instance.platformDispatcher.platformBrightness == Brightness.dark;
  }

  static void updateThemeMode(ThemeMode mode) {
    themeModeNotifier.value = mode;
  }

  // Primary Palette
  static Color get primary => const Color(0xFF0047CC);
  static Color get primaryContainer => isDark ? const Color(0xFF002C7A) : const Color(0xFF155DFC);
  static Color get primaryFixed => isDark ? const Color(0xFF00164E) : const Color(0xFFDCE1FF);
  static Color get onPrimaryFixed => isDark ? const Color(0xFFDCE1FF) : const Color(0xFF00164E);
  static Color get secondary => const Color(0xff0066FF);

  static Color get username => isDark ? Colors.white : const Color(0xFF111827);

  // Neutral Palette
  static Color get background => isDark ? const Color(0xFF0A0A0A) : const Color(0xFFF8F9FA);
  static Color get surface => isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF8F9FA);
  static Color get onSurface => isDark ? const Color(0xFFE1E3E4) : const Color(0xFF191C1D);
  static Color get surfaceContainerLowest => isDark ? const Color(0xFF121212) : const Color(0xFFFFFFFF);
  static Color get surfaceContainerLow => isDark ? const Color(0xFF1E1E1E) : const Color(0xFFF3F4F5);
  static Color get onSurfaceVariant => isDark ? const Color(0xFFC3C5D9) : const Color(0xFF434656);
  static Color get textPrimary => isDark ? Colors.white : const Color(0xff191C1D);
  static Color get textSecondary => isDark ? const Color(0xff9CA3AF) : const Color(0xff4B5563);
  static Color get border => isDark ? const Color(0xff333333) : const Color(0xffE5E7EB);
  static Color get bordergrey => isDark ? const Color(0xff2A2A2A) : const Color(0xffE9E9E9);
  static Color get outlineVariant => isDark ? const Color(0xff444444) : const Color(0xFFC3C5D9);
  static Color get onSecondaryFixedVariant => isDark ? const Color(0xFFE1E3E4) : const Color(0xFF3F484F);
  static Color get primaryBlue => isDark ? const Color(0xff4D4DFF) : const Color(0xff1100CC);

  // HTML Mockup Colors
  static Color get onPrimary => const Color(0xffffffff);
  static Color get onPrimaryContainer => isDark ? const Color(0xff1a1c2e) : const Color(0xffeceeff);
  static Color get secondaryDark => const Color(0xff575f67);
  static Color get onSecondary => const Color(0xffffffff);
  static Color get secondaryContainer => isDark ? const Color(0xff2d343b) : const Color(0xffd8e1ea);
  static Color get onSecondaryContainer => isDark ? const Color(0xffd8e1ea) : const Color(0xff5b646b);
  static Color get tertiary => const Color(0xff992f00);
  static Color get onTertiary => const Color(0xffffffff);
  static Color get tertiaryContainer => const Color(0xffc33e00);
  static Color get onTertiaryContainer => const Color(0xffffebe5);
  static Color get onTertiaryFixed => const Color(0xff390c00);
  static Color get surfaceContainer => isDark ? const Color(0xff2A2D2F) : const Color(0xffedeeef);
  static Color get surfaceContainerHigh => isDark ? const Color(0xff35393B) : const Color(0xffe7e8e9);
  static Color get surfaceContainerHighest => isDark ? const Color(0xff404548) : const Color(0xffe1e3e4);
  static Color get outline => isDark ? const Color(0xff8E919F) : const Color(0xff737687);
  static Color get errorContainer => isDark ? const Color(0xff93000a) : const Color(0xffffdad6);
  static Color get onErrorContainer => isDark ? const Color(0xffffdad6) : const Color(0xff93000a);
  static Color get successContainer => isDark ? const Color(0xFF064E3B) : const Color(0xFFDCFCE7);
  static Color get warningContainer => isDark ? const Color(0xFF78350F) : const Color(0xFFFEF9C3);

  static Color get onPrimaryFixedVariant => isDark ? const Color(0xFF6E91FF) : const Color(0xFF003BAF);

  // Status Colors
  static Color get success => const Color(0xff10B981);
  static Color get successDark => const Color(0xff15803d);
  static Color get error => const Color(0xffba1a1a);
  static Color get errorDark => const Color(0xffb91c1c);
  static Color get warning => const Color(0xffF59E0B);
  static Color get warningLight => isDark ? const Color(0xFF451A03) : const Color(0xffffedd5);
  static Color get warningDark => const Color(0xffc2410c);
  static Color get pending => const Color(0xffF59E0B);
  static Color get draft => const Color(0xff6B7280);
  static Color get accent => const Color(0xff18bbee);
  static Color get tertiaryFixed => const Color(0xFFFFDBD0);
  
  // NOTE: semantic_white/semantic_black used for backgrounds that should invert in dark mode.
  // Standard white/black remain constant for things like text on primary buttons.
  static Color get white => Colors.white;
  static Color get black => Colors.black;
  static Color get transparent => Colors.transparent;
  static Color get placeholdergrey => const Color(0xff9E9E9E);

  // Status Palettes (Tailwind-like)
  static Color get info => const Color(0xFF0369A1);
  static Color get infoBg => isDark ? const Color(0xFF082F49) : const Color(0xFFE0F2FE);
  static Color get infoBorder => isDark ? const Color(0xFF0C4A6E) : const Color(0xFFBAE6FD);
  static Color get quickStatsBg => isDark ? const Color(0xFF1E293B) : const Color(0xFFF0F9FF);

  static Color get successBg => isDark ? const Color(0xFF064E3B) : const Color(0xFFDCFCE7);
  static Color get successBorder => isDark ? const Color(0xFF065F46) : const Color(0xFFBBF7D0);

  static Color get warningBg => isDark ? const Color(0xFF78350F) : const Color(0xFFFEF9C3);
  static Color get warningBorder => isDark ? const Color(0xFF92400E) : const Color(0xFFFEF08A);

  static Color get errorBg => isDark ? const Color(0xFF7F1D1D) : const Color(0xFFFEE2E2);
  static Color get errorBorder => isDark ? const Color(0xFF991B1B) : const Color(0xFFFECACA);

  //dashboard
  static Color get attendancebg => isDark ? const Color(0xFF2E1065) : const Color(0xFFEDE9FE);
  static Color get calendarupicon => isDark ? const Color(0xFF4ADE80) : const Color(0xFF3D6300);
  static Color get timesheeticon => isDark ? const Color(0xFF38BDF8) : const Color(0xFF00598A);
  static Color get compofficon => isDark ? const Color(0xFF2DD4BF) : const Color(0xFF005F5A);
  static Color get attendanceicon => isDark ? const Color(0xFFC084FC) : const Color(0xFF5D0EC0);

  // Icon Backgrounds
  static Color get iconbgblue => isDark ? const Color(0xff0F172A) : const Color(0xffE3F2FD);
  static Color get iconbggreen => isDark ? const Color(0xff064E3B) : const Color(0xffE8F5E9);
  static Color get iconbgviolet => isDark ? const Color(0xff2E1065) : const Color(0xffF3E5F5);
  static Color get iconbgred => isDark ? const Color(0xff450A0A) : const Color(0xffFFEBEE);
  static Color get iconbgorange => isDark ? const Color(0xff451A03) : const Color(0xffFFF3E0);

  // Profile Specific
  static Color get profileHeaderBg => isDark ? const Color(0xFF0F172A) : const Color(0xFFEBFDFF);
  static Color get profileTabBg => isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9);
  static Color get profileInfoCardBg => isDark ? const Color(0xFF1E293B) : const Color(0xFFF4F9FF);
  static Color get profileBadgeBorder => isDark ? const Color(0xFF0C4A6E) : const Color(0xFFB3E5FC);
  static Color get profileBadgeBg => isDark ? const Color(0xFF2E1065) : const Color(0xFFF3E5F5);
  static Color get updateCardBorder => isDark ? const Color(0xFF1E3A8A) : const Color(0xFFBBDEFB);

  // Additional Utils
  static Color get slate50 => isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC);
  static Color get slate100 => isDark ? const Color(0xFF0F172A) : const Color(0xFFF1F5F9);
  static Color get slate200 => isDark ? const Color(0xFF1E1E1E) : const Color(0xFFE2E8F0);
  static Color get slate300 => isDark ? const Color(0xFF334155) : const Color(0xFFCBD5E1);
  static Color get slate400 => isDark ? const Color(0xFF475569) : const Color(0xFF94A3B8);
  static Color get slate500 => isDark ? const Color(0xFF64748B) : const Color(0xFF64748B);
  static Color get slate600 => isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569);
  static Color get slate700 => isDark ? const Color(0xFFCBD5E1) : const Color(0xFF334155);
  static Color get slate800 => isDark ? const Color(0xFFF1F5F9) : const Color(0xFF1E293B);
  static Color get slate900 => isDark ? const Color(0xFFF8FAFC) : const Color(0xFF0F172A);

  static Color get purpleHoliday => const Color(0xFF9810FA);
  static Color get blueAttendance => const Color(0xFF3B82F6);

  // Theme Preview Colors
  static Color get themePreviewBgDark => const Color(0xFF2C2E30);
  static Color get themePreviewBgLight => const Color(0xFFF1F3F5);
  static Color get themePreviewCardDark => const Color(0xFF1E1F21);

  // Theme Accent Options
  static Color get accentBlue => const Color(0xFF0047cc);
  static Color get accentTeal => const Color(0xFF006A60);
  static Color get accentRed => const Color(0xFF8C1D18);
  static Color get accentPurple => const Color(0xFF6750A4);

  // Attendance Status Colors
  static Color get presentText => isDark ? const Color(0xFF4ADE80) : const Color(0xFF00A63E);
  static Color get presentBg => isDark ? const Color(0xFF064E3B) : const Color(0xFFDCFCE7);
  static Color get holidayText => isDark ? const Color(0xFFA78BFA) : const Color(0xFF9810FA);
  static Color get holidayBg => isDark ? const Color(0xFF2E1065) : const Color(0xFFF3E8FF);
  static Color get leaveText => isDark ? const Color(0xFF60A5FA) : const Color(0xFF0084D1);
  static Color get leaveBg => isDark ? const Color(0xFF0C4A6E) : const Color(0xFFDFF2FE);
  static Color get absentText => isDark ? const Color(0xFFF87171) : const Color(0xFFE7000B);
  static Color get absentBg => isDark ? const Color(0xFF450A0A) : const Color(0xFFFFE2E2);
  static Color get weekendText => isDark ? const Color(0xFF94A3B8) : const Color(0xFF4A5565);
  static Color get weekendBg => isDark ? const Color(0xFF1E293B) : const Color(0xFFF4F4F5);
  static Color get slateBg => isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9);
  static Color get slateText => isDark ? const Color(0xFF94A3B8) : const Color(0xFF64748B);
  static Color get blueIcon => const Color(0xFF3B82F6);
  static Color get darkSlate => isDark ? Colors.white : const Color(0xFF1E293B);

  // New Calendar Colors
  static Color get calendarDefaultBg => isDark ? const Color(0xFF0F172A) : const Color(0xFFF8FAFC);
  static Color get calendarDefaultText => isDark ? const Color(0xFFCBD5E1) : const Color(0xFF45556C);
  static Color get calendarTodayBorder => const Color(0xFF2B7FFF);
  static Color get calendarDayLabel => isDark ? const Color(0xFF94A3B8) : const Color(0xFF475569);

  // Attendance Month Summary Colors
  static Color get monthSummaryPresentBg => isDark ? const Color(0xFF064E3B) : const Color(0xFFDCFCE7);
  static Color get monthSummaryPresentText => isDark ? const Color(0xFF4ADE80) : const Color(0xFF00A63E);
  static Color get monthSummaryAbsentBg => isDark ? const Color(0xFF450A0A) : const Color(0xFFFFE2E2);
  static Color get monthSummaryAbsentText => isDark ? const Color(0xFFF87171) : const Color(0xFFE7000B);
  static Color get monthSummaryLeaveBg => isDark ? const Color(0xFF1E3A8A) : const Color(0xFFDBEAFE);
  static Color get monthSummaryLeaveText => isDark ? const Color(0xFF60A5FA) : const Color(0xFF1E40AF);
  static Color get monthSummaryHolidayBg => isDark ? const Color(0xFF4C1D95) : const Color(0xFFF3E8FF);
  static Color get monthSummaryHolidayText => isDark ? const Color(0xFFA78BFA) : const Color(0xFF6B21A8);

  // Legend Item Colors
  static Color get halfDayText => isDark ? const Color(0xFFFB923C) : const Color(0xFF9A3412);
  static Color get halfDayBg => isDark ? const Color(0xFF431407) : const Color(0xFFFFF7ED);

  // Leave Status Colors
  static Color get approvedBg => isDark ? const Color(0xFF064E3B) : const Color(0xFFDCFCE7);
  static Color get approvedText => isDark ? const Color(0xFF4ADE80) : const Color(0xFF166534);
  static Color get pendingStatusBg => isDark ? const Color(0xFF78350F) : const Color(0xFFFEF9C3);
  static Color get pendingStatusText => isDark ? const Color(0xFFFBBF24) : const Color(0xFF854D0E);
  static Color get cancelledBg => isDark ? const Color(0xFF1E293B) : const Color(0xFFF6F3F4);
  static Color get cancelledText => isDark ? const Color(0xFF94A3B8) : const Color(0xFF364153);
  static Color get rejectedBg => isDark ? const Color(0xFF450A0A) : const Color(0xFFFEEBEE);
  static Color get rejectedText => isDark ? const Color(0xFFF87171) : const Color(0xFFC62828);

  // Leave Type Specific Palette
  static Color get bereavementProgress => const Color(0xFF00BBA7);
  static Color get bereavementTrack => isDark ? const Color(0xFF00443D) : const Color(0xFFCBFBF1);
  static Color get bereavementText => const Color(0xFF00BBA7);

  static Color get casualProgress => const Color(0xFFA855F7);
  static Color get casualTrack => isDark ? const Color(0xFF3B0764) : const Color(0xFFE9D5FF);
  static Color get casualText => const Color(0xFF9333EA);

  static Color get earnedProgress => const Color(0xFF3B82F6);
  static Color get earnedTrack => isDark ? const Color(0xFF172554) : const Color(0xFFBFDBFE);
  static Color get earnedText => const Color(0xFF2563EB);

  static Color get restrictedProgress => const Color(0xFFF3B81F);
  static Color get restrictedTrack => isDark ? const Color(0xFF451A03) : const Color(0xFFFCE9B9);
  static Color get restrictedText => const Color(0xFFF3B81F);

  static Color get sickProgress => const Color(0xFF22C55E);
  static Color get sickTrack => isDark ? const Color(0xFF052E16) : const Color(0xFFBBF7D0);
  static Color get sickText => const Color(0xFF16A34A);

  static Color get paternityProgress => const Color(0xFFF6339A);
  static Color get paternityTrack => isDark ? const Color(0xFF4A044E) : const Color(0xFFFFD0F0);
  static Color get paternityText => const Color(0xFFF6339A);

  static Color get maternityProgress => const Color(0xFF0047CC);
  static Color get maternityTrack => isDark ? const Color(0xFF00164E) : const Color(0xffE5E7EB);
  static Color get maternityText => const Color(0xFF0047CC);

  static Color get compensatoryProgress => const Color(0xFF6366F1);
  static Color get compensatoryTrack => isDark ? const Color(0xFF1E1B4B) : const Color(0xFFE0E7FF);
  static Color get compensatoryText => const Color(0xFF4338CA);

  // Shimmer Colors
  static Color get shimmerBase => isDark ? const Color(0xFF333333) : const Color(0xFFE0E0E0);
  static Color get shimmerHighlight => isDark ? const Color(0xFF444444) : const Color(0xFFF5F5F5);

  // Brand Colors
  static Color get brandBlue => const Color(0xFF0084D1);
  static Color get brandPurple => const Color(0xFF8200DB);

  // Punch Card Colors
  static Color get punchBreak => const Color(0xFFff6900);
  static Color get punchOut => const Color(0xFFda2529);
  static Color get pmsSuccess => const Color(0xFF0F9D58);
}
