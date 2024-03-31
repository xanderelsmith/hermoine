import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hermione/src/core/utils/screensizeutils.dart';
import 'package:hermione/src/features/auth/presentation/widgets/styled_textfield.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../../core/global/userdetail.dart';
import '../../../../core/services/api_services.dart';
import '../../../home/presentation/pages/homepage.dart';
import '../../domain/entities/loginvalidator.dart';

class Login extends StatefulWidget {
  const Login({super.key});
  static String id = '/Login';
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? _animation;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool shouldLogin = false;
  double progress = 0.0;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..addListener(() {
            setState(() {});
          });
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller!)
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
              Expanded(child: SizedBox()),
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
                          innerHint: 'Username',
                          controller: usernameController),
                      StyledTextField(
                          innerHint: 'Password',
                          controller: passwordController),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: shouldLogin
                    ? const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            LinearProgressIndicator(
                              value: 0.72,
                            ),
                            Text('Please wait...')
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
                                        context,
                                        username: usernameController,
                                        passwordController: passwordController,
                                        isLogin: true);
                                    print(canLogin);
                                    if (canLogin) {
                                      setState(() {
                                        shouldLogin = true;
                                      });
                                      controller!.forward();
                                      if (_animation!.value >= 0.7) {
                                        controller!.stop();
                                      }

                                      ApiService.doUserLogin(
                                        username: usernameController.text,
                                        password: passwordController.text,
                                      ).then((value) {
                                        controller!.forward();
                                        ParseUser result = value.result;
                                        context.pushNamed(HomePage.id,
                                            extra: result.toJson());
                                      }).onError((error, stackTrace) {
                                        log(error.toString());
                                        setState(() {
                                          shouldLogin = false;
                                        });
                                        return showSnackBar(context,
                                            message:
                                                'Check internet connection and try again');
                                      });
                                    }
                                  },
                                  child: const Text('Log in')),
                            ),
                          ),
                          TextButton(
                              onPressed: () {}, child: const Text('Sign up')),
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
