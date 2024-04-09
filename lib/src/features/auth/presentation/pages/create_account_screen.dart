import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/size_utils.dart';
import '../../../../core/theme/app_decoration.dart';
import '../../../../core/theme/custom_text_style.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                              borderRadius: BorderRadiusStyle.customBorderTL15,
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomTextFormField(
                                  controller: usernameController,
                                  hintText: "Username",
                                  textInputType: TextInputType.emailAddress,
                                ),
                                CustomTextFormField(
                                  controller: emailController,
                                  hintText: "Email",
                                  textInputType: TextInputType.emailAddress,
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
                                      hintText: "Show",
                                      textInputAction: TextInputAction.done,
                                      textInputType:
                                          TextInputType.visiblePassword,
                                      obscureText: true,
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
                                      "Confirm Password",
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                    SizedBox(height: 16.v),
                                    CustomTextFormField(
                                      controller: confirmPasswordController,
                                      hintText: "Show",
                                      textInputAction: TextInputAction.done,
                                      textInputType:
                                          TextInputType.visiblePassword,
                                      obscureText: true,
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 4.h),
                                    )
                                  ],
                                ),
                                SizedBox(height: 130.v),
                                CustomElevatedButton(
                                  onPressed: () => signup(
                                      context,
                                      passwordController,
                                      confirmPasswordController,
                                      emailController,
                                      usernameController),
                                  text: "Create account",
                                  buttonTextStyle:
                                      CustomTextStyles.titleMediumOnPrimary,
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Already have account?",
                                        style: theme.textTheme.labelLarge,
                                      ),
                                      TextSpan(
                                        text: " Sign in",
                                        style:
                                            CustomTextStyles.labelLargePrimary,
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
    );
  }
}

void signup(context, passwordController, confirmPasswordController,
    emailController, usernameController) async {
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
      // UserCredential? userCredential =
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      )
          .then((value) {
        createUserDocument(value, usernameController);
        return null;
      });

      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);

      displayMessageToUser(e.code, context);
    }
  }
}

Future<void> createUserDocument(
    UserCredential? userCredential, usernameController) async {
  if (userCredential != null && userCredential.user != null) {
    await FirebaseFirestore.instance
        .collection("Users")
        .doc(userCredential.user!.email)
        .set({
      'email': userCredential.user!.email,
      'username': usernameController.text,
    });
  }
}
