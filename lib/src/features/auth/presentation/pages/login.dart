import 'package:flutter/material.dart';
import 'package:hermione/src/core/utils/screensizeutils.dart';
import 'package:hermione/src/features/auth/presentation/widgets/styled_textfield.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          alignment: Alignment.center,
          height: getScreenSize(context).height / 2,
          margin: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 40,
                child: Text('A'),
              ),
              StyledTextField(
                  hint: 'Username',
                  textEditingController: TextEditingController()),
              StyledTextField(
                  hint: 'hint', textEditingController: TextEditingController()),
            ],
          ),
        ),
      ),
    );
  }
}
