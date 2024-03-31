import 'package:flutter/material.dart';

import '../constants/colors.dart';

// 1. Define a color scheme
ColorScheme lightColorScheme = ColorScheme.fromSeed(
    seedColor: const Color(0xff007bff),
    primaryContainer:
        AppColor.transparentContainer.withOpacity(0.2), // Your primary color
    brightness: Brightness.light,
    primary: const Color(
      0xff192FB1,
    ));

ColorScheme darkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xff007bff), // Use the same seed color
  brightness: Brightness.dark,
);

// 2. Create a ThemeData instance
ThemeData lightTheme = ThemeData(
  colorScheme: lightColorScheme,
  appBarTheme: const AppBarTheme(
      backgroundColor: Color(
    0xff3F51B5,
  )),
  cardColor: AppColor.transparentContainer.withOpacity(0.2),
  elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          fixedSize: const Size(400, 30),
          backgroundColor: const Color(
            0xff192FB1,
          ),
          foregroundColor: const Color(0xffC5CAE9),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))),
  scaffoldBackgroundColor: const Color(0xff3F51B5),
  primaryColor: const Color(
    0xff192FB1,
  ),
  textTheme: const TextTheme(
    bodyLarge: TextStyle(fontSize: 16.0), // Example text style
  ),
  // Add more theme properties here (e.g., fontFamily, button styles)
);

ThemeData darkTheme = lightTheme.copyWith(
  colorScheme: darkColorScheme,
);

// 3. Define a function to get the theme based on brightness
ThemeData getTheme(BuildContext context) {
  return MediaQuery.of(context).platformBrightness == Brightness.light
      ? lightTheme
      : darkTheme;
}
