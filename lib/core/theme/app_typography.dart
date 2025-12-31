import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography styles using Google Fonts
class AppTypography {
  AppTypography._();

  // Base text theme using Inter font
  static TextTheme get textTheme => GoogleFonts.interTextTheme();

  // Display Styles - Large hero text
  static TextStyle get displayLarge => GoogleFonts.inter(
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
  );

  static TextStyle get displayMedium =>
      GoogleFonts.inter(fontSize: 45, fontWeight: FontWeight.w400);

  static TextStyle get displaySmall =>
      GoogleFonts.inter(fontSize: 36, fontWeight: FontWeight.w400);

  // Headline Styles - Section headers
  static TextStyle get headlineLarge => GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5,
  );

  static TextStyle get headlineMedium => GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.25,
  );

  static TextStyle get headlineSmall =>
      GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w600);

  // Title Styles - Card/item titles
  static TextStyle get titleLarge =>
      GoogleFonts.inter(fontSize: 22, fontWeight: FontWeight.w600);

  static TextStyle get titleMedium => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
  );

  static TextStyle get titleSmall => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
  );

  // Body Styles - Regular content
  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  );

  static TextStyle get bodySmall => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  );

  // Label Styles - Buttons, chips, captions
  static TextStyle get labelLarge => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  );

  static TextStyle get labelMedium => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  static TextStyle get labelSmall => GoogleFonts.inter(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
  );

  // Special Styles
  static TextStyle get bookTitle => GoogleFonts.playfairDisplay(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.25,
  );

  static TextStyle get chapterTitle =>
      GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500);

  static TextStyle get playerTime => GoogleFonts.jetBrainsMono(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  );

  static TextStyle get speedLabel =>
      GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w700);
}
