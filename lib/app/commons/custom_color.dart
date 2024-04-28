import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///
/// Theme Light
///
TextTheme _customLightThemesTextTheme(TextTheme base) {
  return base.copyWith(
    displayLarge: GoogleFonts.lato(
      fontWeight: FontWeight.w400,
      color: const Color(0xFF1C1F25),
    ),
    displaySmall: GoogleFonts.lato(
      color: const Color(0xFF1C1F25),
    ),
    headlineMedium: GoogleFonts.lato(
      color: const Color(0xFF1C1F25),
    ),
    titleLarge: GoogleFonts.lato(
      fontWeight: FontWeight.w500,
      color: const Color(0xFF3D4046),
    ),
    bodySmall: GoogleFonts.lato(
      color: const Color(0xFF1C1F25),
    ),
    bodyLarge: GoogleFonts.lato(
      color: const Color(0xFF1C1F25),
    ),
    bodyMedium: GoogleFonts.lato(
      color: const Color(0xFF3D4046),
    ),
    displayMedium: GoogleFonts.lato(
      color: const Color(0xFF1C1F25),
    ),
    headlineSmall: GoogleFonts.lato(
      color: const Color(0xFF1C1F25),
    ),
    titleMedium: GoogleFonts.lato(
      color: const Color(0xFF1C1F25),
    ),
    titleSmall: GoogleFonts.lato(
      color: const Color(0xFF1C1F25),
    ),
    labelLarge: GoogleFonts.lato(
      color: const Color(0xFF1C1F25),
    ),
    labelSmall: GoogleFonts.lato(
      color: const Color(0xFF1C1F25),
    ),
  );
}

var colorSchemeTheme = const ColorScheme(
  primary: Color(0xFFF4D300),
  onPrimary: Color(0xFF1B1A15),
  primaryContainer: Color(0xFFF4D300),
  background: Color(0xFFF2F4F4),
  onBackground: Color(0xFFF2F4F4),
  secondary: Color(0xFF0C0C0C),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFF0C0C0C),
  error: Color(0xFFDB3030),
  onError: Color(0xFFFFFFFF),
  surface: Color(0xFFFFFFFF),
  onSurface: Color(0xFF1C1F25),
  brightness: Brightness.light,
);
ThemeData customLightTheme() {
  final ThemeData lightTheme = ThemeData.light();
  return lightTheme.copyWith(
    textTheme: _customLightThemesTextTheme(lightTheme.textTheme),
    primaryColor: const Color(0xFFF4D300),
    indicatorColor: const Color(0xFF0C0C0C),
    scaffoldBackgroundColor: const Color(0xFFF2F4F4),
    primaryIconTheme: lightTheme.primaryIconTheme.copyWith(
      color: const Color(0xFF1C1F25),
      size: 20,
    ),
    iconTheme: lightTheme.iconTheme.copyWith(
      color: const Color(0xFF1C1F25),
    ),
    cardColor: const Color(0xFFececec),
    tabBarTheme: lightTheme.tabBarTheme.copyWith(
      labelColor: const Color(0xFFF4D300),
      unselectedLabelColor: Colors.grey,
    ),
    buttonTheme: lightTheme.buttonTheme.copyWith(
      buttonColor: const Color(0xFFF4D300),
    ), colorScheme: colorSchemeTheme.copyWith(background: const Color(0xFFF2F4F4)).copyWith(error: const Color(0xFFDB3030)),
  );
}

///
/// Theme Dark
///
ThemeData customDarkTheme() {
  TextTheme customDarkThemesTextTheme(TextTheme base) {
    return base.copyWith(
      displayLarge: GoogleFonts.lato(
        fontWeight: FontWeight.w400,
        color: const Color(0xFFF6F9FF),
      ),
      displaySmall: GoogleFonts.lato(
        color: const Color(0xFFF6F9FF),
      ),
      headlineMedium: GoogleFonts.lato(
        color: const Color(0xFFF6F9FF),
      ),
      titleLarge: GoogleFonts.lato(
        fontWeight: FontWeight.w500,
        color: const Color(0xFFF6F9FF),
      ),
      bodySmall: GoogleFonts.lato(
        color: const Color(0xFFF6F9FF),
      ),
      bodyLarge: GoogleFonts.lato(
        color: const Color(0xFFF6F9FF),
      ),
      bodyMedium: GoogleFonts.lato(
        color: const Color(0xFFF6F9FF),
      ),
    );
  }

  var colorSchemeTheme = const ColorScheme(
    primary: Color(0xFFF4D300),
    onPrimary: Color(0xFF1B1A15),
    primaryContainer: Color(0xFFF4D300),
    background: Color(0xFF17202A),
    onBackground: Color(0xFF17202A),
    secondary: Color(0xFF0C0C0C),
    onSecondary: Color(0xFFFFFFFF),
    secondaryContainer: Color(0xFF0C0C0C),
    error: Color(0xFFDB3030),
    onError: Color(0xFFFFFFFF),
    surface: Color(0xFFFFFFFF),
    onSurface: Color(0xFF1C1F25),
    brightness: Brightness.light,
  );

  final ThemeData lightTheme = ThemeData.light();
  return lightTheme.copyWith(
    textTheme: customDarkThemesTextTheme(lightTheme.textTheme),
    primaryColor: const Color(0xFFF4D300),
    indicatorColor: const Color(0xFF0C0C0C),
    scaffoldBackgroundColor: const Color(0xFF17202A),
    primaryIconTheme: lightTheme.primaryIconTheme.copyWith(
      color: const Color(0xFF1C1F25),
      size: 20,
    ),
    iconTheme: lightTheme.iconTheme.copyWith(
      color: const Color(0xFF1C1F25),
    ),
    cardColor: const Color(0xFFececec),
    tabBarTheme: lightTheme.tabBarTheme.copyWith(
      labelColor: const Color(0xFFF4D300),
      unselectedLabelColor: Colors.grey,
    ),
    buttonTheme: lightTheme.buttonTheme.copyWith(
      buttonColor: const Color(0xFFF4D300),
    ), colorScheme: colorSchemeTheme.copyWith(background: const Color(0xFF17202A)).copyWith(error: const Color(0xFFDB3030)),
  );
}
