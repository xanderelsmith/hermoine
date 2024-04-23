import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hermione/src/core/constants/constants.dart';
import 'package:hermione/src/core/utils/screensizeutils.dart';
import 'package:hermione/src/features/analytics/presentation/pages/analytics.dart';
import 'package:hermione/src/features/assessment/data/sources/fetchquizes.dart';
import 'package:hermione/src/features/assessment/presentation/pages/createquizscreen.dart';
import 'package:hermione/src/features/home/presentation/widgets/homepage/coursecategory.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../core/widgets/specialtextfield.dart';
import '../../../../assessment/data/sources/fetchcourses.dart';

class CreatorAssessmentScreen extends StatelessWidget {
  const CreatorAssessmentScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateQuizScreen()));
            },
            child: const Icon(
              Icons.create_outlined,
              color: Colors.white,
            )),
        appBar: AppBar(
          title: const Text('Scheduled Assessments'),
          centerTitle: true,
        ),
        body: SizedBox(
            width: getScreenSize(context).width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FutureBuilder<List<ParseObject>?>(
                  future: QuizApiFetch.getAllquizes(),
                  builder: (context, snapshot) {
                    return !snapshot.hasData
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ListView.builder(
                            itemCount: snapshot.data!.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              ParseFile src = snapshot.data![index]['image'];
                              return QuizListTile(
                                  imageurl: src.url ?? '',
                                  screensize: getScreenSize(context),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) => Analytics(
                                                      quiz:
                                                          snapshot.data![index],
                                                    )
                                                // const AssessmentDetailScreen()

                                                )));
                                  },
                                  quizname: snapshot.data![index]['topic'],
                                  datecreated: 'datecreated',
                                  username: snapshot.data![index]['author'],
                                  isViewed: true,
                                  quizEmojis: const [],
                                  presentUser: 'presentUser');
                            });
                  }),
            )));
  }
}
