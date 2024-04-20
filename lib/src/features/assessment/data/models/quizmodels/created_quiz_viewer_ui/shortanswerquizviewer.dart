import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import '../../../sources/enums/quiztype_enum.dart';
import 'question_model.dart';

class ShortAnswer extends Question {
  @override
  QuizType? get quizType => QuizType.shortTextAnswer;
  @override
  String get question => questions;
  @override
  List? get hintimages => images;
  @override
  String get correctanswer => answer;
  final List? images;
  final int? indexS;
  @override
  get index => indexS;
  final String questions;
  final Set? otherCorrectAnswers;
  final String answer;
  const ShortAnswer({
    this.images,
    Key? key,
    this.indexS,
    required this.answer,
    this.otherCorrectAnswers,
    required this.questions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(10)),
      child: Stack(
        children: [
          Column(children: [
            Expanded(
              flex: 2,
              child: Center(
                  child: Card(
                      child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  questions,
                  textAlign: TextAlign.center,
                ),
              ))),
            ),
            Expanded(
                flex: 5,
                child: Center(
                    child: Card(
                        child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 15),
                  child: Text(list.join(',').toString()),
                ))))
          ]),
          Align(
            alignment: Alignment.bottomRight,
            child: images == null || images!.isEmpty
                ? const SizedBox()
                : IconButton(
                    onPressed: () {
                      // showDialog(
                      //     context: context,
                      //     builder: ((context) =>
                      //         QuizImageEditor(images: images)));
                    },
                    icon: const CircleAvatar(child: Icon(Icons.image))),
          )
        ],
      ),
    );
  }

  List get list => [answer, ...(otherCorrectAnswers ?? {})];

  ///[Map]  for generating [ShortAnswer] quiz to return map which would be turned to json for backend
  @override
  Map<String, dynamic> toJson() {
    return {
      "category": quizType!.valueName,
      "question": question,
      'answeroption': otherCorrectAnswers!.toList(),
      "correct_answer": answer,
      "images": images!
          .map((e) => e is Map<String, String?>
              ? ParseFile(File(e['url']!))
              : ParseFile(File(e.path)))
          .toList(),
    };
  }

  @override
  List<Object?> get props => [answer, questions, quizType];

  @override
  bool? get stringify => throw UnimplementedError();
}
