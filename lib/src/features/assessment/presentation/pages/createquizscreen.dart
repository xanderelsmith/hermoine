import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:hermione/src/core/constants/constants.dart';
import 'package:hermione/src/features/assessment/data/sources/enums/quizdataenum.dart';
import 'package:hermione/src/features/assessment/domain/entities/geminiapihelper.dart';
import 'package:hermione/src/features/assessment/presentation/pages/pdfquizifyscreen.dart';
import 'package:hermione/src/features/assessment/presentation/pages/previewquizdata.dart';
import 'package:hermione/src/features/auth/domain/entities/loginvalidator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/constants/colors.dart';
import '../../../auth/presentation/widgets/styled_textfield.dart';
import '../../data/sources/assessmentdatasources.dart';
import '../../domain/repositories/createdquizrepo.dart';

class CreateQuizScreen extends StatefulWidget {
  const CreateQuizScreen({
    super.key,
  });

  @override
  State<CreateQuizScreen> createState() => _CreateQuizScreenState();
}

class _CreateQuizScreenState extends State<CreateQuizScreen> {
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
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
        ),
        child: ElevatedButton(
          child: const Text('Generate'),
          onPressed: () {
            showDialog(
                context: context,
                builder: ((context) => const AlertDialog(
                      content: SizedBox(
                          height: 50,
                          child: Center(child: CircularProgressIndicator())),
                      title: Text('Loading'),
                    )));

            final gemini = Gemini.instance;

            if (quizDataSource == QuizDataSource.fromPdf) {
              extractedText = pdfdata;
            } else {
              extractedText = sampleDataTextEditingController.text;
            }
            gemini
                .text(GeminiSparkConfig.prompt(
                    message:
                        extractedText.replaceAll(RegExp(r'\s+'), ' ').trim(),
                    difficulty: difficulty,
                    questionNumber: questionNo))
                .then((value) {
              log('result $value.output');
              Navigator.pop(context);

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PreviewQuestionsPage(
                            questionData: value!.output ?? '',
                          )));
            }).onError((error, stackTrace) {
              log(error.toString());
            });
            ;
          },
        ),
      ),
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          color: const Color(0xffC5CAE9).withOpacity(0.21),
          child: Column(
            children: [
              StyledTextField(
                innerHint: 'Quiz Name',
                fillColor: const Color(0xffC5CAE9).withOpacity(0.23),
                controller: quiznameTextEditingController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DropdownButton<int>(
                      icon: const Text(
                        '(Questions)',
                        style: TextStyle(color: Colors.white),
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
                        style: TextStyle(color: Colors.white),
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
                              child: const Icon(
                                Icons.file_copy,
                                size: 50,
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
}