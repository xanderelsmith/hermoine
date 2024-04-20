import 'package:flutter/material.dart';
import 'package:hermione/src/features/assessment/domain/repositories/retievedquizdata.dart';
import 'package:hermione/src/features/assessment/presentation/pages/quiz/mainquizscreen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/constants.dart';

class ScoreChart extends ConsumerWidget {
  const ScoreChart({
    super.key,
    required this.score,
  });
  final double score;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizlist = ref.watch(quizListProvider).getQuizes;

    final quizstate = ref.watch(quizcontrollerProvider);

    var total = quizlist.length;
    return Center(
        child: Stack(
      children: [
        Center(
          child: CircleAvatar(
            radius: 83,
            backgroundColor: Colors.white,
            child: CircularProgressIndicator(
              strokeWidth: 55,
              strokeAlign: 1.4,
              value: score.toDouble(),
              color: const Color(0xff076688),
            ),
          ),
        ),
        Center(
          child: Material(
            shape: const CircleBorder(),
            elevation: 5,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Your Score'),
                  Text(
                    '${(score * 100).floor()}%',
                    style: AppTextStyle.mediumTitlename
                        .copyWith(color: const Color(0xff065774)),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
