import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:hermione/src/features/assessment/data/models/quizmodels/created_quiz_viewer_ui/question_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../data/models/quizmodels/created_quiz_viewer_ui/dragandropquizviewer.dart';
import '../../data/models/quizmodels/created_quiz_viewer_ui/multichoicequizviewer.dart';
import '../../data/models/quizmodels/created_quiz_viewer_ui/shortanswerquizviewer.dart';

class CachedCreatedPresentQuizDataRepo extends StateNotifier<List<Question>> {
  CachedCreatedPresentQuizDataRepo() : super([]);

  Map<String, dynamic> validateAiInputData(dynamic inputText) {
    dynamic inputData;
    if (inputText is String) {
      try {
        inputData = json.decode(inputText);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
        return {
          'message': 'Invalid JSON format.\n\n\n$e',
          'success': false,
        };
      }
    } else if (inputText is List) {
      inputData = inputText;
    }
    // Parse the input text as JSON

    // Check if inputData is a List
    if (inputData is! List) {
      return {'message': 'Input data is not a List.', 'success': false};
    }

    // Iterate through each map in the inputData list
    for (var i = 0; i < inputData.length; i++) {
      var item = inputData[i];

      // Check if item is a Map
      if (item is! Map) {
        return {'message': 'Item at index $i is not a Map.', 'success': false};
      }

      // Check if category exists and its value is either "shortTextAnswer" or "multichoice"
      if (!item.containsKey('category')) {
        return {
          'message': 'Item at index $i does not contain a "category" key.',
          'success': false
        };
      }

      var category = item['category'];
      if (category != 'shortTextAnswer' &&
          category != 'multichoice' &&
          category != 'draganddrop') {
        return {
          'message':
              'Item at index $i has an invalid "category" value: $category.',
          'success': false
        };
      }
    }
    List<Question> questiondata = returnQuestionData(inputData);
    state = [...questiondata, ...state];
    for (var element in state) {
      if (kDebugMode) {
        print(element.question);
      }
    }
    // All checks passed, input data is valid
    return {'message': 'Success', 'success': true, 'result': questiondata};
  }

  void remove(int index) {
    final detailsListValue = state;
    detailsListValue.removeAt(index);
    state = [...detailsListValue];
  }

  void clear() {
    var newdata = state..clear();
    state = [...newdata];
  }

  int get getListLength => state.length;
}

List<Question> returnQuestionData(List<dynamic> inputData, {bool? isParse}) {
  final List<Question> questiondata = inputData
      .asMap()
      .entries
      .map((entry) =>
          quizTypeDataChecker(entry.key, entry.value, isParse: isParse))
      .toList();
  return questiondata;
}

Question quizTypeDataChecker(index, Map quizjsondata, {bool? isParse}) {
  return quizjsondata['category'] == "shortTextAnswer"
      ? ShortAnswer(
          indexS: index,
          otherCorrectAnswers: (quizjsondata["answeroption"] ?? []).toSet(),
          images: isParse == true ? quizjsondata["images"] ?? [] : [],
          answer: quizjsondata["correct_answer"].toString(),
          questions: quizjsondata["question"].toString())
      : quizjsondata['category'] == "multichoice"
          ? MultiChoice(
              indexM: index,
              images: isParse == true ? quizjsondata["images"] ?? [] : [],
              answer: quizjsondata["correct_answer"].toString(),
              incorrectanswers: List.generate(
                  quizjsondata["incorrect_answers"].length,
                  (index) =>
                      quizjsondata["incorrect_answers"][index].toString()),
              question_: quizjsondata["question"].toString())
          : DragAndDrop(
              indexD: index,
              images: isParse == true ? quizjsondata["images"] ?? [] : [],
              correctanswers: List.generate(
                  quizjsondata["correct_answers"].length,
                  (index) => quizjsondata["correct_answers"][index]),
              incorrectanswers: List.generate(
                  quizjsondata["wrong_answer_list"].length,
                  (index) => quizjsondata["wrong_answer_list"][index]),
              questions: quizjsondata["question"].toString());
}

final createdQuizlistdataProvider =
    StateNotifierProvider<CachedCreatedPresentQuizDataRepo, List<Question>>(
        (ref) => CachedCreatedPresentQuizDataRepo());
