// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rive/rive.dart';

import 'package:hermione/src/core/constants/constants.dart';
import 'package:hermione/src/core/widgets/specialtextfield.dart';
import 'package:hermione/src/features/assessment/data/models/quizmodels/created_quiz_viewer_ui/shortanswerquizviewer.dart';
import 'package:hermione/src/features/assessment/presentation/pages/quiz/mainquizscreen.dart';
import 'package:hermione/src/features/assessment/presentation/pages/quiz/multichoicescreen.dart';
import 'package:hermione/src/features/assessment/presentation/widgets/questioncard.dart';

class ShortAnswerQuizScreen extends ConsumerStatefulWidget {
  //it was named questions because theres already a variable called [question]

  final ShortAnswer questionData;
  const ShortAnswerQuizScreen({
    required this.index,
    Key? key,
    required this.questionData,
  }) : super(key: key);
  final int index;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ShortAnswerQuizScreenState();
}

class _ShortAnswerQuizScreenState extends ConsumerState<ShortAnswerQuizScreen> {
  StateMachineController? controller;
  SMITrigger? idle;
  SMITrigger? correct;
  SMITrigger? wrong;
  TextEditingController answercontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var scrollController = ScrollController();
    final quizdatacontroller = ref.watch(quizcontrollerProvider);
    var focusnode = FocusNode();

    Size screensize = MediaQuery.of(context).size;
    if (focusnode.hasFocus && scrollController.position.maxScrollExtent < 100) {
      scrollController.animateTo(500,
          duration: const Duration(seconds: 2), curve: Curves.linear);
    }
    log(widget.questionData.otherCorrectAnswers!.toList().toString());
    return Card(
        color: AppColor.white,
        elevation: 5,
        child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 10,
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                      height: screensize.height / 3,
                      width: screensize.width,
                      child: QuestionCard(
                        index: widget.index,
                        question: widget.questionData,
                        screensize: screensize,
                        animationChild:
                            RiveAnimation.asset('assets/mascot/hermione.riv',
                                animations: const [
                                  'idle question',
                                ],
                                fit: BoxFit.fitHeight,
                                stateMachines: const ['State Machine 1'],
                                onInit: (artboard) {
                          controller = StateMachineController.fromArtboard(
                            artboard,
                            "State Machine 1",
                          );
                          if (controller == null) return;
                          artboard.addController(controller!);
                          correct = controller!.findSMI('correct');
                          wrong = controller!.findSMI('wrong');
                          idle = controller!.findSMI('intro idle');
                        }),
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 13),
                        margin: const EdgeInsets.symmetric(vertical: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: SpecialTextfield(
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 0),
                          controller: answercontroller,
                        )),
                  ),
                  !quizdatacontroller.answered
                      ? CustomButton(
                          onTap: () {
                            var lowerCaseanswer =
                                answercontroller.text.toLowerCase();
                            ref
                                .read(quizcontrollerProvider.notifier)
                                .submitAnswer(
                                    ShortAnswer(
                                        otherCorrectAnswers: widget
                                            .questionData.otherCorrectAnswers,
                                        indexS: widget.questionData.indexS,
                                        answer:
                                            widget.questionData.correctanswer,
                                        questions:
                                            widget.questionData.questions),
                                    lowerCaseanswer);
                            if (lowerCaseanswer ==
                                    widget.questionData.correctanswer
                                        .toLowerCase() ||
                                widget.questionData.otherCorrectAnswers!
                                    .map((e) => e.toString().toLowerCase())
                                    .toList()
                                    .contains(lowerCaseanswer.toString())) {
                              correct!.fire();
                            } else {
                              wrong!.fire();
                            }
                          },
                          title: 'Check')
                      : const SizedBox.shrink()
                ])));
  }
}
