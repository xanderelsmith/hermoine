import 'package:flutter/material.dart';
import 'package:hermione/src/core/constants/constants.dart';
import 'package:hermione/src/core/widgets/specialtextfield.dart';
import 'package:hermione/src/features/assessment/data/models/quizmodels/created_quiz_viewer_ui/shortanswerquizviewer.dart';
import 'package:hermione/src/features/assessment/presentation/pages/quiz/mainquizscreen.dart';
import 'package:hermione/src/features/assessment/presentation/pages/quiz/multichoicescreen.dart';
import 'package:hermione/src/features/assessment/presentation/widgets/questioncard.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:rive/rive.dart';

class ShortAnswerQuizScreen extends HookConsumerWidget {
  //it was named questions because theres already a variable called [question]

  final ShortAnswer questionData;
  const ShortAnswerQuizScreen({
    super.key,
    required this.questionData,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var scrollController = useScrollController();
    final quizdatacontroller = ref.watch(quizcontrollerProvider);
    var focusnode = useFocusNode();
    TextEditingController answercontroller = TextEditingController();
    Size screensize = MediaQuery.of(context).size;
    if (focusnode.hasFocus && scrollController.position.maxScrollExtent < 100) {
      scrollController.animateTo(500,
          duration: const Duration(seconds: 2), curve: Curves.linear);
    }
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
                          animationChild: const RiveAnimation.asset(
                            'assets/mascot/hermione.riv',
                            animations: ['idle question', 'correct', 'wrong'],
                            fit: BoxFit.fitHeight,
                          ),
                          screensize: screensize,
                          question: questionData)),
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
                            ref
                                .read(quizcontrollerProvider.notifier)
                                .submitAnswer(
                                    ShortAnswer(
                                        otherCorrectAnswers:
                                            questionData.otherCorrectAnswers,
                                        indexS: questionData.indexS,
                                        answer: questionData.correctanswer,
                                        questions: questionData.questions),
                                    answercontroller.text.toLowerCase());
                          },
                          title: 'Check')
                      : const SizedBox.shrink()
                ])));
  }
}
