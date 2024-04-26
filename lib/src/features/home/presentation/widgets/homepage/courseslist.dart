import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hermione/src/features/assessment/domain/repositories/createdquizrepo.dart';
import 'package:hermione/src/features/assessment/presentation/pages/quiz/quizintroscreen.dart';
import 'package:hermione/src/features/home/presentation/widgets/homepage/allcourses.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/size_utils.dart';
import '../../../../../core/widgets/specialtextfield.dart';
import '../../../../assessment/data/sources/fetchcourses.dart';
import '../../../../assessment/data/sources/fetchquizes.dart';
import '../../../../assessment/domain/repositories/retievedquizdata.dart';

class Courses extends StatefulWidget {
  const Courses({
    super.key,
  });

  @override
  State<Courses> createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AllCoursesScreen()))
                      .then((value) => setState(() {}));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Courses ',
                      style: AppTextStyle.titlename,
                    ),
                    const Text('See more'),
                  ],
                ),
              )),
          Expanded(
            child: FutureBuilder<List<ParseObject>?>(
                future: QuizApiFetch.getAllquizes(),
                builder: (context, snapshot) {
                  return !snapshot.hasData && snapshot.data != null
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : GridView.builder(
                          itemCount:
                              snapshot.data == null ? 0 : snapshot.data!.length,
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 20,
                                  mainAxisExtent: 150,
                                  maxCrossAxisExtent: 180),
                          itemBuilder: (context, index) {
                            var parseObject = snapshot.data![index];
                            return QuizContainer(parseObject: parseObject);
                          },
                        );
                }),
          ),
        ],
      ),
    );
  }
}

class QuizContainer extends ConsumerWidget {
  const QuizContainer({
    super.key,
    required this.parseObject,
  });

  final ParseObject parseObject;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var coursename = parseObject['coursename'];
    return GestureDetector(
      onTap: () {
        ref.watch(quizListProvider)
          ..inputData(parseObject)
          ..addQuizData(parseObject);
        log('hi');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QuizIntroScreen(quizdata: parseObject)));
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        height: 200,
        width: 200,
        child: Column(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            parseObject['image'].url,
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10))))),
            SizedBox(
                child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(parseObject['topic'], style: AppTextStyle.titlename),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${parseObject['questions'].length} questions'),
                  Text(
                    coursename != null ? coursename['name'] : "...",
                  ),
                  const Icon(
                    Icons.timelapse_rounded,
                    size: 15,
                  )
                ],
              ),
            ])),
          ],
        ),
      ),
    );
  }
}
