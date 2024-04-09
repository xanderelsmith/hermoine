import 'package:flutter/material.dart';
import 'package:hermione/src/features/assessment/data/models/quizmodels/created_quiz_viewer_ui/question_model.dart';

import '../../../../../core/constants/colors.dart';

class MultiChoiceUIScreen extends StatelessWidget {
  const MultiChoiceUIScreen({
    super.key,
    required this.screensize,
    required this.topic,
    required this.question,
  });

  final Size screensize;
  final String topic;
  final Question question;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        Container(
            height: screensize.width / 2,
            width: screensize.width,
            decoration: BoxDecoration(
                color: AppColor.transparentContainer,
                borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(question.question),
            )),
        ...List.generate(
          3,
          (index) => ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            tileColor: AppColor.transparentContainer.withOpacity(0.2),
            title: const Text('Hello7'),
          ),
        )
      ]),
    );
  }
}
