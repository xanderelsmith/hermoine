import 'package:flutter/material.dart';
import 'package:hermione/src/core/constants/constants.dart';
import 'package:hermione/src/core/widgets/specialtextfield.dart';
import 'package:hermione/src/features/assessment/data/models/quizmodels/created_quiz_viewer_ui/shortanswerquizviewer.dart';
import 'package:hermione/src/features/assessment/presentation/pages/quiz/multichoicescreen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
                          screensize: screensize, question: questionData)),
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
                  const SizedBox.shrink()
                ])));
  }
}
