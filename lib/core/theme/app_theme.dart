/*import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: GoogleFonts.poppinsTextTheme(),
    scaffoldBackgroundColor: const Color(0xFF0F172A),
    primaryColor: const Color(0xFF6366F1),
    useMaterial3: true,
  );
}  

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Define our custom color palette
  static const Color skyBlue = Color(0xFF87CEEB); // Sky Blue
  static const Color electricBlue = Color(0xFF00BFFF); // Deep Sky Blue
  static const Color deepSpace = Color(0xFF0A192F); // Deep Navy
  static const Color surfaceBlue = Color(0xFF172A45); // Lighter Navy for cards
  static const Color pureWhite = Color(0xFFFFFFFF);

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    // Applying Google Fonts to the entire app
    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme),

    scaffoldBackgroundColor: deepSpace,
    primaryColor: skyBlue,

    // Defining the ColorScheme for Material 3 components
    colorScheme: const ColorScheme.dark(
      primary: skyBlue,
      secondary: electricBlue,
      surface: surfaceBlue,
      onPrimary: deepSpace,
      onSurface: pureWhite,
    ),

    // High-Level UI: Global Input Decoration (Text Fields)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white.withOpacity(0.05),
      labelStyle: const TextStyle(color: skyBlue),
      prefixIconColor: skyBlue,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: skyBlue, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
    ),

    // High-Level UI: Elevated Button Style
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: skyBlue,
        foregroundColor: deepSpace,
        elevation: 10,
        shadowColor: skyBlue.withOpacity(0.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    ),
  );
}  */

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color skyBlue = Color(0xFF87CEEB);
  static const Color deepNavy = Color(0xFF0A192F);
  static const Color surfaceNavy = Color(0xFF1C2C4E); // Slightly lighter navy
  static const Color pureWhite = Color(0xFFFFFFFF);
  static const Color softBlue = Color(0xFFE1F5FE); // For light accents

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,

    // Scaffolding with a hint of light blue reflection
    scaffoldBackgroundColor: const Color(0xFF0D1B3E),
    primaryColor: skyBlue,

    textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme)
        .copyWith(
          displayLarge: const TextStyle(
            color: pureWhite,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: const TextStyle(color: softBlue),
        ),

    colorScheme: const ColorScheme.dark(
      primary: skyBlue,
      secondary: pureWhite, // Adding white as secondary for contrast
      surface: surfaceNavy,
      onSurface: pureWhite,
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: pureWhite.withOpacity(0.08), // Brighter input background
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: BorderSide(color: skyBlue.withOpacity(0.1)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(18),
        borderSide: const BorderSide(color: skyBlue, width: 2),
      ),
      labelStyle: const TextStyle(color: skyBlue, fontWeight: FontWeight.w500),
      prefixIconColor: skyBlue,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: skyBlue,
        foregroundColor: deepNavy,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        elevation: 8,
        shadowColor: skyBlue.withOpacity(0.4),
      ),
    ),
  );
}
