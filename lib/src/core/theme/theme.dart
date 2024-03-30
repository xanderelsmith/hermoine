import 'package:flutter/material.dart';

// 1. Define a color scheme
ColorScheme lightColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xff007bff),
  primaryContainer: const Color(0xffC5CAE9), // Your primary color
  brightness: Brightness.light,
);

ColorScheme darkColorScheme = ColorScheme.fromSeed(
  seedColor: const Color(0xff007bff), // Use the same seed color
  brightness: Brightness.dark,
);

// 2. Create a ThemeData instance
ThemeData lightTheme = ThemeData(
  colorScheme: lightColorScheme,
  scaffoldBackgroundColor: const Color(0xff3F51B5),
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
