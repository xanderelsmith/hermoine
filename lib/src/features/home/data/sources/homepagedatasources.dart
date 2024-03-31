import 'package:flutter/material.dart';
import 'package:hermione/src/features/assessment/presentation/pages/assessmentlistscreen.dart';
import 'package:hermione/src/features/auth/presentation/widgets/styled_textfield.dart';
import 'package:hermione/src/features/home/data/models/homeicons.dart';

import '../../../../core/constants/colors.dart';

List<HomeIcons> homeIcons(context) => [
      HomeIcons(
          imageUrl: 'assets/icons/take.png',
          name: 'Take Quiz',
          onTap: () {
            var textEditingController;
            showDialog(
                context: context,
                builder: ((context) => AlertDialog(
                      title: const Text('Input Assessment Code'),
                      actions: [
                        ElevatedButton(
                            onPressed: () {}, child: const Text('Enter'))
                      ],
                      content: StyledTextField(
                          innerHint: '123rre',
                          controller: TextEditingController()),
                    )));
          }),
      HomeIcons(
          imageUrl: 'assets/icons/create.png',
          name: 'Create Quiz',
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const AllAssessments()));
          }),
    ];
