import 'package:async/async.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hermione/src/core/constants/constants.dart';
import 'package:hermione/src/core/constants/size_utils.dart';
import 'package:hermione/src/core/constants/text_style.dart';
import 'package:hermione/src/core/widgets/specialtextfield.dart';
import 'package:hermione/src/features/home/presentation/widgets/homepage/allcourses.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../../assessment/data/sources/fetchcourses.dart';

class AllCourseCategoriesListScreen extends StatefulWidget {
  const AllCourseCategoriesListScreen({
    super.key,
  });

  @override
  State<AllCourseCategoriesListScreen> createState() =>
      _AllCourseCategoriesListScreenState();
}

class _AllCourseCategoriesListScreenState
    extends State<AllCourseCategoriesListScreen> {
  AsyncMemoizer<List<ParseObject>?> asyncMemoizer = AsyncMemoizer();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course Category'),
        centerTitle: true,
      ),
      body: SizedBox(
        width: getScreenSize(context).width,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<ParseObject>?>(
              future: asyncMemoizer
                  .runOnce(() => CoursesApiFetch.getAllCoursesCategory()),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : GridView.builder(
                        itemCount: snapshot.data!.length,
                        scrollDirection: Axis.vertical,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 20,
                                mainAxisExtent: 200,
                                maxCrossAxisExtent: 200),
                        itemBuilder: (context, index) {
                          ParseObject src = snapshot.data![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AllCoursesScreen(
                                            category: src['name'],
                                          )));
                            },
                            child: Card(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: CircleAvatar(
                                      radius: 30,
                                      child: src['image'].url != null &&
                                              src['image'].url.isNotEmpty
                                          ? Image.network(
                                              src['image'].url ?? "")
                                          : null,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(
                                      20.0,
                                    ),
                                    child: Text(
                                      src['name'],
                                      style: AppTextStyle.mediumTitlename
                                          .copyWith(color: Colors.black),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
              }),
        ),
      ),
    );
  }
}
