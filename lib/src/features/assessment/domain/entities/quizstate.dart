import 'package:hermione/src/features/assessment/domain/entities/quiz_status.dart';

import '../../data/models/quizmodels/created_quiz_viewer_ui/question_model.dart';

class QuizState {
  final dynamic selectedAnswer;
  final List<Question> correct;
  final List<Question> incorrect;
  final QuizStatus status;
  const QuizState({
    required this.selectedAnswer,
    required this.correct,
    required this.incorrect,
    required this.status,
  });

  factory QuizState.initial() {
    return const QuizState(
      selectedAnswer: '',
      correct: [],
      incorrect: [],
      status: QuizStatus.initial,
    );
  }

  bool get answered =>
      status == QuizStatus.incorrect || status == QuizStatus.correct;
  QuizState copyWith({
    dynamic selectedAnswer,
    List<Question>? correct,
    List<Question>? incorrect,
    QuizStatus? status,
  }) {
    return QuizState(
      selectedAnswer: selectedAnswer ?? this.selectedAnswer,
      correct: correct ?? this.correct,
      incorrect: incorrect ?? this.incorrect,
      status: status ?? this.status,
    );
  }
}
