import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../sources/enums/quiztype_enum.dart';

abstract class Question extends ConsumerWidget {
  final QuizType? quizType;

  ///converts quiz data to json
  Map toJson();
  final List? hintimages;
  final dynamic question;
  final dynamic correctanswer;
  const Question({
    this.correctanswer,
    super.key,
    this.quizType,
    this.hintimages,
    this.question,
  });

  ///returns a build ui for the quiz
  @override
  Widget build(BuildContext context, WidgetRef ref);
}
