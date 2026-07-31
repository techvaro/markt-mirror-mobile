import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  static const Color primary = Color(0xFF173B7B);
  static const Color primaryDark = Color(0xFF0F2A58);
  static const Color primaryLight = Color(0xFF2A5DB8);
  static const Color primaryContainer = Color(0xFFE8EDF5);

  static const Color accent = Color(0xFFF36E09);
  static const Color accentLight = Color(0xFFFFF0E0);

  static const Color navy = Color(0xFF044E75);

  static const Color success = Color(0xFF22C55E);
  static const Color successLight = Color(0xFFE8F5E9);
  static const Color error = Color(0xFFEF4444);
  static const Color errorLight = Color(0xFFFFEBEE);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFFF3E0);
  static const Color info = Color(0xFF173B7B);
  static const Color infoLight = Color(0xFFE3F2FD);

  static const Color priorityHigh = Color(0xFFEF4444);
  static const Color priorityHighBg = Color(0xFFFFEBEE);
  static const Color priorityMedium = Color(0xFFF36E09);
  static const Color priorityMediumBg = Color(0xFFFFF3E0);
  static const Color priorityLow = Color(0xFF173B7B);
  static const Color priorityLowBg = Color(0xFFE3F2FD);

  static const Color textPrimary = Color(0xFF0F172A);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textHint = Color(0xFF9CA3AF);
  static const Color textOnPrimary = Color(0xFFFFFFFF);
  static const Color textOnDark = Color(0xFFFFFFFF);

  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cardBackground = Color(0xFFFFFFFF);

  static const Color border = Color(0xFFE2E8F0);
  static const Color divider = Color(0xFFE2E8F0);

  static const Color chartLine = Color(0xFF173B7B);
  static const Color chartLineAlt = Color(0xFFEF4444);
  static const Color chartFill = Color(0x33173B7B);
  static const Color chartFillAlt = Color(0x33EF4444);
  static const Color chartGrid = Color(0xFFE2E8F0);

  static const Color marketCentral = Color(0xFF173B7B);
  static const Color marketDowntown = Color(0xFFF36E09);
  static const Color marketWestside = Color(0xFF22C55E);
  static const Color marketEastside = Color(0xFFF59E0B);

  static const Color notificationAssignment = Color(0xFF173B7B);
  static const Color notificationApproval = Color(0xFF22C55E);
  static const Color notificationRejection = Color(0xFFEF4444);
  static const Color notificationSystem = Color(0xFF6B7280);

  static const Color online = Color(0xFF22C55E);
  static const Color offline = Color(0xFF9CA3AF);

  static const Color gaugeFill = Color(0xFF173B7B);
  static const Color gaugeTrack = Color(0xFFE2E8F0);
  static const Color gaugeSuccess = Color(0xFF22C55E);

  static const Color mapGrid = Color(0xFFE8E8E8);
  static const Color mapRoad = Color(0xFFD0D0D0);
  static const Color mapPinPending = Color(0xFFF59E0B);
  static const Color mapPinApproved = Color(0xFF22C55E);
  static const Color mapPinRejected = Color(0xFFEF4444);
  static const Color mapPinMapper = Color(0xFF173B7B);
  static const Color mapPinPulse = Color(0x33173B7B);

  static const Color kpiGreen = Color(0xFF22C55E);
  static const Color kpiBlue = Color(0xFF173B7B);
  static const Color kpiOrange = Color(0xFFF36E09);
  static const Color kpiPurple = Color(0xFF7C3AED);
  static const Color kpiPink = Color(0xFFEC4899);
  static const Color kpiTeal = Color(0xFF14B8A6);
  static const Color kpiRed = Color(0xFFEF4444);

  static const Color verifiedBadge = Color(0xFF22C55E);
  static const Color starActive = Color(0xFFF59E0B);
  static const Color blue = Color(0xFF173B7B);
  static const Color purple = Color(0xFF7C3AED);
  static const Color pink = Color(0xFFEC4899);
  static const Color teal = Color(0xFF14B8A6);
  static const Color orange = Color(0xFFF36E09);
  static const Color yellow = Color(0xFFF59E0B);
  static const Color green = Color(0xFF22C55E);
  static const Color red = Color(0xFFEF4444);

  static const Color onlineDot = Color(0xFF22C55E);
  static const Color unreadDot = Color(0xFFF36E09);
  static const Color ratingBarInactive = Color(0xFFE2E8F0);
  static const Color ratingBarActive = Color(0xFFF59E0B);
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: AppColors.background,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.textPrimary,
      error: AppColors.error,
    ),
    scaffoldBackgroundColor: AppColors.background,
    textTheme: GoogleFonts.sourceSans3TextTheme().copyWith(
      headlineLarge: GoogleFonts.poppins(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
      headlineMedium: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
      headlineSmall: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
      titleLarge: GoogleFonts.sourceSans3(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary),
      bodyLarge: GoogleFonts.sourceSans3(fontSize: 16, color: AppColors.textPrimary),
      bodyMedium: GoogleFonts.sourceSans3(fontSize: 14, color: AppColors.textPrimary),
      labelLarge: GoogleFonts.sourceSans3(fontSize: 14, fontWeight: FontWeight.w600),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: AppColors.primary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.primary),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.accent,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        textStyle: GoogleFonts.sourceSans3(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: const BorderSide(color: AppColors.primary),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.border)),
      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: const BorderSide(color: AppColors.primary, width: 2)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    cardTheme: CardThemeData(
      color: AppColors.cardBackground,
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.textSecondary,
      type: BottomNavigationBarType.fixed,
      elevation: 8,
    ),
  );
}
