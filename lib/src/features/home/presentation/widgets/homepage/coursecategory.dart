import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hermione/src/features/assessment/data/sources/fetchcourses.dart';
import 'package:hermione/src/features/home/presentation/widgets/homepage/allcoursescategoriesListscreen.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

import '../../../../../core/constants/constants.dart';

class HomePageCourseCategory extends StatelessWidget {
  const HomePageCourseCategory({
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
                    builder: (context) =>
                        const AllCourseCategoriesListScreen()));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Course Category', style: AppTextStyle.titlename),
              const Text('See all'),
            ],
          ),
        ),
        SizedBox(
          height: 100,
          child: FutureBuilder<List<ParseObject>?>(
              future: CoursesApiFetch.getAllCoursesCategory(),
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
                          return SizedBox(
                            height: 100,
                            width: 100,
                            child: Card(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: CircleAvatar(
                                      child:
                                          src.url != null && src.url!.isNotEmpty
                                              ? Image.network(src.url ?? "")
                                              : null,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(snapshot.data![index]['name']),
                                  )
                                ],
                              ),
                            ),
                          );
                        });
              }),
        )
      ],
    );
  }
}
