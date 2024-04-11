// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
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
  home(Icons.home, 'Home'),
  courses(Icons.book, 'Courses'),
  ranking(Icons.star, 'Ranking'),
  profile(Icons.person, 'Profile');

  final String name;
  final IconData data;
  const BottomNavItem(this.data, this.name);
}
