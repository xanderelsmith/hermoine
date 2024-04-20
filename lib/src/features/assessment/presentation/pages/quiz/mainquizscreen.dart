// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hermione/src/core/constants/constants.dart';
import 'package:hermione/src/core/constants/text_style.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:hermione/src/features/assessment/data/models/quizmodels/created_quiz_viewer_ui/multichoicequizviewer.dart';
import 'package:hermione/src/features/assessment/data/models/quizmodels/created_quiz_viewer_ui/shortanswerquizviewer.dart';
import 'package:hermione/src/features/assessment/data/sources/enums/quiztype_enum.dart';
import 'package:hermione/src/features/assessment/domain/entities/quiz_status.dart';
import 'package:hermione/src/features/assessment/presentation/pages/quiz/multichoicescreen.dart';
import 'package:hermione/src/features/assessment/presentation/pages/quiz/resultscreen.dart';
import 'package:hermione/src/features/assessment/presentation/pages/quiz/shortanswerquizscreen.dart';

import '../../../../../core/constants/colors.dart';
import '../../../data/models/quizmodels/created_quiz_viewer_ui/question_model.dart';
import '../../../domain/controller/quizcontroller.dart';
import '../../../domain/entities/quizstate.dart';
import '../../../domain/repositories/retievedquizdata.dart';

class QuizMainScreen extends ConsumerStatefulWidget {
  const QuizMainScreen({
    super.key,
    required this.topic,
  });
  final String topic;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuizMainScreenState();
}

class _QuizMainScreenState extends ConsumerState<QuizMainScreen> {
  final pageController = PageController(initialPage: 0);
  @override
  @override
  Widget build(BuildContext context) {
    final quizlist = ref.watch(quizListProvider).getQuizes;
    final quizdatacontroller = ref.watch(quizcontrollerProvider);
    Size screensize = MediaQuery.of(context).size;
    List<Question> quizes = ref.watch(quizListProvider).getQuizes;
    log(quizes.length.toString());

    return PopScope(
      canPop: true,
      onPopInvoked: (bool ispop) {
        // ref.watch(quizcontrollerProvider.notifier).clearQuizState();
        // pageController.dispose();
      },
      child: Scaffold(
          // bottomSheet: quizlist[0].runtimeType == MultiChoice
          //     ? null
          //     : BottomSheet(
          //         screensize: screensize,
          //         quizdatacontroller: quizdatacontroller,
          //         quizlist: quizlist,
          //         pageController: pageController),
          bottomSheet: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomSheet(
                  answercolor: Colors.green,
                  screensize: screensize,
                  quizdatacontroller: quizdatacontroller,
                  quizlist: quizlist,
                  pageController: pageController),
              Builder(
                builder: (context) {
                  return quizdatacontroller.answered
                      ? Container(
                          height: 100,
                          color:
                              pageController.page!.toInt() + 1 < quizlist.length
                                  ? null
                                  : Colors.transparent,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CustomButton(
                                color: ref
                                            .watch(
                                                quizcontrollerProvider.notifier)
                                            .quizstate
                                            .status ==
                                        QuizStatus.correct
                                    ? Colors.green
                                    : Colors.red,
                                title: pageController.page!.toInt() + 1 <
                                        quizlist.length
                                    ? 'Next Question'
                                    : 'See Results',
                                onTap: () async {
                                  if (pageController.page!.toInt() + 1 <
                                      quizlist.length) {
                                    ref
                                        .watch(quizcontrollerProvider.notifier)
                                        .nextQuestion(quizlist,
                                            pageController.page!.toInt());

                                    if (pageController.page!.toInt() + 1 <
                                        quizlist.length) {
                                      pageController.nextPage(
                                        duration:
                                            const Duration(milliseconds: 250),
                                        curve: Curves.linear,
                                      );
                                    }
                                  } else {
                                    final quizlist =
                                        ref.watch(quizListProvider).getQuizes;
                                    final quizstate =
                                        ref.watch(quizcontrollerProvider);
                                    double scoreDecimal =
                                        quizstate.correct.length /
                                            quizlist.length;
                                    await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                QuizResultScreen(
                                                  scoreDecimal: scoreDecimal,
                                                )))).then((value) {
                                      ref
                                          .watch(
                                              quizcontrollerProvider.notifier)
                                          .clearQuizState();
                                      pageController.jumpToPage(0);
                                    });
                                  }
                                }),
                          ),
                        )
                      : const SizedBox.shrink();
                },
              ),
            ],
          ),
          appBar: AppBar(
              title: LinearProgressIndicator(
            value: quizdatacontroller.correct.length.toDouble() /
                quizes.length.toDouble(),
            backgroundColor: Colors.blue,
            minHeight: 20,
            color: const Color(0xff88FF59),
            borderRadius: BorderRadius.circular(10),
          )),
          body: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: quizes.length,
              controller: pageController,
              itemBuilder: (context, index) {
                return questionScreenBuilder(quizes, index, screensize);
              })),
    );
  }
}

class BottomSheet extends StatelessWidget {
  final Color? answercolor;

  const BottomSheet({
    super.key,
    required this.answercolor,
    required this.screensize,
    required this.quizdatacontroller,
    required this.quizlist,
    required this.pageController,
  });

  final Size screensize;
  final QuizState quizdatacontroller;
  final List<Question> quizlist;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Container(
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
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: answercolor,
                        overflow: TextOverflow.ellipsis),
                    maxLines: 2,
                  ),
                ),
              ],
            )
          : const SizedBox.shrink(),
    );
  }
}

questionScreenBuilder(List<Question> quizes, int index, Size screensize) {
  return quizes[index].quizType == QuizType.multichoice
      ? MultiChoiceUIScreen(
          index: index,
          screensize: screensize,
          // topic:quizes[index]. topic,
          question: quizes[index],
        )
      : ShortAnswerQuizScreen(
          questionData: quizes[index] as ShortAnswer,
          index: index,
        );
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
  final Color? color;
  const CustomButton({
    super.key,
    required this.title,
    required this.onTap,
    this.color,
  });

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
          color: color ?? AppColor.primaryColor,
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
