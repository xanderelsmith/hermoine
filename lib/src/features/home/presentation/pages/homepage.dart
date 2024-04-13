// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hermione/src/core/constants/colors.dart';
import 'package:hermione/src/core/constants/size_utils.dart';
import 'package:hermione/src/features/auth/data/models/user.dart';

import '../../../../core/widgets/widgets.dart';
import '../../../auth/presentation/pages/create_account_screen.dart';
import '../../../auth/presentation/pages/profile.dart';
import '../../../auth/presentation/pages/signin_screen.dart';
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
final currentUser = FirebaseAuth.instance.currentUser!;

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

void deleteUserAccount() async {
  bool confirmDelete = await Get.defaultDialog(
    title: 'Confirm Delete',
    middleText: 'Are you sure you want to delete your account?',
    actions: [
      ElevatedButton(
        onPressed: () {
          Get.back(result: true);
        },
        child: const Text(
          'Delete',
          style: TextStyle(color: Colors.black),
        ),
      ),
      ElevatedButton(
        onPressed: () {
          Get.back(result: false);
        },
        child:
            const Text('Keep Account', style: TextStyle(color: Colors.black)),
      ),
    ],
  );

  if (confirmDelete ?? false) {
    try {
      await FirebaseAuth.instance.currentUser?.delete();

      await FirebaseFirestore.instance
          .collection("Users")
          .doc(FirebaseAuth.instance.currentUser?.email)
          .delete();

      // Show a success dialog
      Get.dialog(
        AlertDialog(
          title: const Text('User Account Deleted'),
          content: const Text('Your account has been successfully deleted.'),
          actions: [
            TextButton(
              onPressed: () {
                Get.offAll(const CreateAccountScreen());
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      // Show an error dialog if account deletion fails
      Get.dialog(
        AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to delete account: $e'),
          actions: [
            TextButton(
              onPressed: () {
                Get.back(); // Close the dialog
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
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

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: CustomImageView(
                    imagePath: "assets/images/img_ellipse_4.png",
                    height: 105.adaptSize,
                    width: 105.adaptSize,
                  ),
                ),
                Text('name'),
                Text(
                  currentUser.email!,
                  textAlign: TextAlign.center,
                )
              ],
            ),
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
                InkWell(
                  onTap: () {
                    deleteUserAccount();
                  },
                  child: const ListTile(
                    leading: Icon(Icons.delete, color: Color(0xFF065774)),
                    title: Text('Delete account'),
                  ),
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
