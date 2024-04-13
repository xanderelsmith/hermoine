import 'package:flutter/material.dart';
import 'package:hermione/src/features/home/presentation/widgets/homepage/creatorquizscreen.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/constants/size_utils.dart';
import '../../../../home/presentation/widgets/homepage/coursecategory.dart';
import '../../../data/sources/fetchcourses.dart';
import '../../../data/sources/fetchquizes.dart';

class CreatedQuizes extends StatelessWidget {
  const CreatedQuizes({
    super.key,
  });

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
              Text('Created Courses', style: AppTextStyle.titlename),
              const Text('See all'),
            ],
          ),
        ),
        SizedBox(
          height: 100,
          child: FutureBuilder<List<ParseObject>?>(
              future: QuizApiFetch.getAllquizes(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          ParseFile src = snapshot.data![index]['image'];
                          return QuizListTile(
                              screensize: getScreenSize(context),
                              onTap: (data) {},
                              quizname: snapshot.data![index]['topic'],
                              datecreated: 'datecreated',
                              username: 'username',
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
