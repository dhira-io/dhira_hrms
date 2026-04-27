import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimesheetColors {
  static const Color primary = Color(0xff0047cc);
  static const Color secondary = Color(0xff575f67);
  static const Color background = Color(0xfff8f9fa); 
  static const Color textPrimary = Color(0xff191c1d);
  static const Color textSecondary = Color(0xff434656);
  static const Color border = Color(0xffc3c5d9);
  
  static const Color surfaceContainerLowest = Color(0xffffffff);
  static const Color surfaceContainerLow = Color(0xfff3f4f5);
  static const Color surfaceContainer = Color(0xffedeeef);
  static const Color surfaceContainerHigh = Color(0xffe7e8e9);
  static const Color surfaceContainerHighest = Color(0xffe1e3e4);
  static const Color primaryFixed = Color(0xffdce1ff);
  static const Color onPrimaryFixedVariant = Color(0xff003baf);
  static const Color tertiaryFixed = Color(0xffffdbd0);
  static const Color tertiary = Color(0xff992f00);
  
  static const Color success = Color(0xff10B981);
  static const Color green100 = Color(0xffdcfce7);
  static const Color green700 = Color(0xff15803d);
  static const Color orange100 = Color(0xffffedd5);
  static const Color orange700 = Color(0xffc2410c);
  static const Color red100 = Color(0xfffee2e2);
  static const Color red700 = Color(0xffb91c1c);
  static const Color warning = Color(0xffF59E0B);
  static const Color error = Color(0xffba1a1a);
}

class TimesheetStyles {
  static TextStyle get h1 => GoogleFonts.manrope(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: TimesheetColors.textPrimary,
  );

  static TextStyle get h2 => GoogleFonts.manrope(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: TimesheetColors.textPrimary,
  );

  static TextStyle get h3 => GoogleFonts.manrope(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: TimesheetColors.textPrimary,
  );

  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: TimesheetColors.textPrimary,
  );

  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: TimesheetColors.textPrimary,
  );

  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: TimesheetColors.textSecondary,
  );

  static TextStyle get statsValue => GoogleFonts.manrope(
    fontSize: 24,
    fontWeight: FontWeight.w800,
    color: TimesheetColors.primary,
  );

  static TextStyle get statsLabel => GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
    color: TimesheetColors.textSecondary,
  );

  static TextStyle get dateNumber => GoogleFonts.manrope(
    fontSize: 18,
    fontWeight: FontWeight.w800,
  );

  static TextStyle get dateDay => GoogleFonts.inter(
    fontSize: 10,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.2,
  );

  static TextStyle get button => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
  );
}
