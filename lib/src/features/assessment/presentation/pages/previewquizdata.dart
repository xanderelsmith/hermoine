import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../domain/repositories/createdquizrepo.dart';

// Assuming cleanjsonString function is defined elsewhere

class PreviewQuestionsPage extends ConsumerStatefulWidget {
  const PreviewQuestionsPage({
    super.key,
    required this.questionData,
  });

  final String questionData;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _PreviewQuestionsPagerState();
}

class _PreviewQuestionsPagerState extends ConsumerState<PreviewQuestionsPage> {
  String _cleanedQuestionData = '';

  @override
  void didUpdateWidget(covariant PreviewQuestionsPage oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Update internal state with cleaned data
    _cleanedQuestionData = cleanjsonString(widget.questionData);
  }

  @override
  void initState() {
    super.initState();

    // Use a future or function outside widget lifecycle methods
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final notifier = ref.read(createdQuizlistdataProvider.notifier);
      await notifier.validateAiInputData(widget.questionData);
    });
  }

  @override
  Widget build(BuildContext context) {
    var quizlist = ref.watch(createdQuizlistdataProvider);
    log(quizlist.length.toString());
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(onPressed: () {}, child: const Text('Sumit')),
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
