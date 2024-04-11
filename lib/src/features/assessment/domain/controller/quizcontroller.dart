import 'package:flutter/foundation.dart';
import 'package:hermione/src/features/assessment/data/models/quizmodels/created_quiz_viewer_ui/question_model.dart';
import 'package:hermione/src/features/assessment/data/models/quizmodels/created_quiz_viewer_ui/shortanswerquizviewer.dart';
import 'package:hermione/src/features/assessment/data/sources/enums/quiztype_enum.dart';
import 'package:hermione/src/features/assessment/domain/entities/quiz_status.dart';
import 'package:hermione/src/features/assessment/domain/entities/quizstate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class QuizController extends StateNotifier<QuizState> {
  QuizState get quizstate => state;
  clearQuizState() {
    state = state.copyWith(
        correct: [],
        incorrect: [],
        selectedAnswer: '',
        status: QuizStatus.initial);
  }

  QuizController() : super(QuizState.initial());
  void submitAnswer(Question currentquestion, dynamic answer) {
    //checks if the quiz is complete
    if (state.answered) return;
    //checks if the question is multichoice to add it to a controller
    if (currentquestion.quizType == QuizType.multichoice) {
      if (currentquestion.correctanswer == answer) {
        successSound();
        state = state.copyWith(
            status: QuizStatus.correct,
            selectedAnswer: answer,
            correct: [...state.correct, currentquestion]);
      } else {
        wrongSelectionSound();
        state = state.copyWith(
          status: QuizStatus.incorrect,
          incorrect: [...state.incorrect, currentquestion],
          selectedAnswer: answer,
        );
      }
    } else if (currentquestion.quizType == QuizType.draganddrop) {
      if (listEquals(currentquestion.question.split(' '), answer)) {
        successSound();
        state = state.copyWith(
            status: QuizStatus.correct,
            selectedAnswer: answer,
            correct: [...state.correct, currentquestion]);
      } else {
        wrongSelectionSound();
        state = state.copyWith(
          status: QuizStatus.incorrect,
          incorrect: [...state.incorrect, currentquestion],
          selectedAnswer: answer,
        );
      }
    } else {
      if (currentquestion.correctanswer == answer ||
          (currentquestion as ShortAnswer)
              .otherCorrectAnswers!
              .contains(answer)) {
        successSound();
        state = state.copyWith(
            status: QuizStatus.correct,
            selectedAnswer: answer,
            correct: [...state.correct, currentquestion]);
      } else {
        wrongSelectionSound();
        state = state.copyWith(
          status: QuizStatus.incorrect,
          incorrect: [...state.incorrect, currentquestion],
          selectedAnswer: answer,
        );
      }
    }
  }

  ///sets the quiz to be complete or initial (which would be checked to proceed to quiz view screen results)
  void nextQuestion(List<Question> question, int currentindex) {
    state = state.copyWith(
        selectedAnswer: '',
        status: currentindex + 1 < question.length
            ? QuizStatus.initial
            : QuizStatus.complete);
  }

  void reset() {
    state = QuizState.initial();
  }
}

void wrongSelectionSound() {
  // AudioPlayer plyr = AudioPlayer();
  // plyr.play(AssetSource('wronganswer.mp3'));
}

void successSound() {
  // AudioPlayer plyr = AudioPlayer();
  // plyr.play(AssetSource('correct.mp3'));
}
