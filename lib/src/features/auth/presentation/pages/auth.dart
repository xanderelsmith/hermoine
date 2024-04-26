import 'dart:developer'; // Import dart:developer for using log function

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hermione/src/features/auth/presentation/pages/onboarding_one_screen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../assessment/presentation/pages/createquizscreen.dart';
import '../../../home/domain/repositories/currentuserrepository.dart';
import '../../../home/presentation/pages/homepage.dart';
import '../../data/models/user.dart';

class AuthPage extends ConsumerWidget {
  const AuthPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          log(snapshot.data.toString());
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

Future<UserDetails?> fetchUserDetails(String userEmail) async {
  try {
    final documentSnapshot = await FirebaseFirestore.instance
        .collection('Users')
        .doc(userEmail)
        .get();

    if (documentSnapshot.exists) {
      final userData = documentSnapshot.data();
      if (userData != null) {
        log("User document exists");
        return UserDetails.fromFirebaseData(userData);
      } else {
        // Handle the unexpected case where document exists but data is null
        log("User document exists but data is null for $userEmail");
        return null; // Or throw an exception if appropriate
      }
    } else {
      log("User document does not exist for $userEmail");
      return null;
    }
  } on FirebaseException catch (e) {
    log("Error fetching user data: $e");
    return null;
  }
}
