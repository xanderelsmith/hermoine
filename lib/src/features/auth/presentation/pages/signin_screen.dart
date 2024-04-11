import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hermione/src/features/auth/presentation/pages/create_account_screen.dart';

import '../../../../core/constants/size_utils.dart';
import '../../../../core/theme/app_decoration.dart';
import '../../../../core/theme/custom_text_style.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../home/presentation/pages/homepage.dart';
import '../../data/models/user.dart';
import 'helper_function.dart';

// ignore_for_file: must_be_immutable
class SigninScreen extends StatefulWidget {
  final void Function()? onTap;

  const SigninScreen({super.key, this.onTap});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void login() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      UserDetails userDetails =
          UserDetails.fromFirebaseUser(userCredential.user!);

      if (context.mounted) Navigator.pop(context);
      Get.to(() => HomePage(userDetails: userDetails));
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessageToUser(e.code, context);
    }
  }

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
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Email",
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                    SizedBox(height: 16.v),
                                    CustomTextFormField(
                                      controller: emailController,
                                      textInputAction: TextInputAction.done,
                                      obscureText: false,
                                      textInputType:
                                          TextInputType.visiblePassword,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 4.h),
                                    )
                                  ],
                                ),
                                SizedBox(height: 37.v),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Password",
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                    SizedBox(height: 16.v),
                                    CustomTextFormField(
                                      controller: passwordController,
                                      textInputAction: TextInputAction.done,
                                      textInputType:
                                          TextInputType.visiblePassword,
                                      obscureText: true,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 4.h),
                                    )
                                  ],
                                ),
                                SizedBox(height: 42.v),
                                Padding(
                                  padding: EdgeInsets.only(left: 205.h),
                                  child: Text(
                                    "Forgot Password?",
                                    style: CustomTextStyles.bodyMediumPrimary,
                                  ),
                                ),
                                SizedBox(height: 65.v),
                                CustomElevatedButton(
                                  text: "Sign in",
                                  onPressed: login,
                                  buttonTextStyle:
                                      CustomTextStyles.titleMediumOnPrimary,
                                ),
                                SizedBox(height: 32.v),
                                Center(
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Don't have an account?",
                                          style: theme.textTheme.labelLarge,
                                        ),
                                        TextSpan(
                                          text: " Create account",
                                          style: CustomTextStyles
                                              .labelLargePrimary,
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Get.to(
                                                  const CreateAccountScreen()); // Navigate to the sign-in screen
                                            },
                                        )
                                      ],
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
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
}
