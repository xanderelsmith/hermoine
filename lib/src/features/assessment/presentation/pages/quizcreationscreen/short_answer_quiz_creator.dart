import 'package:hermione/src/core/constants/constants.dart';
import 'package:hermione/src/core/widgets/specialtextfield.dart';
import 'package:hermione/src/features/assessment/data/models/quizmodels/created_quiz_viewer_ui/question_model.dart';
import 'package:hermione/src/features/assessment/data/models/quizmodels/created_quiz_viewer_ui/shortanswerquizviewer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/repositories/createdquizrepo.dart';

StateProvider<bool> isEditedStateProvider = StateProvider<bool>((ref) {
  return true;
});

class ShortTextAnswerQuizCreator extends ConsumerStatefulWidget {
  const ShortTextAnswerQuizCreator(
      {required this.index, required this.question, super.key});
  final int index;
  final ShortAnswer question;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ShortTextAnswerQuizCreatorState();
}

class _ShortTextAnswerQuizCreatorState
    extends ConsumerState<ShortTextAnswerQuizCreator> {
  final otherCorrectAnswers = [
    "Phy Sci",
    "Comp Sci",
    "Engr",
    "Life Sci",
  ];

  Set<String> optionalCorrectAnswer = {};
  late ImagePicker imagePicker;

  late TextEditingController tagTextController;
  TextEditingController? answerController;
  TextEditingController? questionController;
  @override
  void initState() {
    imagePicker = ImagePicker();
    optionalCorrectAnswer =
        widget.question.otherCorrectAnswers!.map((e) => e.toString()).toSet();
    answerController = TextEditingController(text: widget.question.answer);
    questionController = TextEditingController(text: widget.question.question);
    tagTextController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final questionListWatcher = ref.watch(createdQuizlistdataProvider.notifier);
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
            onPressed: () {
              if (answerController!.text.isNotEmpty &&
                  questionController!.text.isNotEmpty) {
                ref.watch(createdQuizlistdataProvider);
                questionListWatcher.addQuiz(
                    ShortAnswer(
                        images: [],
                        otherCorrectAnswers: optionalCorrectAnswer,
                        answer: answerController!.text.trim(),
                        questions: questionController!.text.trim()),
                    index: widget.index);
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('input fields must not be empty')));
              }
            },
            child: Text(
              'Update',
              style: AppTextStyle.mediumTitlename.copyWith(color: Colors.white),
            )),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                  height: screenSize.height / 3,
                  width: screenSize.width,
                  child: Card(
                      child: Stack(
                    children: [
                      Center(
                          child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ref.watch(isEditedStateProvider) == false
                            ? SpecialTextfield(
                                controller: questionController,
                                innerHint: 'Input question',
                                textInputtype: TextInputType.multiline)
                            : Text(
                                questionController!.text.isEmpty
                                    ? 'Imput a question!'
                                    : questionController!.text,
                                textAlign: TextAlign.center,
                                style: AppTextStyle.titlename),
                      )),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(150, 30)),
                              onPressed: () {
                                ref
                                        .watch(isEditedStateProvider.notifier)
                                        .state =
                                    ref.watch(isEditedStateProvider) == false
                                        ? true
                                        : false;
                              },
                              child: Text(
                                ref
                                            .watch(
                                                isEditedStateProvider.notifier)
                                            .state ==
                                        false
                                    ? 'Set'
                                    : 'Edit',
                                style: AppTextStyle.mediumTitlename
                                    .copyWith(color: Colors.white),
                              )),
                        ),
                      )
                    ],
                  ))),
              SizedBox(height: screenSize.height * 0.12),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ref.watch(isEditedStateProvider) == false
                    ? SpecialTextfield(
                        controller: answerController,
                        innerHint: 'input answer',
                      )
                    : Container(
                        alignment: Alignment.center,
                        height: 50,
                        padding: const EdgeInsets.symmetric(horizontal: 13),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                width: 1, color: Theme.of(context).hintColor)),
                        child: Text(answerController!.text.isEmpty
                            ? 'No input!'
                            : answerController!.text)),
              ),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Optional Answer(s)"),
                      Wrap(
                        spacing: 8,
                        children: optionalCorrectAnswer
                            .map((tag) => PostTag(
                                icon: Icons.remove,
                                onTap: () => setState(() {
                                      optionalCorrectAnswer.remove(tag);
                                    }),
                                label: tag))
                            .toList(),
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 4.0, vertical: 12),
                          child: TextField(
                            controller: tagTextController,
                            decoration: InputDecoration(
                              filled: true,
                              labelText: 'Input an optional answer ',
                              suffix: CircleAvatar(
                                  child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          optionalCorrectAnswer.add(
                                              tagTextController!.text.trim());
                                          tagTextController.clear();
                                        });
                                      },
                                      child: const Icon(Icons.add))),
                              hintText: "for multiple options",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

class PostTag extends StatelessWidget {
  const PostTag(
      {required this.icon,
      required this.onTap,
      required this.label,
      super.key});
  final String label;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.only(right: 12),
        ),
        backgroundColor: MaterialStateProperty.all(
            Theme.of(context).hintColor.withOpacity(0.1)),
      ),
      onPressed: onTap,
      icon: Icon(
        icon,
        size: 14,
      ),
      label: Text(
        label,
        style: const TextStyle(fontSize: 14),
      ),
    );
  }
}
