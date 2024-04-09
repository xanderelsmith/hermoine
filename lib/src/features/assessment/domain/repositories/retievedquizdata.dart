import 'package:flutter/foundation.dart';
import 'package:hermione/src/features/assessment/domain/repositories/createdquizrepo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../data/models/quizmodels/created_quiz_viewer_ui/question_model.dart';

final quizListProvider = StateProvider<RetrievedQuizRepository>((ref) {
  return RetrievedQuizRepository();
});

class RetrievedQuizRepository extends StateNotifier<List<Question>> {
  RetrievedQuizRepository() : super([]);
  List<Question> get getQuizes => state;
  clearQuiz() {
    state = [];
  }

//quizdata
  ParseObject? quizdata;
  addQuizData(parseQuizData) {
    return quizdata = parseQuizData;
  }

  ///this stores the data of a single quiz,*(not list of quiz)
  inputData(ParseObject questionData) {
    final List<Question> questiondata =
        List.generate(questionData['questions'].length, (index) {
      final currentQuiz = questionData['questions'][index];
      return quizTypeDataChecker(index, currentQuiz);
    });
    state = questiondata;
    for (var element in state) {
      if (kDebugMode) {
        print(element.question);
      }
    }
  }
}

///c