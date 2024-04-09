import 'package:flutter/material.dart';
import 'package:hermione/src/core/constants/size_utils.dart';
import 'package:hermione/src/core/global/userdetail.dart';
import '../widgets/homepage/coursecategory.dart';
import '../widgets/homepage/courseslist.dart';
import '../widgets/styledappbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, this.userDetails});
  final UserDetails? userDetails;
  static String id = 'homepage';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [HomePageCourseCategory(), Courses()],
        ),
      ),
    );
  }
}
