import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hermione/src/core/constants/colors.dart';
import 'package:hermione/src/core/constants/constants.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../home/domain/repositories/currentuserrepository.dart';
import '../../domain/repositories/createdquizrepo.dart';

// Assuming cleanjsonString function is defined elsewhere

class PreviewQuestionsPage extends ConsumerStatefulWidget {
  const PreviewQuestionsPage({
    required this.title,
    super.key,
    required this.questionData,
  });

  final String questionData;
  final String title;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PreviewQuestionsPagerState();
}

class _PreviewQuestionsPagerState extends ConsumerState<PreviewQuestionsPage> {
  String _cleanedQuestionData = '';

  @override
  void didUpdateWidget(covariant PreviewQuestionsPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    var quizlist = ref.watch(createdQuizlistdataProvider);
    if (quizlist.isEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final notifier = ref.read(createdQuizlistdataProvider.notifier);
        notifier.validateAiInputData(widget.questionData.startsWith('```json')
            ? cleanjsonString(widget.questionData)
            : widget.questionData);
      });
    } // Use a future or function outside widget lifecycle methods
  }

  @override
  void initState() {
    super.initState();

    // Use a future or function outside widget lifecycle methods
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final notifier = ref.read(createdQuizlistdataProvider.notifier);
      notifier.validateAiInputData(widget.questionData.startsWith('```json')
          ? cleanjsonString(widget.questionData)
          : widget.questionData);
    });
  }

  @override
  Widget build(BuildContext context) {
    var quizlist = ref.watch(createdQuizlistdataProvider);
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 45,
          child: ElevatedButton(
              onPressed: () {
                submitQuizDialog(context, widget.title);
              },
              child: Text(
                'Sumit',
                style:
                    AppTextStyle.mediumTitlename.copyWith(color: Colors.white),
              )),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref.watch(createdQuizlistdataProvider.notifier).clear();
        },
        child: const Icon(Icons.clear),
      ),
      appBar: AppBar(
        title: Text('${quizlist.length} questions'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
            child: Column(
          children: List.generate(
              quizlist.length,
              (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                        height: 350,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              child: Text((index + 1).toString()),
                            ),
                            Expanded(child: quizlist[index]),
                          ],
                        )),
                  )).toList(),
        )),
      ),
    );
  }

  Future<dynamic> submitQuizDialog(BuildContext context, String topic) {
    return showDialog(
        context: context,
        builder: ((context) => AlertDialog(
              title: const Text('Submit quiz'),
              actions: [
                TextButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                title: const Text('Submitting Created data'),
                                actionsAlignment: MainAxisAlignment.spaceEvenly,
                                actions: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          fixedSize: const Size(90, 30)),
                                      onPressed: () async {
                                        var quizlist = ref
                                            .watch(createdQuizlistdataProvider);
                                        Navigator.pop(context);
                                        customLoadingDialog(context);
                                        var user = ref.watch(userProvider);
                                        var quizdata = ParseObject('Quiz')
                                          ..set('author', user!.name)
                                          ..set('topic', topic)
                                          ..set(
                                              'questions',
                                              quizlist
                                                  .map((e) => e.toJson())
                                                  .toList());
                                        await quizdata.save().then((value) {
                                          Navigator.popUntil(context,
                                              (route) => route.isFirst);
                                        }).onError((error, stackTrace) {
                                          Navigator.pop(context);
                                        });
                                      },
                                      child: Text(
                                        'yes',
                                        style: TextStyle(color: AppColor.white),
                                      )),
                                  OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                          foregroundColor: Colors.red,
                                          side: const BorderSide(
                                              color: Colors.red),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          fixedSize: const Size(90, 30)),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('no')),
                                ],
                                content: const Text(
                                    'Are you sure you want to submit this quiz data'),
                              ));
                    },
                    child: const Text('Yes')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('No'))
              ],
              content: const Text('Do you want to submit your quiz'),
            )));
  }

  void customLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}

String cleanjsonString(String jsonString) {
  final pattern = RegExp(r'^`json\s*(.*?)\s*`$', dotAll: true);
  final cleanedString = pattern.firstMatch(jsonString)?.group(1) ?? jsonString;

  int last = cleanedString.characters.length;
  return cleanedString
      .trim()
      .replaceRange(0, 7, '')
      .replaceRange(last - 10, last - 7, '')
      .trim();
}
