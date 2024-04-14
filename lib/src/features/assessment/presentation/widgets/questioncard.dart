import 'package:flutter/material.dart';
import 'package:hermione/src/core/constants/size_utils.dart';
import 'package:rive/rive.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constants.dart';
import '../../data/models/quizmodels/created_quiz_viewer_ui/question_model.dart';
import '../pages/quiz/multichoicescreen.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.screensize,
    required this.question,
    required this.animationChild,
  });
  final RiveAnimation animationChild;
  final Size screensize;
  final Question question;
  @override
  Widget build(BuildContext context) {
    var hIntWidget = HIntWidget;
    return Container(
        height: screensize.width / 2,
        width: screensize.width,
        decoration: BoxDecoration(
            color: AppColor.white, borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Stack(
                  children: [
                    Center(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Text(
                              question.question,
                              textAlign: TextAlign.center,
                              style: AppTextStyle.mediumTitlename,
                            ),
                          ),
                          const Expanded(child: SizedBox())
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: getScreenSize(context).width / 3),
                      child: animationChild,
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: HIntWidget(question: question),
            )
          ],
        ));
  }
}
