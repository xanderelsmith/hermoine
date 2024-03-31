class GeminiSparkConfig {
  static String apiKey = 'AIzaSyC-Bzvrs_tto8YJP8_QHCfrYzVvS53n6-4';
  static List<Map> quizSample = [
    {
      "category": "multichoice",
      "question": "QUESTION_TEXT",
      "correct_answer": "CORRECT_ANSWER",
      "incorrect_answers": [
        "INCORRECT_ANSWER_1",
        "INCORRECT_ANSWER_2",
        "INCORRECT_ANSWER_3",
        "INCORRECT_ANSWER_4"
      ],
      "images": []
    },
    {
      "category": "shortTextAnswer",
      "question": "QUESTION_TEXT",
      "correct_answer": "CORRECT_ANSWER",
      "answeroption": ["OtherAcceptedANSWER1", "OtherAcceptedANSWER2"],
      "images": []
    },
    {
      "category": "draganddrop",
      "question": "QUESTION_TEXT",
      "wrong_answer_list": [
        "INCORRECT_ANSWER_1",
        "INCORRECT_ANSWER_2",
      ],
      "correct_answers": [
        "INCORRECT_ANSWER_3",
        "INCORRECT_ANSWER_4",
        "INCORRECT_ANSWER_5"
      ],
      "images": []
    }
  ];

  static String prompt(String message) =>
      'Extract key information from this  provided text $message  and generate a quiz in JSON format, adhering to the following structure:${quizSample.toString()}\n and these rules $rules';
}

const String rules =
    """ Scan for sentences that can be transformed into multichoice, short answer, or drag-and-drop questions.I WILL DECODE THIS IN MY FLUTTER APP DIRECTLY SO GIVE ONLY THE LIST OF JSON QUESTIONS, and do not add anything to the response except the list of map, e.g```, 
Extract key phrases for questions and answers: Accurately extract relevant phrases for both questions and their corresponding answers.
Categorize questions: Determine the appropriate category (multichoice, shortTextAnswer, or draganddrop) for each question.
Formulate clear and concise questions: Ensure questions are well-structured and easy to understand. generate the questions a s a teeacher teaching the subject, also options shouldn't be exceed than 3 words,
 """;
