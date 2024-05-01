import 'package:flutter/material.dart';
import 'package:hermione/src/core/constants/size_utils.dart';
import 'package:hermione/src/features/assessment/domain/repositories/retievedquizdata.dart';
import 'package:hermione/src/features/assessment/presentation/pages/quiz/mainquizscreen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rive/rive.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/constants.dart';
import '../../data/models/quizmodels/created_quiz_viewer_ui/question_model.dart';
import '../pages/quiz/multichoicescreen.dart';

class QuestionCard extends ConsumerWidget {
  const QuestionCard({
    required this.index,
    super.key,
    required this.screensize,
    required this.question,
    required this.animationChild,
  });
  final RiveAnimation animationChild;
  final Size screensize;
  final int index;
  final Question question;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        height: screensize.width / 2,
        width: screensize.width,
        decoration: BoxDecoration(
            color: AppColor.white, borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Align(
              alignment: const Alignment(0, -0.9),
              child: Text(
                '${index + 1}/${ref.watch(quizListProvider).getQuizes.length}'
                    .toString(),
                style: AppTextStyle.titlename
                    .copyWith(color: const Color(0xff065774)),
              ),
            ),
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
