import 'dart:developer';

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
  ];

  static String prompt(
      {required String message,
      required String topic,
      required int questionNumber,
      required String difficulty,
      String? instructions}) {
    String s =
        'Extract key information from this  provided text $message, with a topic $topic  and generate a quiz in valid JSON format, adhering to the following structure:${quizSample.toString()}\n and these rules $rules, it should be $questionNumber in number and have a difficulty of $difficulty, ${instructions != null ? 'follow these $instructions' : ''}';
    log(s);
    return s;
  }
}

const String rules =
    """do not begin with Scan for sentences that can be transformed into multichoice, short answer.I WILL DECODE THIS IN MY FLUTTER APP DIRECTLY SO GIVE ONLY THE LIST OF JSON QUESTIONS, and do not add anything to the response except the list of map, 
Extract key phrases for questions and answers: Accurately extract relevant phrases for both questions and their corresponding answers.
Categorize questions: Determine the appropriate category multichoice for each question. do not add indexes or numbers
     
Formulate clear and concise questions: Ensure questions are well-structured and easy to understand. generate the questions a s a teeacher teaching the subject, also options shouldn't be exceed than 3 words,most importantly if the number of value pairs doesnt match the number in the sample add more data to supplement
 """;
