import 'package:flutter/material.dart';
import 'package:hermione/src/core/utils/screensizeutils.dart';
import 'package:hermione/src/features/assessment/data/sources/fetchquizes.dart';
import 'package:hermione/src/features/assessment/presentation/pages/createquizscreen.dart';
import 'package:hermione/src/features/home/presentation/widgets/homepage/coursecategory.dart';
import 'package:hermione/src/features/home/presentation/widgets/homepage/courseslist.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

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
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SpecialTextfield(
                        borderRadius: BorderRadius.circular(20),
                        prefixwidget: const Icon(Icons.search),
                      ),
                      SizedBox(
                        height: 50,
                        child: FutureBuilder<List<ParseObject>?>(
                            future: CoursesApiFetch.getAllCourses(),
                            builder: (context, snapshot) {
                              return !snapshot.hasData
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : Builder(builder: (context) {
                                      return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: ((context, index) {
                                            ParseObject course =
                                                snapshot.data![index];
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
                                              child: Chip(
                                                  label: Text(course['name'])),
                                            );
                                          }));
                                    });
                            }),
                      ),
                      Expanded(
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
                                          ParseFile src =
                                              snapshot.data![index]['image'];
                                          return QuizListTile(
                                              imageurl: src.url ?? '',
                                              screensize:
                                                  getScreenSize(context),
                                              onTap: (data) {},
                                              quizname: snapshot.data![index]
                                                  ['topic'],
                                              datecreated: 'datecreated',
                                              username: snapshot.data![index]
                                                  ['author'],
                                              isViewed: true,
                                              quizEmojis: [],
                                              presentUser: 'presentUser');
                                        });
                              }),
                        ),
                      )
                    ]))));
  }
}
