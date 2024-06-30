// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hermione/src/core/constants/size_utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';
import 'package:hermione/src/core/constants/constants.dart';
import 'package:hermione/src/core/constants/text_style.dart';
import 'package:hermione/src/features/assessment/data/models/quizmodels/created_quiz_viewer_ui/question_model.dart';
import 'package:hermione/src/features/assessment/presentation/pages/quiz/reviewscreen.dart';
import 'package:hermione/src/features/home/domain/repositories/currentuserrepository.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import 'package:hermione/src/features/assessment/presentation/pages/quiz/customappbar.dart';
import 'package:hermione/src/features/assessment/presentation/pages/quiz/mainquizscreen.dart';

import '../../../domain/repositories/retievedquizdata.dart';

class QuizResultScreen extends ConsumerStatefulWidget {
  static String id = 'QuizResultScreen';
  final double scoreDecimal;
  final String name;
  const QuizResultScreen({
    required this.name,
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

  var widgetsToImageController = WidgetsToImageController();
  Uint8List? bytes;
  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    var user;
    log(ref.watch(userProvider)!.name.toString());
    final quizlist = ref.watch(quizListProvider).getQuizes;
    final quizstate = ref.watch(quizcontrollerProvider);
    int percentage =
        ((quizstate.correct.length / quizlist.length) * 100).floor();
    int total = quizlist.length;
    return Scaffold(
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
            color: Color(0xff065774),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            )),
        height: 110,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Share as',
              style: AppTextStyle.mediumTitlename.copyWith(
                color: Colors.white,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: List.generate(
                shareoptionsList.length,
                (index) => GestureDetector(
                  onTap: () async {
                    if (index == 0) {
                      String link = '';
                      Share.share(
                          'HI,I got $percentage% on a quiz about ${widget.name} on Hermoine AI app, here\'s a link to view what its about $link',
                          subject: 'Hermoine AI Alert');
                    } else {
                      showDialog(
                          context: context,
                          builder: (context) => Dialog(
                                backgroundColor: Colors.transparent,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: WidgetsToImage(
                                          controller: widgetsToImageController,
                                          child: ImageCard(
                                            question: quizlist.last,
                                            widgetsToImageController:
                                                widgetsToImageController,
                                            percentage: percentage,
                                            name: widget.name,
                                          )),
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            fixedSize: Size(
                                                getScreenSize(context).width -
                                                    100,
                                                50)),
                                        onPressed: () async {
                                          final bytes =
                                              await widgetsToImageController
                                                  .capture();
                                          setState(() {
                                            this.bytes = bytes;
                                          });

                                          Share.shareXFiles([
                                            XFile.fromData(
                                              bytes!,
                                              name: 'hermoineImage.png',
                                              mimeType: 'image/png',
                                            )
                                          ],
                                              text:
                                                  'I got $percentage% on a quiz on Hermione AI, It was an awesome experience. Defeat the FOMO by Creating and sharing AI quizes today ');
                                        },
                                        child: Text(
                                          'Share Image',
                                          style: AppTextStyle.mediumTitlename
                                              .copyWith(color: Colors.white),
                                        )),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              fixedSize: Size(
                                                  getScreenSize(context).width -
                                                      100,
                                                  50)),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Cancel',
                                            style: AppTextStyle.mediumTitlename
                                                .copyWith(color: Colors.white),
                                          )),
                                    )
                                  ],
                                ),
                              ));
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: shareoptionsList[index].icon,
                    ),
                  ),
                ),
              ).toList(),
            )
          ],
        ),
      ),
      appBar: CustomResultAppBar(
        quizState: quizstate,
        quizlength: total,
        score: animation!.value,
      ),
      body: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
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
                                .then((value) async {
                              ref
                                  .watch(quizcontrollerProvider.notifier)
                                  .clearQuizState();

                              int s = user!.xp.isNotEmpty
                                  ? int.tryParse(user.xp)! +
                                      (widget.scoreDecimal * 100).toInt()
                                  : 10;
                              log(s.toString());
                              await FirebaseFirestore.instance
                                  .collection('Users')
                                  .doc(user!.email)
                                  .update({'xp': s.toString()})
                                  .then((value) => null)
                                  .onError((error, stackTrace) {
                                    log(error.toString());
                                  })
                                  .whenComplete(() {
                                    ref
                                        .watch(userProvider.notifier)
                                        .copyWithXp(s.toString());
                                    Navigator.pop(context);
                                    Navigator.popUntil(
                                        context, (route) => route.isFirst);
                                    showDialog(
                                        context: context,
                                        builder: ((context) => AlertDialog(
                                              content: Text(
                                                  'You have been rewarded with ${(widget.scoreDecimal * 100).toInt()}xp.'),
                                            )));
                                    setState(() {});
                                  });
                              return null;
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

class ImageCard extends StatelessWidget {
  final int percentage;

  final String name;

  const ImageCard({
    super.key,
    required this.question,
    required this.widgetsToImageController,
    required this.percentage,
    required this.name,
  });
  final WidgetsToImageController widgetsToImageController;
  final Question question;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 600,
        height: 300,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Image.asset(
                          'assets/mascot/mascot.png',
                          width: 80,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Quiz with Hermoine AI',
                              textAlign: TextAlign.start,
                              style: AppTextStyle.mediumTitlename.copyWith(
                                color: Colors.blueAccent,
                              ),
                            ),
                            Text(question.question,
                                style: AppTextStyle.largeTitlename),
                            Text(question.correctanswer,
                                style: AppTextStyle.largeTitlename.copyWith(
                                    color:
                                        const Color.fromARGB(255, 49, 175, 53),
                                    fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                    child: Center(
                  child: Text(
                    'HI,I got $percentage% on a quiz about $name on Hermoine AI app',
                    textAlign: TextAlign.center,
                    style: AppTextStyle.largeTitlename.copyWith(
                      color: Colors.deepOrange,
                    ),
                  ),
                )),
              ],
            ),
          ),
        ));
  }
}

class ShareOptions {
  final Icon icon;
  final String iconname;

  const ShareOptions({required this.icon, required this.iconname});
}

const List<ShareOptions> shareoptionsList = [
  ShareOptions(
    icon: Icon(Icons.copy),
    iconname: 'Copy',
  ),
  ShareOptions(
    icon: Icon(Icons.share),
    iconname: 'chat',
  ),
];
