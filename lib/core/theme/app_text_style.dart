import 'package:flutter/cupertino.dart';
import 'app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static const String fontFamily = 'Inter';
  static const String headingFont = 'Manrope';

  // Headings
  static const TextStyle h1 = TextStyle(
    fontFamily: headingFont,
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: headingFont,
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: headingFont,
    fontSize: 18,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle h1Bold = h1.copyWith(fontWeight: FontWeight.bold);
  static final TextStyle h2Bold = h2.copyWith(fontWeight: FontWeight.bold);
  static final TextStyle h3Bold = h3.copyWith(fontWeight: FontWeight.bold);

  static TextStyle get bodyLarge => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get bodySmall => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get labelLarge => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get labelMedium => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      );

  static TextStyle get labelSmall => GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get button => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.surfaceContainerLowest,
      );

  static TextStyle get label => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
      );

  static TextStyle get error => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.error,
      );

  static const TextStyle headlineSmall = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.w400,
    // Add other properties like font family if needed
  );

  static TextStyle get statsValue => GoogleFonts.manrope(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: AppColors.primary,
      );

  static TextStyle get statsLabel => GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
        color: AppColors.textSecondary,
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

  // Welcome Screen Custom Typography
  static TextStyle get welcomeTitle => GoogleFonts.inter(
        fontSize: 36,
        fontWeight: FontWeight.w600,
        height: 40 / 36,
        letterSpacing: 0.0,
      );

  static TextStyle get welcomeSubtitle => GoogleFonts.rubik(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.4,
        letterSpacing: 0.2,
      );

  static TextStyle get continueButtonText => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 20 / 14,
        letterSpacing: 0.0,
      );

  // Onboarding Screen Custom Typography
  static TextStyle get onboardingTitle => GoogleFonts.inter(
        fontSize: 30,
        fontWeight: FontWeight.w600,
        height: 36 / 30,
        letterSpacing: 0.0,
      );

  static TextStyle get onboardingSubtitle => GoogleFonts.inter(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        height: 28 / 18,
        letterSpacing: 0.0,
      );

  // Login Screen Custom Typography
  static TextStyle get loginHeaderTitle => GoogleFonts.inter(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        height: 1.3,
        letterSpacing: -0.02 * 32,
      );

  static TextStyle get loginHeaderSubtitle => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.4,
        letterSpacing: -0.01 * 14,
      );

  static TextStyle get loginLabel => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 20 / 14,
        letterSpacing: 0.0,
      );

  static TextStyle get loginForgotPassword => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 16 / 12,
        letterSpacing: 0.0,
      );

  static TextStyle get loginOrWith => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        height: 16 / 12,
        letterSpacing: 0.0,
      );

  static TextStyle get loginOffice365Text => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 24 / 16,
        letterSpacing: 0.0,
      );

  static TextStyle get getStartedTitle => GoogleFonts.inter(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        height: 1.3,
        letterSpacing: 0.0,
      );

  static TextStyle get getStartedSubtitle => GoogleFonts.inter(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        height: 1.3,
        letterSpacing: 0.0,
      );
}

