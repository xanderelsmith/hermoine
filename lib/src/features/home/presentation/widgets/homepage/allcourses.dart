// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import 'package:hermione/src/core/utils/screensizeutils.dart';
import 'package:hermione/src/features/assessment/data/sources/fetchquizes.dart';
import 'package:hermione/src/features/home/presentation/widgets/homepage/courseslist.dart';

import '../../../../../core/widgets/specialtextfield.dart';
import '../../../../assessment/data/sources/fetchcourses.dart';

class AllCoursesScreen extends StatefulWidget {
  const AllCoursesScreen({
    Key? key,
    this.category,
  }) : super(key: key);
  final String? category;

  @override
  State<AllCoursesScreen> createState() => _AllCoursesScreenState();
}

class _AllCoursesScreenState extends State<AllCoursesScreen> {
  TextEditingController? textEditingController;

  @override
  void initState() {
    textEditingController = TextEditingController(text: widget.category);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Courses'),
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
                        controller: textEditingController,
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
                                    : GridView.builder(
                                        itemCount: snapshot.data!.length,
                                        scrollDirection: Axis.horizontal,
                                        gridDelegate:
                                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                                crossAxisSpacing: 10,
                                                mainAxisSpacing: 20,
                                                mainAxisExtent: 200,
                                                maxCrossAxisExtent: 200),
                                        itemBuilder: (context, index) {
                                          var parseObject =
                                              snapshot.data![index];
                                          return QuizContainer(
                                              parseObject: parseObject);
                                        },
                                      );
                              }),
                        ),
                      )
                    ]))));
  }
}
