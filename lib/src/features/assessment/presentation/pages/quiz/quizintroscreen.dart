import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hermione/src/core/constants/constants.dart';
import 'package:hermione/src/features/assessment/presentation/pages/quiz/mainquizscreen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../../../core/constants/colors.dart';
import '../../../../home/data/sources/mascotdata.dart';
import '../../../domain/repositories/singlefetched_quizesrepo.dart';

class QuizIntroScreen extends ConsumerStatefulWidget {
  final ParseObject quizdata;
  const QuizIntroScreen({
    super.key,
    required this.quizdata,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuizIntroScreenState();
}

class _QuizIntroScreenState extends ConsumerState<QuizIntroScreen>
    with SingleTickerProviderStateMixin {
  String topic = '';
  Animation<double>? animation;
  AnimationController? animationController;
  @override
  void initState() {
    topic = widget.quizdata['topic'];
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween<double>(begin: 1, end: 0).animate(animationController!);
    animationController!.addListener(() {
      setState(() {});
    });
    animationController!.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            onPressed: () {
              ref.watch(quizListProvider).addQuizData(widget.quizdata);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => QuizMainScreen(
                          topic: topic,
                        )),
              );
            },
            child: Text(
              'Let\'s Begin',
              style: AppTextStyle.mediumTitlename.copyWith(
                color: Colors.white,
              ),
            )),
      ),
      appBar: AppBar(
          title: LinearProgressIndicator(
        value: 0.1,
        backgroundColor: Colors.blue,
        minHeight: 20,
        color: const Color(0xff88FF59),
        borderRadius: BorderRadius.circular(10),
      )),
      body: Stack(
        children: [
          ...List.generate(
            4,
            (index) => AnimatedPositioned(
              curve: Curves.bounceInOut,
              top: index * 120,
              right: index * 100 * (animation!.value!),
              duration: Duration(seconds: index * 5),
              child: Container(
                margin: const EdgeInsets.all(8.0),
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColor.primaryColor,
                ),
                width: 200,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    getMascotWords(topic, index),
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: const Alignment(-0.8, -0.4),
            child: Image.asset('assets/mascot/mascot.png'),
          ),
        ],
      ),
    );
  }
}

String getMascotWords(topic, int index) {
  List mascotSpeech2 = mascotSpeech(topic)['quiz'];
  return mascotSpeech2[index];
}
