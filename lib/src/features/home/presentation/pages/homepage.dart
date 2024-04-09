// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:hermione/src/core/constants/size_utils.dart';
import 'package:hermione/src/core/global/userdetail.dart';
import 'package:hermione/src/features/home/presentation/widgets/styledappbar.dart';

import '../widgets/homepage/coursecategory.dart';
import '../widgets/homepage/courseslist.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
    this.userDetails,
  }) : super(key: key);
  final UserDetails? userDetails;
  static String id = 'homepage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniStartDocked,
      floatingActionButton: AnimatedPositioned(
        duration: const Duration(milliseconds: 300),
        bottom: _fabPosition,
        child: FloatingActionButton(
          onPressed: () => print('FAB pressed'),
          child: Icon(BottomNavItem.values[_selectedIndex].data),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          items: List.generate(
              BottomNavItem.values.length,
              (index) => BottomNavigationBarItem(
                  icon: Icon(BottomNavItem.values[index].data),
                  label: BottomNavItem.values[index].name))),
      appBar: const CustomAppBar(),
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
