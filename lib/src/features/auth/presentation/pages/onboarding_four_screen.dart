import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hermione/src/core/constants/size_utils.dart';
import 'package:hermione/src/features/auth/presentation/pages/create_account_screen.dart';
import 'package:hermione/src/features/auth/presentation/pages/signin_screen.dart';

import '../../../../core/constants/image_constant.dart';
import '../../../../core/theme/custom_text_style.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';

class OnboardingFourScreen extends StatelessWidget {
  const OnboardingFourScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 25.h,
            vertical: 21.v,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              CustomImageView(
                imagePath: ImageConstant.imgEllipse11,
                height: 304.adaptSize,
                width: 304.adaptSize,
                radius: BorderRadius.circular(
                  152.h,
                ),
                margin: EdgeInsets.only(left: 3.h),
              ),
              SizedBox(height: 38.v),
              Text(
                "Welcome to Hermoine.",
                style: theme.textTheme.headlineSmall,
              ),
              SizedBox(height: 32.v),
              Text(
                "Sign in as a",
                style: theme.textTheme.titleMedium,
              ),
              SizedBox(height: 40.v),
              CustomElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: ((context) => const SigninScreen())));
                },
                text: "Student",
                buttonTextStyle: CustomTextStyles.titleMediumOnPrimary,
              ),
              SizedBox(height: 13.v),
              CustomOutlinedButton(
                onPressed: () {
                  Get.to(() => const CreateAccountScreen());
                },
                text: "Teacher",
                buttonTextStyle: theme.textTheme.titleMedium!,
              )
            ],
          ),
        ),
      ),
    );
  }
}
