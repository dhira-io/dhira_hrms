import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static const String fontFamily = 'Inter';
  static const String headingFont = 'Manrope';

  // Headings
  static TextStyle h1 = TextStyle(
    fontFamily: headingFont,
    fontSize: 22.sp,
    fontWeight: FontWeight.bold,
  );

  static TextStyle h2 = TextStyle(
    fontFamily: headingFont,
    fontSize: 18.sp,
    fontWeight: FontWeight.w600,
  );

  static TextStyle h3 = TextStyle(
    fontFamily: headingFont,
    fontSize: 16.sp,
    fontWeight: FontWeight.w600,
  );

  static final TextStyle h1Bold = h1.copyWith(fontWeight: FontWeight.bold);
  static final TextStyle h2Bold = h2.copyWith(fontWeight: FontWeight.bold);
  static final TextStyle h3Bold = h3.copyWith(fontWeight: FontWeight.bold);

  //Display
  static TextStyle get displayLarge =>
      GoogleFonts.inter(fontSize: 24.sp, fontWeight: FontWeight.w700);
  static TextStyle get displayMedium =>
      GoogleFonts.inter(fontSize: 22.sp, fontWeight: FontWeight.w700);
  static TextStyle get displaySmall =>
      GoogleFonts.inter(fontSize: 20.sp, fontWeight: FontWeight.w700);
  static TextStyle get displaySmallOne =>
      GoogleFonts.inter(fontSize: 18.sp, fontWeight: FontWeight.w600);
  static TextStyle get displaySmallTwo =>
      GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w600);

  //Title
  static TextStyle get titleLarge =>
      GoogleFonts.inter(fontSize: 18.sp, fontWeight: FontWeight.w600);
  static TextStyle get titleMedium =>
      GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w600);
  static TextStyle get titleSmall =>
      GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w600);
  static TextStyle get titleSmallOne =>
      GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w600);

  //Heading
  static TextStyle get headingLarge =>
      GoogleFonts.manrope(fontSize: 22.sp, fontWeight: FontWeight.w700);
  static TextStyle get headingMedium =>
      GoogleFonts.manrope(fontSize: 20.sp, fontWeight: FontWeight.w600);
  static TextStyle get headingSmall =>
      GoogleFonts.manrope(fontSize: 18.sp, fontWeight: FontWeight.w600);
  static TextStyle get headingSmallOne =>
      GoogleFonts.manrope(fontSize: 16.sp, fontWeight: FontWeight.w600);
  static TextStyle get headingSmallTwo =>
      GoogleFonts.manrope(fontSize: 14.sp, fontWeight: FontWeight.w600);
  static TextStyle get headingSmallThree =>
      GoogleFonts.manrope(fontSize: 13.sp, fontWeight: FontWeight.w600);

  // Body
  static TextStyle get bodyLarge =>
      GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w400);
  static TextStyle get bodyMedium =>
      GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w400);
  static TextStyle get bodyMediumOne =>
      GoogleFonts.inter(fontSize: 11.sp, fontWeight: FontWeight.w400);
  static TextStyle get bodySmall =>
      GoogleFonts.inter(fontSize: 10.sp, fontWeight: FontWeight.w400);
  static TextStyle get bodySmallOne =>
      GoogleFonts.inter(fontSize: 9.sp, fontWeight: FontWeight.w400);
  static TextStyle get bodySmallTwo =>
      GoogleFonts.inter(fontSize: 8.sp, fontWeight: FontWeight.w400);

  // Labels
  static TextStyle get labelLarge =>
      GoogleFonts.inter(fontSize: 13.sp, fontWeight: FontWeight.w600);
  static TextStyle get labelMedium =>
      GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w500);
  static TextStyle get labelSmall =>
      GoogleFonts.inter(fontSize: 10.sp, fontWeight: FontWeight.w500);
  static TextStyle get labelSmallOne =>
      GoogleFonts.inter(fontSize: 9.sp, fontWeight: FontWeight.w400);
  static TextStyle get labelSmallTwo =>
      GoogleFonts.inter(fontSize: 8.sp, fontWeight: FontWeight.w400);

  static TextStyle get button => GoogleFonts.inter(
    fontSize: 14.sp,
    //  fontWeight: FontWeight.w700,
    color: AppColors.surfaceContainerLowest,
  );

  static TextStyle get label =>
      GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w500);

  static TextStyle get error => GoogleFonts.inter(
    fontSize: 10.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.error,
  );

  static TextStyle headlineSmall = TextStyle(
    fontSize: 22.0.sp,
    fontWeight: FontWeight.w400,
    // Add other properties like font family if needed
  );

  static TextStyle get statsValue => GoogleFonts.manrope(
    fontSize: 22.sp,
    fontWeight: FontWeight.w800,
    color: AppColors.primary,
  );

  static TextStyle get statsLabel => GoogleFonts.inter(
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.2,
    color: AppColors.textSecondary,
  );

  static TextStyle get dateNumber =>
      GoogleFonts.manrope(fontSize: 16.sp, fontWeight: FontWeight.w800);

  static TextStyle get dateDay => GoogleFonts.inter(
    fontSize: 10.sp,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.2,
  );

  // Welcome Screen Custom Typography
  static TextStyle get welcomeTitle => GoogleFonts.inter(
    fontSize: 30.sp,
    fontWeight: FontWeight.w600,
    height: 40.h / 36,
    letterSpacing: 0.0,
  );

  static TextStyle get welcomeSubtitle => GoogleFonts.rubik(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    height: 1.4.h,
    letterSpacing: 0.2,
  );

  static TextStyle get continueButtonText => GoogleFonts.inter(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    height: 20.h / 14,
    letterSpacing: 0.0,
  );

  // Onboarding Screen Custom Typography
  static TextStyle get onboardingTitle => GoogleFonts.inter(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    height: 36.h / 30,
    letterSpacing: 0.0,
  );

  static TextStyle get onboardingSubtitle => GoogleFonts.inter(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    height: 28.h / 18,
    letterSpacing: 0.0,
  );

  // Login Screen Custom Typography
  static TextStyle get loginHeaderTitle => GoogleFonts.inter(
    fontSize: 26.sp,
    fontWeight: FontWeight.w700,
    height: 1.3.h,
    letterSpacing: -0.02 * 32,
  );

  static TextStyle get loginHeaderSubtitle => GoogleFonts.inter(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    height: 1.4.h,
    letterSpacing: -0.01 * 14,
  );

  static TextStyle get loginLabel => GoogleFonts.inter(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    height: 20.h / 14,
    letterSpacing: 0.0,
  );

  static TextStyle get loginForgotPassword => GoogleFonts.inter(
    fontSize: 10.sp,
    fontWeight: FontWeight.w600,
    height: 16.h / 12,
    letterSpacing: 0.0,
  );

  static TextStyle get loginOrWith => GoogleFonts.inter(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    height: 16.h / 12,
    letterSpacing: 0.0,
  );

  static TextStyle get loginOffice365Text => GoogleFonts.inter(
    fontSize: 14.sp,
    fontWeight: FontWeight.w700,
    height: 24.h / 16,
    letterSpacing: 0.0,
  );

  static TextStyle get getStartedTitle => GoogleFonts.inter(
    fontSize: 20.sp,
    fontWeight: FontWeight.w600,
    height: 1.3.h,
    letterSpacing: 0.0,
  );

  static TextStyle get getStartedSubtitle => GoogleFonts.inter(
    fontSize: 11.sp,
    fontWeight: FontWeight.w500,
    height: 1.3.h,
    letterSpacing: 0.0,
  );
}
