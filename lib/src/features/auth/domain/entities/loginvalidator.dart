import 'package:flutter/material.dart';

class LoginValidator {
  static bool validateForm(
    BuildContext context, {
    required bool isLogin,
    emailController,
    username,
    passwordController,
  }) {
    bool isValid = true;

    // Email Validation
    if (emailController != null && isLogin == false) {
      isValid = false;
      showEmptyFieldErrorSnackBar(context);
    }
    if (username.text.isEmpty) {
      isValid = false;
      showEmptyFieldErrorSnackBar(context);
    }

    // Username Validation (Optional)
    // You can optionally add username validation here

    // Password Validation
    if (passwordController.text.isEmpty) {
      isValid = false;
      showEmptyFieldErrorSnackBar(context);
    } else if (passwordController.text.length < 6) {
      isValid = false;
      showSnackBar(context, message: 'Password must be at least 6 characters.');
    }

    return isValid;
  }

  static showEmptyFieldErrorSnackBar(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Please fill in all required fields.'),
      ),
    );
  }
}

showSnackBar(BuildContext context, {required String message}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
