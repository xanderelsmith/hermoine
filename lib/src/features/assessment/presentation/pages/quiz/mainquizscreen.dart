// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hermione/src/features/assessment/presentation/pages/quiz/resultscreen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:hermione/src/features/assessment/data/models/quizmodels/created_quiz_viewer_ui/shortanswerquizviewer.dart';
import 'package:hermione/src/features/assessment/data/sources/enums/quiztype_enum.dart';
import 'package:hermione/src/features/assessment/presentation/pages/quiz/multichoicescreen.dart';
import 'package:hermione/src/features/assessment/presentation/pages/quiz/shortanswerquizscreen.dart';

import '../../../../../core/constants/colors.dart';
import '../../../data/models/quizmodels/created_quiz_viewer_ui/question_model.dart';
import '../../../domain/controller/quizcontroller.dart';
import '../../../domain/entities/quizstate.dart';
import '../../../domain/repositories/retievedquizdata.dart';

class QuizMainScreen extends ConsumerStatefulWidget {
  const QuizMainScreen({
    Key? key,
    required this.topic,
  }) : super(key: key);
  final String topic;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuizMainScreenState();
}

class _QuizMainScreenState extends ConsumerState<QuizMainScreen> {
  final pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    final quizlist = ref.watch(quizListProvider).getQuizes;
    final quizdatacontroller = ref.watch(quizcontrollerProvider);
    Size screensize = MediaQuery.of(context).size;
    List<Question> quizes = ref.watch(quizListProvider).getQuizes;
    log(quizes.length.toString());

    return Scaffold(
        bottomSheet: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
          ),
          width: screensize.width,
          padding: const EdgeInsets.only(left: 30.0, top: 10),
          child: quizdatacontroller.answered
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: screensize.width - 30,
                      child: Text(
                        'Answer: ${quizlist[pageController.page!.toInt()].correctanswer}',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            overflow: TextOverflow.ellipsis),
                        maxLines: 2,
                      ),
                    ),
                  ],
                )
              : const SizedBox.shrink(),
        ),
        bottomNavigationBar: Builder(
          builder: (context) {
            return quizdatacontroller.answered
                ? Container(
                    height: 100,
                    color: pageController.page!.toInt() + 1 < quizlist.length
                        ? null
                        : Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomButton(
                          title:
                              pageController.page!.toInt() + 1 < quizlist.length
                                  ? 'Next Question'
                                  : 'See Results',
                          onTap: () async {
                            if (pageController.page!.toInt() + 1 <
                                quizlist.length) {
                              ref
                                  .watch(quizcontrollerProvider.notifier)
                                  .nextQuestion(
                                      quizlist, pageController.page!.toInt());

                              if (pageController.page!.toInt() + 1 <
                                  quizlist.length) {
                                pageController.nextPage(
                                  duration: const Duration(milliseconds: 250),
                                  curve: Curves.linear,
                                );
                              }

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const QuizResultScreen())));
                            }
                          }),
                    ),
                  )
                : const SizedBox.shrink();
          },
        ),
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
            controller: pageController,
            itemBuilder: (context, index) {
              return questionScreenBuilder(quizes, index, screensize);
            }));
  }
}

questionScreenBuilder(List<Question> quizes, int index, Size screensize) {
  return quizes[index].quizType == QuizType.multichoice
      ? MultiChoiceUIScreen(
          screensize: screensize,
          // topic:quizes[index]. topic,
          question: quizes[index],
        )
      : ShortAnswerQuizScreen(questionData: quizes[index] as ShortAnswer);
}

final quizcontrollerProvider =
    StateNotifierProvider<QuizController, QuizState>((ref) {
  return QuizController();
});

final List<BoxShadow> boxShadow = [
  const BoxShadow(
    color: Colors.black26,
    offset: Offset(0, 2),
    blurRadius: 4.0,
  ),
];

class CustomButton extends StatelessWidget {
  final String title;
  final Function onTap;

  const CustomButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        margin: const EdgeInsets.all(20.0),
        height: 50.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColor.primaryColor,
          boxShadow: boxShadow,
          borderRadius: BorderRadius.circular(25.0),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
