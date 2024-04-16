import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hermione/src/core/constants/constants.dart';
import 'package:hermione/src/features/assessment/presentation/pages/quiz/mainquizscreen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:rive/rive.dart';

import '../../../../home/presentation/pages/homepage.dart';
import '../../../domain/repositories/retievedquizdata.dart';

class QuizResultScreen extends ConsumerStatefulWidget {
  static String id = 'QuizResultScreen';
  const QuizResultScreen({
    Key? key,
  }) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _QuizResultScreenState();
}

class _QuizResultScreenState extends ConsumerState<QuizResultScreen> {
  ParseObject? quizObject;

  @override
  void initState() {
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
    final quizdatacontroller = ref.watch(quizcontrollerProvider);
    final quizstate = ref.watch(quizcontrollerProvider);
    var score = quizstate.correct.length;
    var total = quizlist.length;
    return Scaffold(
      appBar: AppBar(
        leading: const SizedBox(),
        centerTitle: true,
        title: Text(
          !quizstate.incorrect.isNotEmpty
              ? 'Congratulations'
              : 'Let\'s get better, Comrade!',
          textAlign: TextAlign.center,
          style:
              AppTextStyle.largeTitlename.copyWith(fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Stack(
                children: [
                  RiveAnimation.asset(
                    'assets/mascot/hermione.riv',
                    animations: ['correct'],
                    useArtboardSize: true,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Keep practicing and you\'ll never forget the answers to these questions!',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.mediumTitlename,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    const Text(
                      'Your Score',
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      '${score}/${total}',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.mediumTitlename,
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  children: [
                    Text(
                      'Rate the quiz',
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: quizstate.incorrect.isEmpty
                    ? const SizedBox.shrink()
                    : TextButton.icon(
                        icon: const Icon(
                            Icons.keyboard_double_arrow_right_outlined),
                        label: Text(
                          'Preview failed quizes ',
                          style: AppTextStyle.mediumTitlename,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => const Scaffold())));
                        },
                      ),
              ),
              // reaction == null
              //     ? const SizedBox.shrink()
              //     :
              Container(
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).canvasColor,
                  border: Border.all(width: 2, color: Colors.white60),
                ),
                height: 50,
                width: 50,
                child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () async {
                      showDialog(
                          context: context,
                          builder: (context) =>
                              const Center(child: CircularProgressIndicator()));

                      // await sendViewerDetails(user, score, total)
                      //     .then((value) async {
                      //   ref.refresh(quizListProvider).clearQuiz();
                      //   ref
                      //       .refresh(quizcontrollerProvider.notifier)
                      //       .clearQuizState();

                      //   Navigator.pop(context);

                      Navigator.popUntil(context, (route) => route.isFirst);
                      //   Navigator.popUntil(context,
                      //       (route) => route.settings.name == HomePage.id);
                      // }).onError((error, stackTrace) {
                      //   print(error.toString());
                      // });
                    }),
              )
            ],
          ),
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
