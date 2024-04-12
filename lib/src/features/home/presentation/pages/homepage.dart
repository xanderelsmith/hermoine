// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hermione/src/core/constants/colors.dart';
import 'package:hermione/src/features/auth/data/models/user.dart';
import 'package:hermione/src/features/home/presentation/widgets/homepage/allcourses.dart';
import 'package:hermione/src/features/home/presentation/widgets/homepage/allcoursescategoriesListscreen.dart';

import '../../../auth/presentation/pages/profile.dart';
import '../../../auth/presentation/pages/signin_screen.dart';
import '../widgets/customdrawer.dart';
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

// void logout() {
//   FirebaseAuth.instance.signOut();
// }
void logout() async {
  bool confirmLogout = await Get.defaultDialog(
    title: 'Confirm Logout',
    middleText: 'Are you sure you want to logout?',
    actions: [
      ElevatedButton(
        onPressed: () {
          Get.back(result: true); // Return true when confirmed
        },
        child: const Text(
          'Yes',
          style: TextStyle(color: Colors.black),
        ),
      ),
      ElevatedButton(
        onPressed: () {
          Get.back(result: false); // Return false when cancelled
        },
        child: const Text('No', style: TextStyle(color: Colors.black)),
      ),
    ],
  );

  if (confirmLogout ?? false) {
    await FirebaseAuth.instance.signOut();
    // Navigate to the login screen
    Get.offAll(const SigninScreen());
  }
}

class _HomePageState extends State<HomePage> {
  BottomNavItem page = BottomNavItem.home;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      bottomNavigationBar: Container(
          height: 50,
          color: AppColor.primaryColor,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                  BottomNavItem.values.length,
                  (index) => InkWell(
                      onTap: () {
                        setState(() {
                          page = BottomNavItem.values[index];
                        });
                      },
                      child: Image.asset(BottomNavItem.values[index].data))),
            ),
          )),
      body: homePageBuilder(page, widget.userDetails),
    );
  }
}

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({
    super.key,
    required this.userDetails,
  });
  final UserDetails userDetails;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(userDetails: userDetails),
        const Expanded(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                HomePageCourseCategory(),
                Courses(),
              ],
            ),
          ),
        )
      ],
    );
  }
}

int _selectedIndex = 0;

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

Widget homePageBuilder(page, userDetails) {
  return page == BottomNavItem.home
      ? HomeDashboardScreen(
          userDetails: userDetails!,
        )
      : page == BottomNavItem.courses
          ? const AllCoursesScreen()
          : page == BottomNavItem.ranking
              ? const LeaderBoardRankingScreen()
              : const Scaffold();
}

class LeaderBoardRankingScreen extends StatelessWidget {
  const LeaderBoardRankingScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
        centerTitle: true,
      ),
    );
  }
}
