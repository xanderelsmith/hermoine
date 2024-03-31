import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hermione/src/core/services/api_services.dart';
import 'package:hermione/src/core/utils/screensizeutils.dart';
import 'package:hermione/src/features/auth/presentation/widgets/styled_textfield.dart';
import 'package:hermione/src/features/home/presentation/pages/homepage.dart';

import '../../domain/entities/loginvalidator.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> _animation;

  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool shouldLogin = false;
  double progress = 0.0;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2))
          ..addListener(() {
            setState(() {});
          });
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment:
                shouldLogin ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Expanded(child: SizedBox()),
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color(0xffC5CAE9).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  height: getScreenSize(context).height / 1.8,
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 50,
                        child: Text('A'),
                      ),
                      StyledTextField(
                          hint: 'EmailAddress',
                          textEditingController: emailController),
                      StyledTextField(
                          hint: 'Username (Nickname)',
                          textEditingController: usernameController),
                      StyledTextField(
                          hint: 'Password',
                          textEditingController: passwordController),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: shouldLogin
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: LinearProgressIndicator(
                                value: _animation.value,
                              ),
                            ),
                            const Text('Please wait...')
                          ],
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                  onPressed: () {
                                    bool canLogin = LoginValidator.validateForm(
                                        emailController,
                                        usernameController,
                                        passwordController,
                                        context);
                                    print(canLogin);
                                    if (canLogin) {
                                      setState(() {
                                        shouldLogin = true;
                                      });
                                      controller.forward();

                                      // ApiService.doUsersignUp(
                                      //         username: usernameController.text,
                                      //         password: passwordController.text,
                                      //         emailadress: emailController.text)
                                      //     .then((value) => Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //             builder: (context) =>
                                      //                 const HomePage())));
                                    }
                                  },
                                  child: const Text('Register')),
                            ),
                          ),
                          TextButton(
                              onPressed: () {}, child: const Text('Log in')),
                        ],
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
