import 'package:flutter/material.dart';
import 'package:hermione/src/core/theme/theme.dart';
import 'package:hermione/src/features/auth/presentation/pages/login.dart';

void main() {
  runApp(MaterialApp(
    themeMode: ThemeMode.system,
    darkTheme: darkTheme,
    theme: lightTheme,
    home: const AuthWrapper(),
  ));
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return const Login();
  }
}
