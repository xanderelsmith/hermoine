// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:rive/rive.dart';

import 'package:hermione/src/core/constants/constants.dart';
import 'package:hermione/src/core/constants/size_utils.dart';
import 'package:hermione/src/features/assessment/domain/entities/quizstate.dart';
import 'package:hermione/src/features/assessment/presentation/pages/quiz/customappbar.dart';
import 'package:hermione/src/features/assessment/presentation/pages/quiz/mainquizscreen.dart';

import '../../../domain/repositories/retievedquizdata.dart';
import '../../widgets/resultsubcomponent.dart';

class QuizResultScreen extends ConsumerStatefulWidget {
  static String id = 'QuizResultScreen';
  const QuizResultScreen({
    super.key,
  });
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuizResultScreenState();
}

class _QuizResultScreenState extends ConsumerState<QuizResultScreen>
    with SingleTickerProviderStateMixin {
  ParseObject? quizObject;
  Animation? animation;
  AnimationController? animationController;
  @override
  void initState() {
    animationController = AnimationController(
        value: 1, vsync: this, duration: const Duration(milliseconds: 1500));
    animation = Tween<double>(begin: 0, end: 1).animate(animationController!);
    animation!.addListener(() {
      setState(() {
        log(animation!.value.toString());
      });
    });
    animationController!.forward();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    quizObject = ref.watch(quizListProvider).quizdata;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    var user;

    final quizlist = ref.watch(quizListProvider).getQuizes;
    final quizstate = ref.watch(quizcontrollerProvider);

    var total = quizlist.length;
    return Scaffold(
      appBar: CustomResultAppBar(
        quizState: quizstate,
        quizlength: total,
        score: animationController!.value,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
              3,
              (index) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (index == 0) {
                            ref
                                .watch(quizcontrollerProvider.notifier)
                                .clearQuizState();
                            Navigator.pop(context);
                          } else if (index == 1) {
                            Navigator.popUntil(
                                context, (route) => route.isFirst);
                          } else {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ReviewsScreen()));
                          }
                        },
                        child: CircleAvatar(
                            backgroundColor: index == 0
                                ? Colors.amber
                                : index == 1
                                    ? Colors.blueAccent
                                    : Colors.green,
                            child: Icon(
                              index == 0
                                  ? Icons.replay
                                  : index == 1
                                      ? Icons.home_outlined
                                      : Icons.rate_review_rounded,
                              color: Colors.white,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                        child: Text(index == 0
                            ? 'Replay'
                            : index == 1
                                ? 'home'
                                : 'Review'),
                      )
                    ],
                  )),
        ),
      ),
    );
  }

  // Future<void> sendViewerDetails(ParseUser? user, int score, int total) async {
  //   List quizViewersList = quizObject!['viewers'] ?? [];

  //   quizViewersList.add(
  //       {'user': user, 'score': score, 'total': total, 'date': DateTime.now()});

  //   log(quizViewersList.length.toString());
  //   quizObject!.set('viewers', quizViewersList);
  //   await quizObject!.update();
  //   log(quizViewersList.length.toString());
  // }
}

class ReviewsScreen extends ConsumerWidget {
  const ReviewsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var quizquestionsList = ref.watch(quizListProvider).getQuizes;
    var incorrectQuizList = ref.watch(quizcontrollerProvider).incorrect;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Review'),
        centerTitle: true,
        backgroundColor: const Color(0xff076688),
      ),
      body: SizedBox(
        height: getScreenSize(context).height,
        width: getScreenSize(context).width,
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: List.generate(quizquestionsList.length, (index) {
            return Card(
              color: incorrectQuizList.any((element) =>
                      element.correctanswer ==
                      quizquestionsList[index].correctanswer)
                  ? Colors.red
                  : null,
              child: Container(
                  margin: const EdgeInsets.all(15),
                  height: 100,
                  width: getScreenSize(context).width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text((index + 1).toString()),
                          ),
                          Expanded(
                            child: Text(
                              quizquestionsList[index].question,
                              style: AppTextStyle.mediumTitlename,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Text('Ans:'),
                          ),
                          Expanded(
                            child: Text(
                              quizquestionsList[index].correctanswer,
                              style: AppTextStyle.titlename
                                  .copyWith(color: Colors.green),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              softWrap: true,
                            ),
                          )
                        ],
                      ),
                    ],
                  )),
            );
          }),
        ),
      ),
    );
  }
}

class ScoreChart extends ConsumerWidget {
  const ScoreChart({
    super.key,
    required this.score,
  });
  final double score;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizlist = ref.watch(quizListProvider).getQuizes;

    final quizstate = ref.watch(quizcontrollerProvider);

    var total = quizlist.length;
    return Center(
        child: Stack(
      children: [
        const Center(
          child: CircleAvatar(
            radius: 83,
            backgroundColor: Colors.white,
            child: CircularProgressIndicator(
              strokeWidth: 55,
              strokeAlign: 1.4,
              value: 0.1,
              color: Color(0xff076688),
            ),
          ),
        ),
        Center(
          child: Material(
            shape: const CircleBorder(),
            elevation: 5,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              radius: 45,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Your Score'),
                  Text(
                    score.toString(),
                    style: AppTextStyle.mediumTitlename
                        .copyWith(color: const Color(0xff065774)),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    ));
  }
}
