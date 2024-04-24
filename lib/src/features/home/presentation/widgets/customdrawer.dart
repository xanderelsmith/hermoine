import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hermione/src/features/auth/data/models/user.dart';
import 'package:hermione/src/features/home/presentation/widgets/homepage/coursecategory.dart';
import 'package:hermione/src/features/home/presentation/widgets/homepage/courseslist.dart';
import 'package:hermione/src/features/home/presentation/widgets/styledappbar.dart';

import '../../../assessment/presentation/pages/leaderboard/leaderboard.dart';
import '../../../auth/presentation/pages/profile.dart';
import '../../../auth/presentation/pages/profile_image.dart';
import '../pages/homepage.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
    required this.currentUser,
  });
  final UserDetails currentUser;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ProfileImage(
                isEditMode: false,
              ),
            ],
          ),
          Column(
            children: [
              InkWell(
                child: ListTile(
                  onTap: () {
                    Get.to(() => ProfileScreen());
                  },
                  leading: const Icon(Icons.person, color: Color(0xFF065774)),
                  title: const Text('Profile'),
                ),
              ),
              const ListTile(
                leading: Icon(
                  Icons.lock,
                  color: Color(0xFF065774),
                ),
                title: Text('Security'),
              ),
              const ListTile(
                leading: Icon(Icons.info, color: Color(0xFF065774)),
                title: Text('About '),
              ),
              const ListTile(
                leading: Icon(Icons.help, color: Color(0xFF065774)),
                title: Text('Help & Support'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.logout_outlined,
                      color: Color(0xFF065774)),
                  title: InkWell(
                      onTap: () {
                        logout();
                      },
                      child: const Text('Log out')),
                ),
                ListTile(
                  leading: const Icon(Icons.delete, color: Color(0xFF065774)),
                  title: InkWell(
                      onTap: () {
                        deleteUserAccount();
                      },
                      child: const Text('Delete account')),
                ),
              ],
            ),
          ),
        ],
      ),
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
          ? const Scaffold()
          : page == BottomNavItem.ranking
              ? const LeaderBoardScreen()
              : const Scaffold();
}
