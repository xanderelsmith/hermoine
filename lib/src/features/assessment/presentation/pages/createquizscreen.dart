import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:hermione/src/core/constants/constants.dart';
import 'package:hermione/src/core/constants/text_style.dart';
import 'package:hermione/src/features/assessment/data/sources/enums/quizdataenum.dart';
import 'package:hermione/src/features/assessment/domain/entities/geminiapihelper.dart';
import 'package:hermione/src/features/assessment/presentation/pages/pdfquizifyscreen.dart';
import 'package:hermione/src/features/assessment/presentation/pages/previewquizdata.dart';
import 'package:hermione/src/features/auth/domain/entities/loginvalidator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rive/rive.dart';

import '../../../../core/constants/colors.dart';
import '../../../auth/presentation/widgets/styled_textfield.dart';
import '../../data/sources/assessmentdatasources.dart';
import '../../domain/repositories/createdquizrepo.dart';

class CreateQuizScreen extends ConsumerStatefulWidget {
  const CreateQuizScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CreateQuizScreenState();
}

class _CreateQuizScreenState extends ConsumerState<CreateQuizScreen> {
  TextEditingController quiznameTextEditingController = TextEditingController();
  TextEditingController sampleDataTextEditingController =
      TextEditingController();
  String difficulty = 'easy';
  String pdfdata = '';
  String extractedText = '';
  QuizDataSource quizDataSource = QuizDataSource.fromText;
  int questionNo = 0;
  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
        child: SizedBox(
          height: 40,
          child: ElevatedButton(
            child: Text(
              'Generate',
              style: AppTextStyle.mediumTitlename.copyWith(color: Colors.white),
            ),
            onPressed: () {
              if (quizDataSource == QuizDataSource.fromPdf) {
                extractedText = pdfdata;
              } else {
                extractedText = sampleDataTextEditingController.text;
              }
              if (quiznameTextEditingController.text.isEmpty ||
                  extractedText.isEmpty ||
                  questionNo == 0) {
                showDialog(
                    context: context,
                    builder: (context) => const AlertDialog(
                          title: Text('Blank input'),
                          content: Text('One of the input fields is Empty'),
                        ));
              } else {
                showDialog(
                    context: context,
                    builder: ((context) => const SizedBox(
                          height: 100,
                          child: AlertDialog(
                            content: SizedBox(
                              height: 250,
                              child: RiveAnimation.asset(
                                'assets/mascot/hermione.riv',
                                animations: ['idle question'],
                                fit: BoxFit.fitHeight,
                              ),
                            ),
                            title: Text('Loading'),
                          ),
                        )));

                final gemini = Gemini.instance;

                bool haseRROR = false;
                do {
                  quizProcessGeneration(gemini, context, haseRROR);
                } while (haseRROR);
              }
            },
          ),
        ),
      ),
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              StyledTextField(
                innerHint: 'Quiz Name',
                controller: quiznameTextEditingController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DropdownButton<int>(
                      icon: const Text(
                        '(Questions)',
                      ),
                      value: questionNo,
                      items: List.generate(
                          11,
                          (index) => DropdownMenuItem(
                              value: index, child: Text(index.toString()))),
                      onChanged: (onChangedValue) {
                        setState(() {
                          questionNo = onChangedValue!;
                        });
                      }),
                  DropdownButton<String>(
                      icon: const Text(
                        '(Difficulty)',
                      ),
                      value: difficulty,
                      items: List.generate(
                          AssessmentDataSource.quizDifficulty.length,
                          (index) => DropdownMenuItem(
                              value: AssessmentDataSource.quizDifficulty[index],
                              child: Text(AssessmentDataSource
                                  .quizDifficulty[index]
                                  .toString()))),
                      onChanged: (onChangedValue) {
                        setState(() {
                          print(difficulty);
                          difficulty = onChangedValue!;
                        });
                      }),
                ],
              ),
              QuizDataSource.fromPdf == quizDataSource
                  ? Container(
                      height: 200,
                      decoration: BoxDecoration(
                          color: AppColor.transparentContainer,
                          borderRadius: BorderRadius.circular(10)),
                      width: screensize.width,
                      child: pdfdata.isNotEmpty
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  SingleChildScrollView(child: Text(pdfdata)),
                            )
                          : InkWell(
                              onTap: () async {
                                File newfile;
                                await FilePicker.platform.pickFiles(
                                    type: FileType.custom,
                                    allowedExtensions: [
                                      'pdf',
                                    ]).then((value) async {
                                  if (value != null) {
                                    newfile = File(value.files.single.path!);
                                    pdfdata = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PdfQuizScreen(
                                                pdf: newfile))).then((value) {
                                      setState(() {});
                                      return value;
                                    });
                                  } else {}
                                  return null;
                                }).onError((error, stackTrace) {
                                  showSnackBar(context,
                                      message: error.toString());
                                  return null;
                                });
                              },
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Icons.file_copy,
                                    size: 50,
                                  ),
                                  Text(
                                    'Click to add quiz',
                                    style: AppTextStyle.mediumTitlename,
                                  )
                                ],
                              )),
                    )
                  : StyledTextField(
                      innerHint:
                          'Enter any relevant data to obtain better results',
                      textfieldname: 'Sample data',
                      isMultiline: true,
                      maxlines: 7,
                      controller: sampleDataTextEditingController,
                    ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: StyledTextField(
                  innerHint: 'Extra instructions',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        2,
                        (index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  quizDataSource = QuizDataSource.values[index];
                                });
                              },
                              child: Card(
                                color: QuizDataSource.values[index] ==
                                        quizDataSource
                                    ? AppColor.surfaceColor
                                    : null,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                      width: screensize.width / 2.8,
                                      child: Icon(QuizDataSource
                                          .values[index].icondata)),
                                ),
                              ),
                            ))),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void quizProcessGeneration(
      Gemini gemini, BuildContext context, bool haseRROR) {
    gemini
        .text(GeminiSparkConfig.prompt(
            topic: quiznameTextEditingController.text,
            message: extractedText.replaceAll(RegExp(r'\s+'), ' ').trim(),
            difficulty: difficulty,
            questionNumber: questionNo))
        .then((value) {
      log('result $value.output');
      Navigator.pop(context);

      try {
        final notifier = ref.read(createdQuizlistdataProvider.notifier);
        notifier.validateAiInputData(value!.output!.startsWith('```json')
            ? cleanjsonString(value.output ?? '')
            : value.output ?? '');
      } on Exception catch (e) {
        haseRROR = true;
        ref.watch(createdQuizlistdataProvider.notifier).clear();
        log(e.toString());
        return;
      }
      if (haseRROR == false) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PreviewQuestionsPage(
                      title: quiznameTextEditingController.text,
                    )));
      } else {}
    }).onError((error, stackTrace) {
      log(error.toString());
    });
  }
}
