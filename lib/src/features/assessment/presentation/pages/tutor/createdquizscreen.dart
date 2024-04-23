import 'package:flutter/material.dart';
import 'package:hermione/src/features/home/presentation/widgets/homepage/creatorassessmentslist.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/size_utils.dart';
import '../../../../analytics/presentation/pages/analytics.dart';
import '../../../../home/presentation/widgets/homepage/coursecategory.dart';
import '../../../data/sources/fetchcourses.dart';
import '../../../data/sources/fetchquizes.dart';
import 'package:async/async.dart';

class CreatedQuizes extends StatefulWidget {
  const CreatedQuizes({
    super.key,
  });

  @override
  State<CreatedQuizes> createState() => _CreatedQuizesState();
}

class _CreatedQuizesState extends State<CreatedQuizes> {
  AsyncMemoizer<List<ParseObject>?> asyncMemoizer = AsyncMemoizer();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const CreatorAssessmentScreen()));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Created Quizes', style: AppTextStyle.titlename),
              const Text('See all'),
            ],
          ),
        ),
        SizedBox(
          height: 100,
          child: FutureBuilder<List<ParseObject>?>(
              future: asyncMemoizer.runOnce(() => QuizApiFetch.getAllquizes()),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          String imageUrl = snapshot.data![index]['image'].url;
                          return QuizListTile(
                              imageurl: imageUrl,
                              screensize: getScreenSize(context),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: ((context) => Analytics(
                                                  quiz: snapshot.data![index],
                                                )
                                            // const AssessmentDetailScreen()

                                            )));
                              },
                              quizname: snapshot.data![index]['topic'],
                              datecreated: 'datecreated',
                              username: snapshot.data![index]['author'],
                              isViewed: true,
                              quizEmojis: [],
                              presentUser: 'presentUser');
                        });
              }),
        )
      ],
    );
  }
}
