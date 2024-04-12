import 'dart:developer'; // Import dart:developer for using log function

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hermione/src/features/auth/presentation/pages/onboarding_one_screen.dart';

import '../../../assessment/presentation/pages/createquizscreen.dart';
import '../../../home/presentation/pages/homepage.dart';
import '../../data/models/user.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, AsyncSnapshot<User?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Display a loading indicator when waiting for data.
        } else if (snapshot.hasError) {
          return const OnboardingOneScreen(); // Display an error message if an error occurs.
        } else if (!snapshot.hasData || snapshot.data == null) {
          return const OnboardingOneScreen(); // Display a message when no user data is available.
        } else {
          log(snapshot.hasData.toString());
          UserDetails userDetails =
              UserDetails.fromFirebaseUser(snapshot.data!);

          return HomePage(
            userDetails: userDetails,
          );
        }
      },
    );
  }
}
