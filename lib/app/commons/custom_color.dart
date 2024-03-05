import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

///
/// Theme Light
///
TextTheme _customLightThemesTextTheme(TextTheme base) {
  return base.copyWith(
    headline1: GoogleFonts.lato(
      fontWeight: FontWeight.w400,
      color: const Color(0xFF1C1F25),
    ),
    headline3: GoogleFonts.lato(
      color: const Color(0xFF1C1F25),
    ),
    headline4: GoogleFonts.lato(
      color: const Color(0xFF1C1F25),
    ),
    headline6: GoogleFonts.lato(
      fontWeight: FontWeight.w500,
      color: const Color(0xFF3D4046),
    ),
    caption: GoogleFonts.lato(
      color: const Color(0xFF1C1F25),
    ),
    bodyText1: GoogleFonts.lato(
      color: const Color(0xFF1C1F25),
    ),
    bodyText2: GoogleFonts.lato(
      color: const Color(0xFF3D4046),
    ),
    headline2: GoogleFonts.lato(
      color: const Color(0xFF1C1F25),
    ),
    headline5: GoogleFonts.lato(
      color: const Color(0xFF1C1F25),
    ),
    subtitle1: GoogleFonts.lato(
      color: const Color(0xFF1C1F25),
    ),
    subtitle2: GoogleFonts.lato(
      color: const Color(0xFF1C1F25),
    ),
    button: GoogleFonts.lato(
      color: const Color(0xFF1C1F25),
    ),
    overline: GoogleFonts.lato(
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
    colorScheme: colorSchemeTheme,
    primaryIconTheme: lightTheme.primaryIconTheme.copyWith(
      color: const Color(0xFF1C1F25),
      size: 20,
    ),
    iconTheme: lightTheme.iconTheme.copyWith(
      color: const Color(0xFF1C1F25),
    ),
    backgroundColor: const Color(0xFFF2F4F4),
    cardColor: const Color(0xFFececec),
    tabBarTheme: lightTheme.tabBarTheme.copyWith(
      labelColor: const Color(0xFFF4D300),
      unselectedLabelColor: Colors.grey,
    ),
    buttonTheme: lightTheme.buttonTheme.copyWith(
      buttonColor: const Color(0xFFF4D300),
    ),
    errorColor: const Color(0xFFDB3030),
  );
}

///
/// Theme Dark
///
ThemeData customDarkTheme() {
  TextTheme _customDarkThemesTextTheme(TextTheme base) {
    return base.copyWith(
      headline1: GoogleFonts.lato(
        fontWeight: FontWeight.w400,
        color: const Color(0xFFF6F9FF),
      ),
      headline3: GoogleFonts.lato(
        color: const Color(0xFFF6F9FF),
      ),
      headline4: GoogleFonts.lato(
        color: const Color(0xFFF6F9FF),
      ),
      headline6: GoogleFonts.lato(
        fontWeight: FontWeight.w500,
        color: const Color(0xFFF6F9FF),
      ),
      caption: GoogleFonts.lato(
        color: const Color(0xFFF6F9FF),
      ),
      bodyText1: GoogleFonts.lato(
        color: const Color(0xFFF6F9FF),
      ),
      bodyText2: GoogleFonts.lato(
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
    textTheme: _customDarkThemesTextTheme(lightTheme.textTheme),
    primaryColor: const Color(0xFFF4D300),
    indicatorColor: const Color(0xFF0C0C0C),
    scaffoldBackgroundColor: const Color(0xFF17202A),
    colorScheme: colorSchemeTheme,
    primaryIconTheme: lightTheme.primaryIconTheme.copyWith(
      color: const Color(0xFF1C1F25),
      size: 20,
    ),
    iconTheme: lightTheme.iconTheme.copyWith(
      color: const Color(0xFF1C1F25),
    ),
    backgroundColor: const Color(0xFF17202A),
    cardColor: const Color(0xFFececec),
    tabBarTheme: lightTheme.tabBarTheme.copyWith(
      labelColor: const Color(0xFFF4D300),
      unselectedLabelColor: Colors.grey,
    ),
    buttonTheme: lightTheme.buttonTheme.copyWith(
      buttonColor: const Color(0xFFF4D300),
    ),
    errorColor: const Color(0xFFDB3030),
  );
}
