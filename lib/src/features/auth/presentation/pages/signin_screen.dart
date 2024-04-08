import 'package:flutter/material.dart';

import '../../../../core/constants/size_utils.dart';
import '../../../../core/theme/app_decoration.dart';
import '../../../../core/theme/custom_text_style.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';

// ignore_for_file: must_be_immutable
class SigninScreen extends StatelessWidget {
  SigninScreen({Key? key})
      : super(
          key: key,
        );

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SizedBox(
          width: SizeUtils.width,
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Form(
              key: _formKey,
              child: SizedBox(
                width: double.maxFinite,
                child: Column(
                  children: [
                    SizedBox(height: 70.v),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 0,
                      color: appTheme.blueGray100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusStyle.circleBorder75,
                      ),
                      child: Container(
                        height: 150.adaptSize,
                        width: 150.adaptSize,
                        padding: EdgeInsets.all(25.h),
                        decoration: AppDecoration.fillBlueGray.copyWith(
                          borderRadius: BorderRadiusStyle.circleBorder75,
                        ),
                        child: Stack(
                          alignment: Alignment.centerLeft,
                          children: [
                            const Align(
                              alignment: Alignment.center,
                              child: SizedBox(
                                child: Divider(),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: SizedBox(
                                child: Divider(
                                  indent: 1.h,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 60.v),
                    Container(
                      decoration: AppDecoration.fillPrimary.copyWith(
                        borderRadius: BorderRadiusStyle.customBorderTL15,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 20.v),
                          Padding(
                            padding: EdgeInsets.only(left: 28.h),
                            child: Text(
                              "Sign In",
                              style: theme.textTheme.titleLarge,
                            ),
                          ),
                          SizedBox(height: 9.v),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 25.h,
                              vertical: 22.v,
                            ),
                            decoration: AppDecoration.fillOnPrimary.copyWith(
                              borderRadius: BorderRadiusStyle.customBorderTL15,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 13.v),
                                CustomTextFormField(
                                  controller: emailController,
                                  hintText: "Email",
                                  textInputType: TextInputType.emailAddress,
                                ),
                                SizedBox(height: 37.v),
                                _buildColumnpassword(context),
                                SizedBox(height: 42.v),
                                Padding(
                                  padding: EdgeInsets.only(left: 5.h),
                                  child: Text(
                                    "Forgot Password?",
                                    style: CustomTextStyles.bodyMediumPrimary,
                                  ),
                                ),
                                SizedBox(height: 70.v),
                                CustomElevatedButton(
                                  text: "Sign in",
                                  buttonTextStyle:
                                      CustomTextStyles.titleMediumOnPrimary,
                                ),
                                SizedBox(height: 12.v),
                                CustomOutlinedButton(
                                  text: "Create account",
                                  buttonTextStyle: theme.textTheme.titleMedium!,
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildColumnpassword(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Password",
          style: theme.textTheme.bodyMedium,
        ),
        SizedBox(height: 16.v),
        CustomTextFormField(
          controller: passwordController,
          hintText: "Show",
          textInputAction: TextInputAction.done,
          textInputType: TextInputType.visiblePassword,
          obscureText: true,
          contentPadding: EdgeInsets.symmetric(horizontal: 4.h),
        )
      ],
    );
  }
}
