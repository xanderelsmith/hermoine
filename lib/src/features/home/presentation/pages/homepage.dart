// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:hermione/src/core/constants/colors.dart';

import 'package:hermione/src/core/constants/size_utils.dart';

import 'package:hermione/src/features/auth/data/models/user.dart';

import '../widgets/homepage/coursecategory.dart';
import '../widgets/homepage/courseslist.dart';
import '../widgets/styledappbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
    this.userDetails,
  });
  final UserDetails? userDetails;
  static String id = 'homepage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
          height: 50,
          color: AppColor.primaryColor,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(BottomNavItem.values.length,
                  (index) => Image.asset(BottomNavItem.values[index].data)),
            ),
          )),
      appBar: CustomAppBar(userDetails: widget.userDetails),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [HomePageCourseCategory(), Courses()],
        ),
      ),
    );
  }
}

int _selectedIndex = 0;
double _fabPosition = 0.0;

// Models
enum BottomNavItem {
  home('assets/icons/home.png', 'Home'),
  courses('assets/icons/course.png', 'Courses'),
  ranking('assets/icons/ranking.png', 'Ranking'),
  profile('assets/icons/profile.png', 'Profile');

  final String name;
  final String data;
  const BottomNavItem(this.data, this.name);
}
