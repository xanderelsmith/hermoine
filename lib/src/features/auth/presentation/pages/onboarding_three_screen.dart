import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hermione/src/core/constants/size_utils.dart';

import '../../../../core/constants/image_constant.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import 'onboarding_four_screen.dart';

class OnboardingThreeScreen extends StatelessWidget {
  const OnboardingThreeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 28.h,
            vertical: 44.v,
          ),
          child: Column(
            children: [
              const Spacer(),
              CustomImageView(
                imagePath: ImageConstant.imgEllipse1304x304,
                height: 304.adaptSize,
                width: 304.adaptSize,
                radius: BorderRadius.circular(
                  152.h,
                ),
              ),
              SizedBox(height: 39.v),
              Container(
                width: 214.h,
                margin: EdgeInsets.symmetric(horizontal: 44.h),
                child: Text(
                  "Explore, Learn and Achieve with us!",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineSmall,
                ),
              ),
              SizedBox(height: 65.v),
              CustomIconButton(
                  height: 46.adaptSize,
                  width: 46.adaptSize,
                  padding: EdgeInsets.all(1.h),
                  decoration: IconButtonStyleHelper.fillPrimary,
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {
                        Get.to(() => const OnboardingFourScreen());
                      },
                      icon: const Icon(
                        Icons.arrow_forward_outlined,
                        color: Colors.white,
                      ))),
              SizedBox(height: 15.v),
              TextButton(
                  onPressed: () {
                    Get.to(() => const OnboardingFourScreen());
                  },
                  child: Text(
                    "Skip",
                    style: theme.textTheme.titleMedium,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
