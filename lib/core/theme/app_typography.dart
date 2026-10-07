import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTypography {
  static TextStyle displayLarge = GoogleFonts.lato(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 40 / 32,
    color: AppColors.charcoal900,
  );

  static TextStyle displayMedium = GoogleFonts.lato(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.3,
    height: 36 / 28,
    color: AppColors.charcoal900,
  );

  static TextStyle heading1 = GoogleFonts.lato(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.2,
    height: 32 / 24,
    color: AppColors.charcoal900,
  );

  static TextStyle heading2 = GoogleFonts.lato(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 28 / 20,
    color: AppColors.charcoal900,
  );

  static TextStyle heading3 = GoogleFonts.lato(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 24 / 18,
    color: AppColors.charcoal900,
  );

  static TextStyle bodyLarge = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.1,
    height: 24 / 16,
    color: AppColors.charcoal800,
  );

  static TextStyle bodyMedium = GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
    height: 20 / 14,
    color: AppColors.charcoal800,
  );

  static TextStyle bodySmall = GoogleFonts.lato(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.2,
    height: 16 / 12,
    color: AppColors.charcoal600,
  );

  static TextStyle caption = GoogleFonts.lato(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.3,
    height: 14 / 11,
    color: AppColors.charcoal600,
  );

  static TextStyle overline = GoogleFonts.lato(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 1.5,
    height: 14 / 10,
    color: AppColors.primaryDark,
  );

  static TextStyle buttonLarge = GoogleFonts.lato(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.5,
    height: 20 / 16,
    color: AppColors.pureWhite,
  );

  static TextStyle buttonMedium = GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    height: 18 / 14,
    color: AppColors.pureWhite,
  );

  static TextStyle priceDisplay = GoogleFonts.lato(
    fontSize: 36,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 44 / 36,
    color: AppColors.charcoal900,
  );

  static TextStyle priceUnit = GoogleFonts.lato(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 18 / 14,
    color: AppColors.charcoal600,
  );
}
