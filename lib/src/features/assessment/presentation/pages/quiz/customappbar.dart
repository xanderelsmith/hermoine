import 'package:flutter/material.dart';
import 'package:hermione/src/features/assessment/presentation/pages/quiz/resultscreen.dart';
import 'package:hermione/src/features/assessment/presentation/widgets/resultsubcomponent.dart';

import '../../../../../core/constants/size_utils.dart';
import '../../../domain/entities/quizstate.dart';

class CustomResultAppBar extends StatelessWidget implements PreferredSize {
  const CustomResultAppBar(
      {super.key,
      required this.quizState,
      required this.quizlength,
      required this.score});
  final QuizState quizState;
  final int quizlength;
  final double score;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
        color: Color(0xff065774),
      ),
      child: Stack(
        children: [
          ScoreChart(
            score: score,
          ),
          Align(
            alignment: const Alignment(0, 1.6),
            child: Container(
              height: 80,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(10)),
              width: getScreenSize(context).width - 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ResultDataSubComponent(
                          name: 'Completion',
                          value:
                              '${((quizState.correct.length / quizlength) * 100).floor()}%',
                          tagcolor: Color(0xff065774)),
                      ResultDataSubComponent(
                          name: 'Correct',
                          value: '${quizState.correct.length}',
                          tagcolor: Colors.green),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ResultDataSubComponent(
                          name: 'Questions',
                          value: '$quizlength',
                          tagcolor: Colors.amber),
                      ResultDataSubComponent(
                          name: 'Wrong',
                          value: '${quizState.incorrect.length}',
                          tagcolor: Colors.red),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(100, 250);
}
