import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hermione/src/core/constants/size_utils.dart';
import 'package:hermione/src/core/theme/theme.dart';
import 'package:hermione/src/core/widgets/widgets.dart';

import '../../../../core/theme/custom_text_style.dart';

class ForgetPasswordScreen extends StatefulWidget {
  ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailController.text)
          .then((value) => Navigator.of(context).pop());
      showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text("Password reset link sent! Check your email"),
            );
          });
    } on FirebaseAuthException catch (e) {
      // print(e);
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.onPrimary.withOpacity(1),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: const Center(child: Text("Forgot Password")),
          leadingWidth: 43.h,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_sharp)),
        ),
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
                  child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.all(24.h),
                    child: Column(
                      children: [
                        const Text(
                          "Please enter your email to reset the password",
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(
                          height: 22.v,
                        ),
                        CustomTextFormField(
                          controller: emailController,
                          hintText: "Email",
                          hintStyle: theme.textTheme.bodyMedium!,
                          textInputAction: TextInputAction.done,
                          textInputType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 92.v,
                        ),
                        CustomElevatedButton(
                          text: "Reset Password",
                          buttonTextStyle:
                              CustomTextStyles.titleMediumOnPrimary,
                          onPressed: passwordReset,
                        )
                      ],
                    ),
                  )),
            ),
          ),
        ),
      ),
    );
  }
}
