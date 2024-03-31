import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hermione/src/core/utils/screensizeutils.dart';
import 'package:hermione/src/features/auth/presentation/widgets/styled_textfield.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool shouldLogin = false;
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
                          hint: 'EmailAddress',
                          textEditingController: TextEditingController()),
                      StyledTextField(
                          hint: 'Password',
                          textEditingController: TextEditingController()),
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
                                  onPressed: () {},
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
