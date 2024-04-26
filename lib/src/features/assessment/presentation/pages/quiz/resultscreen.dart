// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hermione/src/core/constants/text_style.dart';
import 'package:hermione/src/features/assessment/presentation/pages/quiz/reviewscreen.dart';
import 'package:hermione/src/features/home/domain/repositories/currentuserrepository.dart';
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
  final double scoreDecimal;
  const QuizResultScreen({
    required this.scoreDecimal,
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
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween<double>(begin: 0, end: widget.scoreDecimal)
        .animate(animationController!);

    animationController!.addListener(() {
      setState(() {});
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
    log(ref.watch(userProvider)!.name.toString());
    final quizlist = ref.watch(quizListProvider).getQuizes;
    final quizstate = ref.watch(quizcontrollerProvider);

    int total = quizlist.length;
    return Scaffold(
      appBar: CustomResultAppBar(
        quizState: quizstate,
        quizlength: total,
        score: animation!.value,
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
                          var user = ref.watch(userProvider);
                          int score = quizstate.correct.length;
                          if (index == 0) {
                            ref
                                .watch(quizcontrollerProvider.notifier)
                                .clearQuizState();
                            Navigator.pop(context);
                          } else if (index == 1) {
                            showDialog(
                                context: context,
                                builder: (context) => const Center(
                                    child: CircularProgressIndicator()));
                            sendViewerDetails(
                                    user?.username, user?.email, score, total)
                                .then((value) {
                              ref
                                  .watch(quizcontrollerProvider.notifier)
                                  .clearQuizState();

                              Navigator.pop(context);
                              Navigator.popUntil(
                                  context, (route) => route.isFirst);
                              setState(() {});
                            });
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

  Future<void> sendViewerDetails(
      String? username, String? userEmaill, int score, int total) async {
    List quizViewersList =
        quizObject!['viewers'] != null ? quizObject!['viewers']! : [];

    quizViewersList.add({
      'username': username,
      'userEmail': userEmaill,
      'score': score,
      'total': total,
      'date': DateTime.now()
    });

    log(quizViewersList.length.toString());
    quizObject!.set('viewers', quizViewersList);
    await quizObject!.update();
    log(quizViewersList.length.toString());
  }
}
