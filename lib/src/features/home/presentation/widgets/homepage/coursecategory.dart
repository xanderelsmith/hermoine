import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hermione/src/core/constants/size_utils.dart';
import 'package:hermione/src/features/assessment/data/sources/fetchcourses.dart';
import 'package:hermione/src/features/assessment/presentation/widgets/minimallisttilecard.dart';
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
          height: 90,
          child: FutureBuilder<List<ParseObject>?>(
              future: CoursesApiFetch.getAllCoursesCategory(),
              builder: (context, snapshot) {
                return !snapshot.hasData
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: ListView.builder(
                            itemCount: snapshot.data!.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              ParseFile src = snapshot.data![index]['image'];
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: SizedBox(
                                  height: 70,
                                  width: getScreenSize(context).width - 50,
                                  child: ListTile(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: const BorderSide(
                                            color: Colors.black)),
                                    style: ListTileStyle.list,
                                    leading: CircleAvatar(
                                      child:
                                          src.url != null && src.url!.isNotEmpty
                                              ? Image.network(src.url ?? "")
                                              : null,
                                      radius: 15,
                                    ),
                                    title: Text(snapshot.data![index]['name']),
                                  ),
                                ),
                              );
                            }),
                      );
              }),
        )
      ],
    );
  }
}
