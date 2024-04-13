import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hermione/src/features/auth/presentation/pages/signin_screen.dart';

import '../../../../core/constants/size_utils.dart';
import '../../../../core/theme/app_decoration.dart';
import '../../../../core/theme/custom_text_style.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
import '../../../home/presentation/pages/homepage.dart';
import '../../data/models/user.dart';
import 'helper_function.dart'; // ignore_for_file: must_be_immutable

class CreateAccountScreen extends StatefulWidget {
  final void Function()? onTap;

  const CreateAccountScreen({super.key, this.onTap});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController usernameController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void signup() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    if (passwordController.text != confirmPasswordController.text) {
      Navigator.pop(context);

      displayMessageToUser("Password don't match!", context);
    } else {
      try {
        UserCredential? userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        UserDetails userDetails =
            UserDetails.fromFirebaseUser(userCredential.user!);
        createUserDocument(userCredential);
        Get.off(() => HomePage(userDetails: userDetails));
        // if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);

        displayMessageToUser(e.code, context);
      }
    }
  }

  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'username': usernameController.text,
        'bio': 'Empty bio..',
        'age': 'Empty age..',
        'gender': 'unknown..',
        'birthday': 'No date selected..',
        'profileImageUrl': 'No profileImage selected..',
        'name': 'Empty name..'
      });
    }
  }

  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  double password_strength = 0;

  bool validatePassword(String pass) {
    String _password = pass.trim();
    if (_password.isEmpty) {
      setState(() {
        password_strength = 0;
      });
    } else if (_password.length < 6) {
      setState(() {
        password_strength = 1 / 4;
      });
    } else if (_password.length < 8) {
      setState(() {
        password_strength = 2 / 4;
      });
    } else {
      if (pass_valid.hasMatch(_password)) {
        setState(() {
          password_strength = 4 / 4;
        });
        return true;
      } else {
        setState(() {
          password_strength = 3 / 4;
        });
        return false;
      }
    }
    return false;
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
            child: SizedBox(
              height: SizeUtils.height,
              child: Form(
                key: _formKey,
                child: SizedBox(
                  width: double.maxFinite,
                  child: Column(
                    children: [
                      SizedBox(height: 26.v),
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
                        ),
                      ),
                      const Spacer(),
                      Container(
                        decoration: AppDecoration.fillPrimary.copyWith(
                          borderRadius: BorderRadiusStyle.customBorderTL15,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 18.v),
                            Padding(
                              padding: EdgeInsets.only(left: 28.h),
                              child: Text(
                                "Create Account",
                                style: theme.textTheme.titleLarge,
                              ),
                            ),
                            SizedBox(height: 11.v),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 25.h,
                                vertical: 33.v,
                              ),
                              decoration: AppDecoration.fillOnPrimary.copyWith(
                                borderRadius:
                                    BorderRadiusStyle.customBorderTL15,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Username",
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                      SizedBox(height: 5.v),
                                      CustomTextFormField(
                                        controller: usernameController,
                                        textInputAction: TextInputAction.done,
                                        textInputType:
                                            TextInputType.visiblePassword,
                                        obscureText: false,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 4.h),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 17.v),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        validator: (val) {
                                          return RegExp(
                                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                  .hasMatch(val!)
                                              ? null
                                              : "Enter a valid email address";
                                        },
                                        textInputType:
                                            TextInputType.visiblePassword,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 4.h),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 17.v),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Password",
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                      SizedBox(height: 16.v),
                                      CustomTextFormField(
                                        validator: (value) {
                                          if (value == '') {
                                            return "Please enter password";
                                          } else {
                                            //call function to check password
                                            bool result =
                                                validatePassword(value!);
                                            if (result) {
                                              return null;
                                            } else {
                                              return 'Password must contain an uppercase character, a lowercase character, a number, a symbol and minimum of 8 characters';
                                            }
                                          }
                                        },
                                        controller: passwordController,
                                        textInputAction: TextInputAction.done,
                                        textInputType:
                                            TextInputType.visiblePassword,
                                        obscureText: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 4.h),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 17.v),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Confirm Password",
                                        style: theme.textTheme.bodyMedium,
                                      ),
                                      SizedBox(height: 16.v),
                                      CustomTextFormField(
                                        controller: confirmPasswordController,
                                        textInputAction: TextInputAction.done,
                                        validator: (value) {
                                          if (value == '') {
                                            return "Please enter your password again";
                                          } else {
                                            if (passwordController.text ==
                                                confirmPasswordController
                                                    .text) {
                                              return null;
                                            } else {
                                              return 'Password do not match';
                                            }
                                          }
                                        },
                                        textInputType:
                                            TextInputType.visiblePassword,
                                        obscureText: true,
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 4.h),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 130.v),
                                  CustomElevatedButton(
                                    onPressed: signup,
                                    text: "Create account",
                                    buttonTextStyle:
                                        CustomTextStyles.titleMediumOnPrimary,
                                  ),
                                  SizedBox(height: 32.v),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "Already have account?",
                                          style: theme.textTheme.labelLarge,
                                        ),
                                        TextSpan(
                                          text: " Sign in",
                                          style: CustomTextStyles
                                              .labelLargePrimary,
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Get.to(
                                                  const SigninScreen()); // Navigate to the sign-in screen
                                            },
                                        )
                                      ],
                                    ),
                                    textAlign: TextAlign.left,
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
      ),
    );
  }
}
