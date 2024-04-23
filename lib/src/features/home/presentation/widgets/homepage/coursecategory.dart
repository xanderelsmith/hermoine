import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hermione/src/core/constants/size_utils.dart';
import 'package:hermione/src/features/assessment/data/sources/fetchcourses.dart';
import 'package:hermione/src/features/home/presentation/widgets/homepage/allcourses.dart';
import 'package:hermione/src/features/home/presentation/widgets/homepage/allcoursescategoriesListscreen.dart';
import 'package:hermione/src/features/home/presentation/widgets/homepage/creatorassessmentslist.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => AllCoursesScreen(
                                              category: snapshot.data![index]
                                                  ['name'],
                                            )));
                              },
                              child: Card(
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: CircleAvatar(
                                        child: src.url != null &&
                                                src.url!.isNotEmpty
                                            ? Image.network(src.url ?? "")
                                            : null,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child:
                                          Text(snapshot.data![index]['name']),
                                    )
                                  ],
                                ),
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

class QuizListTile extends ConsumerStatefulWidget {
  final String presentUser;
  final String quizname;

  final String datecreated;
  final String username;
  final bool isViewed;

  ///is default to true, so you can set it to false, basically allows you to see options in a quiz like 'delete', 'modify' etc
  final bool? hasOption;
  final List quizEmojis;
  const QuizListTile(
      {super.key,
      required this.screensize,
      this.hasOption,
      this.widthPadding,
      required this.onTap,
      this.onLongPress,
      this.canBeLiveEdited,
      required this.quizname,
      required this.datecreated,
      required this.username,
      required this.isViewed,
      required this.quizEmojis,
      required this.presentUser,
      required this.imageurl});
  final String imageurl;

  ///the amount of spacing from the side
  final int? widthPadding;
  final Size screensize;
  final bool? canBeLiveEdited;
  final VoidCallback onTap;
  final Function(ParseObject data)? onLongPress;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuizListTileState();
}

class _QuizListTileState extends ConsumerState<QuizListTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColor.primaryColor)),
          height: 60,
          width: widget.screensize.width - 50,
          child: InkWell(
            enableFeedback: true,
            onTap: () {
              widget.onTap();
            },
            onLongPress: () {},
            child: Row(children: [
              Expanded(
                  child: CircleAvatar(
                child: Image.network(widget.imageurl),
              )),
              Expanded(
                flex: 4,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.quizname,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.mediumTitlename,
                      ),
                      Text(widget.username),
                    ]),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
