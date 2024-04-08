import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hermione/src/core/constants/size_utils.dart';

import '../../../../core/theme/theme.dart';
import 'onboarding_two_screen.dart';

class OnboardingOneScreen extends StatelessWidget {
  const OnboardingOneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      Get.to(() => const OnboardingTwoScreen());
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary,
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 2.v),
              Text(
                "Hermoine",
                style: theme.textTheme.headlineLarge,
              )
            ],
          ),
        ),
      ),
    );
  }
}
