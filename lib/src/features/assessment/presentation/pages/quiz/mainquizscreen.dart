import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hermione/src/features/assessment/presentation/pages/quiz/multichoicescreen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/constants/colors.dart';
import '../../../data/models/quizmodels/created_quiz_viewer_ui/question_model.dart';
import '../../../domain/repositories/retievedquizdata.dart';

class QuizMainScreen extends ConsumerWidget {
  const QuizMainScreen({
    super.key,
    required this.topic,
  });
  final String topic;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Question> quizes = ref.watch(quizListProvider).getQuizes;
    log(quizes.length.toString());
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            title: LinearProgressIndicator(
          value: 0.1,
          backgroundColor: Colors.blue,
          minHeight: 20,
          color: const Color(0xff88FF59),
          borderRadius: BorderRadius.circular(10),
        )),
        body: PageView.builder(
            itemCount: quizes.length,
            itemBuilder: (context, index) {
              return MultiChoiceUIScreen(
                screensize: screensize,
                topic: topic,
                question: quizes[index],
              );
            }));
  }
}
