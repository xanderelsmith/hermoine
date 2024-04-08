import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hermione/src/core/constants/size_utils.dart';

import '../../../../core/constants/image_constant.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import 'onboarding_four_screen.dart';
import 'onboarding_three_screen.dart';

class OnboardingTwoScreen extends StatelessWidget {
  const OnboardingTwoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 23.h,
            vertical: 44.v,
          ),
          child: Column(
            children: [
              const Spacer(),
              CustomImageView(
                imagePath: ImageConstant.imgEllipse1,
                height: 304.adaptSize,
                width: 304.adaptSize,
                radius: BorderRadius.circular(
                  152.h,
                ),
              ),
              SizedBox(height: 38.v),
              Container(
                width: 271.h,
                margin: EdgeInsets.only(
                  left: 21.h,
                  right: 20.h,
                ),
                child: Text(
                  "Learn Online From Your Home",
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
                        Get.to(() => const OnboardingThreeScreen());
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
