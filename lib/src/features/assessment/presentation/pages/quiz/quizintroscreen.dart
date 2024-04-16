import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hermione/src/core/constants/constants.dart';
import 'package:hermione/src/core/constants/size_utils.dart';
import 'package:hermione/src/features/assessment/presentation/pages/quiz/mainquizscreen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:rive/rive.dart';

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
  // RiveAnimation? riveAnimation = const RiveAnimation.asset(
  //   'assets/mascot/hermione.riv',
  //   animations: ['wrong'],
  //   useArtboardSize: true,
  // );
  RiveFile? riveFile;
  RiveAnimation? riveAnimation;
  @override
  void initState() {
    topic = widget.quizdata['topic'];
    animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 500));
    animation = Tween<double>(begin: 0, end: 1).animate(animationController!);
    animationController!.addListener(() {
      setState(() {});
    });

    animationController!.forward();
    riveAnimation = const RiveAnimation.asset(
      'assets/mascot/hermione.riv',
      animations: ['intro idle'],
      useArtboardSize: true,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            onPressed: () {
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
              curve: Curves.easeIn,
              right: 0,
              top: index * 120 * (animation!.value!),
              duration: Duration(seconds: index * 2),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Visibility(
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
            ),
          ),
          Positioned(
            right: 130,
            top: getScreenSize(context).height / 6,
            child: riveAnimation!,
          )
        ],
      ),
    );
  }
}

String getMascotWords(topic, int index) {
  List mascotSpeech2 = mascotSpeech(topic)['quiz'];
  return mascotSpeech2[index];
}
