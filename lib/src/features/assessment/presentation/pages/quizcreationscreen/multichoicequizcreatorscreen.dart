import 'package:flutter/material.dart';
import 'package:hermione/src/core/constants/constants.dart';
import 'package:hermione/src/core/widgets/specialtextfield.dart';
import 'package:hermione/src/features/assessment/data/models/quizmodels/created_quiz_viewer_ui/multichoicequizviewer.dart';
import 'package:hermione/src/features/assessment/domain/repositories/createdquizrepo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class MultiChoiceCreator extends ConsumerStatefulWidget {
  const MultiChoiceCreator(
      {required this.index, required this.question, super.key});
  final int index;
  final MultiChoice question;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MultiChoiceCreatorState();
}

class _MultiChoiceCreatorState extends ConsumerState<MultiChoiceCreator> {
  final suggestedTags = [
    "Phy Sci",
    "Comp Sci",
    "Engr",
    "Life Sci",
  ];

  Set<String> tagList = {};

  TextEditingController? correctanswerController;
  TextEditingController? questionController;
  TextEditingController? incorrect1;
  TextEditingController? incorrect2;
  TextEditingController? incorrect3;
  @override
  void initState() {
    correctanswerController =
        TextEditingController(text: widget.question.answer ?? "");
    questionController =
        TextEditingController(text: widget.question.question_ ?? "");
    incorrect1 =
        TextEditingController(text: widget.question.incorrectanswers[0]);
    incorrect2 =
        TextEditingController(text: widget.question.incorrectanswers[1]);
    incorrect3 =
        TextEditingController(text: widget.question.incorrectanswers[2]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final questionListWatcher = ref.watch(createdQuizlistdataProvider.notifier);
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(9),
        child: ElevatedButton(
            onPressed: () {
              if (correctanswerController!.text.isNotEmpty &&
                  incorrect1!.text.isNotEmpty &&
                  incorrect1!.text.isNotEmpty &&
                  incorrect2!.text.isNotEmpty &&
                  incorrect3!.text.isNotEmpty) {
                var createdQuizlistdataProvider2 = createdQuizlistdataProvider;
                ref.watch(createdQuizlistdataProvider2);
                questionListWatcher.addQuiz(
                    MultiChoice(
                        images: [],
                        answer: correctanswerController!.text.trim(),
                        incorrectanswers: [
                          incorrect1!.text,
                          incorrect2!.text.trim(),
                          incorrect3!.text.trim()
                        ],
                        question_: questionController!.text.trim()),
                    index: widget.index);
                correctanswerController!.clear();
                questionController!.clear();
                incorrect1!.clear();
                incorrect3!.clear();
                incorrect2!.clear();
                Navigator.pop(context);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('input fields must not be empty')));
              }
            },
            child: Text(
              'Update',
              style: AppTextStyle.mediumTitlename,
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8.0),
                      child: Text('Quiz question'),
                    ),
                    SpecialTextfield(
                      controller: questionController,
                      innerHint: 'e.g What is the name of your pokemon',
                    )
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(10)),
                    color: Theme.of(context).canvasColor),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: Text('Quiz Answers'),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SpecialTextfield(
                          controller: incorrect1,
                          textfieldname: 'Enter false Answer 1',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SpecialTextfield(
                          controller: incorrect2,
                          textfieldname: 'Enter false Answer 2',
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SpecialTextfield(
                          controller: incorrect3,
                          textfieldname: 'Enter false Answer 3',
                        ),
                      ),
                      const Text('Insert the correct answer below'),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: SpecialTextfield(
                          controller: correctanswerController,
                          textfieldname: 'Enter Answer ',
                        ),
                      )
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
