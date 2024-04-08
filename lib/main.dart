import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hermione/src/core/constants/size_utils.dart';
import 'package:hermione/src/core/theme/theme.dart';
import 'package:hermione/src/features/auth/presentation/pages/onboarding_one_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  ThemeHelper().changeTheme('primary');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp (
          theme: theme,
          title: 'hermoine',
          debugShowCheckedModeBanner: false,
          home: const OnboardingOneScreen(),
        );
      },
    );
  }
}

// class AuthWrapper extends StatelessWidget {
//   const AuthWrapper({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const OnboardingOneScreen();
//   }
// }
