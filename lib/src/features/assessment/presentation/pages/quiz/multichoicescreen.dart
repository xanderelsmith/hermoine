import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:hermione/src/core/constants/constants.dart';
import 'package:hermione/src/core/utils/screensizeutils.dart';
import 'package:hermione/src/features/assessment/data/models/quizmodels/created_quiz_viewer_ui/multichoicequizviewer.dart';
import 'package:hermione/src/features/assessment/data/models/quizmodels/created_quiz_viewer_ui/question_model.dart';
import 'package:hermione/src/features/assessment/presentation/pages/quiz/mainquizscreen.dart';
import 'package:hermione/src/features/home/domain/repositories/currentuserrepository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rive/rive.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

import '../../../domain/entities/geminiapihelper.dart';
import '../../widgets/questioncard.dart';

class MultiChoiceUIScreen extends ConsumerStatefulWidget {
  const MultiChoiceUIScreen({
    required this.index,
    super.key,
    required this.screensize,
    // required this.topic,
    required this.question,
  });
  final int index;
  final Size screensize;
  // final String topic;
  final Question question;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MultiChoiceUIScreenState();
}

class _MultiChoiceUIScreenState extends ConsumerState<MultiChoiceUIScreen> {
  late MultiChoice quizdata;
  StateMachineController? controller;
  SMITrigger? idle;
  SMITrigger? correct;
  SMITrigger? wrong;

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
                  Column(
                    children: [
                      QuestionCard(
                        index: widget.index,
                        animationChild:
                            RiveAnimation.asset('assets/mascot/hermione.riv',
                                animations: const [
                                  'idle question',
                                ],
                                fit: BoxFit.fitHeight,
                                stateMachines: const ['State Machine 1'],
                                onInit: (artboard) {
                          controller = StateMachineController.fromArtboard(
                            artboard,
                            "State Machine 1",
                          );
                          if (controller == null) return;
                          artboard.addController(controller!);
                          correct = controller!.findSMI('correct');
                          wrong = controller!.findSMI('wrong');
                          idle = controller!.findSMI('intro idle');
                        }),
                        question: widget.question,
                        screensize: widget.screensize,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: SizedBox(
                      height: getScreenSize(context).height / 2,
                      child: ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                        children: List.generate(
                          answer.length,
                          (index) => AnswerCard(
                              answer: answer[index],
                              isSelected: answer[index] ==
                                  quizdatacontroller.selectedAnswer,
                              isCorrect:
                                  answer[index] == quizdata.correctanswer,
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
                                if (answer[index] == quizdata.correctanswer) {
                                  correct!.fire();
                                } else {
                                  wrong!.fire();
                                }
                              }),
                        ).toList(),
                      ),
                    ),
                  ),
                ]),
          ),
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
                      return SectionChat(
                        extractedText: '',
                      );
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

class SectionChat extends ConsumerStatefulWidget {
  const SectionChat({super.key, required this.extractedText});
  final String extractedText;
  @override
  ConsumerState<SectionChat> createState() => _SectionChatState();
}

class _SectionChatState extends ConsumerState<SectionChat> {
  TextEditingController controller = TextEditingController();
  final gemini = Gemini.instance;
  bool _loading = false;
  bool isAsking = true;
  bool get loading => _loading;

  set loading(bool set) => setState(() => _loading = set);
  final List<Content> chats = [];
  var scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    final userDetails = ref.watch(userProvider);
    Size screensize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
              child: chats.isNotEmpty
                  ? Align(
                      alignment: Alignment.bottomCenter,
                      child: SingleChildScrollView(
                        reverse: true,
                        child: ListView.builder(
                          itemBuilder: chatItem,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: chats.length,
                          reverse: false,
                        ),
                      ),
                    )
                  : isAsking == false
                      ? const SizedBox(
                          child: Center(child: Text('Send a message')),
                        )
                      : Center(
                          child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            height: 300,
                            child: Card(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.bottomRight,
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isAsking = false;
                                          });
                                        },
                                        icon: const Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        )),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      'Ask a question concerning the material',
                                      style: AppTextStyle.mediumTitlename,
                                    ),
                                  ),
                                  Expanded(
                                    child: Scrollbar(
                                      interactive: true,
                                      thumbVisibility: true,
                                      controller: scrollController,
                                      child: SingleChildScrollView(
                                        controller: scrollController,
                                        child: Text(
                                          widget.extractedText,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ))),
          if (loading) const CircularProgressIndicator(),
          ChatInputBox(
            controller: controller,
            onSend: () {
              String prompt = 'Generate a brief understandable response ';
              if (controller.text.isNotEmpty) {
                final searchedText = chats.isNotEmpty || isAsking == false
                    ? controller.text
                    : '$prompt,**${controller.text}**,${widget.extractedText}';
                chats.add(Content(
                    role: userDetails!.username ?? 'user',
                    parts: [Parts(text: searchedText)]));
                controller.clear();
                loading = true;

                gemini.streamGenerateContent(searchedText).listen((value) {
                  chats.add(Content(
                      role: 'Spark_Gemini',
                      parts: [Parts(text: value.output)]));
                  loading = false;
                });
              }
            },
          ),
        ],
      ),
    );
  }

  Widget chatItem(BuildContext context, int index) {
    final Content content = chats[index];

    return Card(
      elevation: 0,
      color: content.role == 'Spark_Gemini'
          ? Colors.blue.shade800
          : Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: content.role == 'Spark_Gemini'
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: content.role != 'Spark_Gemini'
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
              children: [
                CircleAvatar(
                    child: Icon(content.role != 'Spark_Gemini'
                        ? Icons.person
                        : Icons.android)),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(content.role ?? 'role'),
                ),
              ],
            ),
            Markdown(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                data:
                    content.parts?.lastOrNull?.text ?? 'cannot generate data!'),
          ],
        ),
      ),
    );
  }
}

class ChatInputBox extends StatelessWidget {
  final TextEditingController? controller;
  final VoidCallback? onSend, onClickCamera;

  const ChatInputBox({
    super.key,
    this.controller,
    this.onSend,
    this.onClickCamera,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (onClickCamera != null)
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: IconButton(
                  onPressed: onClickCamera,
                  color: Theme.of(context).colorScheme.onSecondary,
                  icon: const Icon(Icons.file_copy_rounded)),
            ),
          Expanded(
              child: TextField(
            controller: controller,
            minLines: 1,
            maxLines: 6,
            cursorColor: Theme.of(context).colorScheme.inversePrimary,
            textInputAction: TextInputAction.newline,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 4),
              hintText: 'Message',
              border: InputBorder.none,
            ),
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
          )),
          Padding(
            padding: const EdgeInsets.all(4),
            child: FloatingActionButton.small(
              onPressed: onSend,
              child: const Icon(Icons.send_rounded),
            ),
          )
        ],
      ),
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
    super.key,
    required this.answer,
    required this.isSelected,
    required this.isCorrect,
    required this.isDisplayingAnswer,
    required this.onTap,
  });

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
