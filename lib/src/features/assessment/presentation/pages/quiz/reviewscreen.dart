import 'package:flutter/material.dart';
import 'package:hermione/src/core/constants/size_utils.dart';
import 'package:hermione/src/features/assessment/domain/repositories/retievedquizdata.dart';
import 'package:hermione/src/features/assessment/presentation/pages/quiz/mainquizscreen.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/constants/constants.dart';

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
        title: Text(
          'Quiz Review',
          style: AppTextStyle.mediumTitlename.copyWith(color: Colors.white),
        ),
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
                  : Colors.greenAccent,
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
                            child: Text(
                              (index + 1).toString(),
                              style: AppTextStyle.mediumTitlename.copyWith(
                                  color: incorrectQuizList.any((element) =>
                                          element.correctanswer ==
                                          quizquestionsList[index]
                                              .correctanswer)
                                      ? Colors.white
                                      : null),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              quizquestionsList[index].question,
                              style: AppTextStyle.mediumTitlename.copyWith(
                                  color: incorrectQuizList.any((element) =>
                                          element.correctanswer ==
                                          quizquestionsList[index]
                                              .correctanswer)
                                      ? Colors.white
                                      : null),
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
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              'Ans:',
                              style: AppTextStyle.mediumTitlename.copyWith(
                                  color: incorrectQuizList.any((element) =>
                                          element.correctanswer ==
                                          quizquestionsList[index]
                                              .correctanswer)
                                      ? Colors.white
                                      : null),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              quizquestionsList[index].correctanswer,
                              style: AppTextStyle.mediumTitlename
                                  .copyWith(fontWeight: FontWeight.bold),
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
