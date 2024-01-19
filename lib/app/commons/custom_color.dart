import 'package:flutter/material.dart';

///
/// Theme Light
///
ThemeData customLightTheme() {
  TextTheme _customLightThemesTextTheme(TextTheme base) {
    return base.copyWith(
      headline1: base.headline1!.copyWith(
        fontWeight: FontWeight.w400,
        color: const Color(0xFF1C1F25),
      ),
      headline3: base.headline3!.copyWith(
        color: const Color(0xFF1C1F25),
      ),
      headline4: base.headline4!.copyWith(
        color: const Color(0xFF1C1F25),
      ),
      headline6: base.headline6!.copyWith(
        fontWeight: FontWeight.w500,
        color: const Color(0xFF3D4046),
      ),
      caption: base.caption!.copyWith(
        color: const Color(0xFF1C1F25),
      ),
      bodyText1: base.bodyText1!.copyWith(
        color: const Color(0xFF1C1F25),
      ),
      bodyText2: base.bodyText2!.copyWith(
        color: const Color(0xFF3D4046),
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
      headline1: base.headline1!.copyWith(
        fontWeight: FontWeight.w400,
        color: const Color(0xFFF6F9FF),
      ),
      headline3: base.headline3!.copyWith(
        color: const Color(0xFFF6F9FF),
      ),
      headline4: base.headline4!.copyWith(
        color: const Color(0xFFF6F9FF),
      ),
      headline6: base.headline6!.copyWith(
        fontWeight: FontWeight.w500,
        color: const Color(0xFFF6F9FF),
      ),
      caption: base.caption!.copyWith(
        color: const Color(0xFFF6F9FF),
      ),
      bodyText1: base.bodyText1!.copyWith(
        color: const Color(0xFFF6F9FF),
      ),
      bodyText2: base.bodyText2!.copyWith(
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
