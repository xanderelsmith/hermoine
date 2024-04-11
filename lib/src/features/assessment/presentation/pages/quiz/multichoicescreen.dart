import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hermione/src/core/constants/constants.dart';
import 'package:hermione/src/core/constants/size_utils.dart';
import 'package:hermione/src/core/constants/text_style.dart';
import 'package:hermione/src/features/assessment/data/models/quizmodels/created_quiz_viewer_ui/multichoicequizviewer.dart';
import 'package:hermione/src/features/assessment/data/models/quizmodels/created_quiz_viewer_ui/question_model.dart';
import 'package:hermione/src/features/assessment/presentation/pages/quiz/mainquizscreen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/constants/colors.dart';

class MultiChoiceUIScreen extends ConsumerStatefulWidget {
  const MultiChoiceUIScreen({
    super.key,
    required this.screensize,
    // required this.topic,
    required this.question,
  });

  final Size screensize;
  // final String topic;
  final Question question;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MultiChoiceUIScreenState();
}

class _MultiChoiceUIScreenState extends ConsumerState<MultiChoiceUIScreen> {
  late MultiChoice quizdata;
  List<String> answer = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quizdata = widget.question as MultiChoice;
    answer
      ..add(quizdata.answer!)
      ..addAll(quizdata.incorrectanswers)
      ..shuffle();
  }

  @override
  Widget build(BuildContext context) {
    final quizdatacontroller = ref.watch(quizcontrollerProvider);
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          color: AppColor.white,
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 5.0,
              horizontal: 10,
            ),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  QuestionCard(
                    question: widget.question,
                    screensize: widget.screensize,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        answer.length,
                        (index) => AnswerCard(
                            answer: answer[index],
                            isSelected: answer[index] ==
                                quizdatacontroller.selectedAnswer,
                            isCorrect: answer[index] == quizdata.correctanswer,
                            isDisplayingAnswer: quizdatacontroller.answered,
                            onTap: () {
                              ref
                                  .watch(quizcontrollerProvider.notifier)
                                  .submitAnswer(
                                      MultiChoice(
                                          indexM: quizdata.indexM,
                                          answer: quizdata.answer,
                                          images: quizdata.images,
                                          incorrectanswers:
                                              quizdata.incorrectanswers,
                                          question_: quizdata.question_),
                                      answer[index]);
                            }),
                      ).toList(),
                    ),
                  ),
                ]),
          ),
        ));
  }
}

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.screensize,
    required this.question,
  });

  final Size screensize;
  final Question question;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: screensize.width / 2,
        width: screensize.width,
        decoration: BoxDecoration(
            color: AppColor.white, borderRadius: BorderRadius.circular(10)),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Text(
                  question.question,
                  style: AppTextStyle.mediumTitlename,
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: HIntWidget(question: question),
            )
          ],
        ));
  }
}

class HIntWidget extends StatelessWidget {
  const HIntWidget({
    super.key,
    required this.question,
  });
  final Question question;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
            isDismissible: false,
            isScrollControlled: true,
            context: context,
            builder: (context) => SizedBox(
                  height: getScreenSize(context).height / 1.2,
                  child: DraggableScrollableSheet(
                    initialChildSize: 1, //set this as you want
                    maxChildSize: 1, //set this as you want
                    minChildSize: 0.5, //set this as you want
                    builder: (BuildContext context, scrollController) {
                      return const ChatScreen();
                    },
                  ),
                ));
      },
      child: Container(
        height: 60,
        decoration: const BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.only(topRight: Radius.circular(10))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Icon(
                Icons.lightbulb,
                color: Colors.white,
              ),
              Text(
                'Hint',
                style: AppTextStyle.titlename.copyWith(color: AppColor.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Chat',
          style: AppTextStyle.mediumTitlename,
        ),
        Expanded(
          child: ListView.builder(
            reverse: true, // Show newest messages at the bottom
            itemCount: messages.length,
            itemBuilder: (context, index) => messageBubble(messages[index]),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Type your message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  // Implement message sending logic here
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// This is a sample message class, modify it as needed
class Message {
  final String text;
  final bool isCurrentUser;

  Message(this.text, this.isCurrentUser);
}

Widget messageBubble(Message message) {
  return Align(
    alignment:
        message.isCurrentUser ? Alignment.centerRight : Alignment.centerLeft,
    child: Container(
      padding: const EdgeInsets.all(12.0),
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: message.isCurrentUser ? Colors.blue[100] : Colors.grey[200],
      ),
      child: Text(message.text),
    ),
  );
}

// Replace with your actual list of messages
List<Message> messages = [
  Message('Hi there!', false),
  Message('Hello! How can I help you?', true),
];

//
class AnswerCard extends StatelessWidget {
  final String answer;
  final bool isSelected;
  final bool isCorrect;
  final bool isDisplayingAnswer;

  final VoidCallback onTap;

  const AnswerCard({
    Key? key,
    required this.answer,
    required this.isSelected,
    required this.isCorrect,
    required this.isDisplayingAnswer,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(
          vertical: 10.0,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
          horizontal: 20.0,
        ),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          // boxShadow: boxShadow,
          border: Border.all(
            color: isDisplayingAnswer
                ? isCorrect
                    ? Colors.green
                    : isSelected
                        ? Colors.red
                        : Colors.white
                : Colors.white,
            width: 4.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                answer,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: isDisplayingAnswer && isCorrect
                      ? FontWeight.bold
                      : FontWeight.w400,
                ),
              ),
            ),
            if (isDisplayingAnswer)
              isCorrect
                  ? const CircularIcon(icon: Icons.check, color: Colors.green)
                  : isSelected
                      ? const CircularIcon(
                          icon: Icons.close,
                          color: Colors.red,
                        )
                      : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}

//
class CircularIcon extends StatelessWidget {
  final IconData icon;
  final Color color;

  const CircularIcon({
    Key? key,
    required this.icon,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24.0,
      width: 24.0,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        // boxShadow: boxShadow,
      ),
      child: Icon(
        icon,
        color: Colors.white,
        size: 16.0,
      ),
    );
  }
}
