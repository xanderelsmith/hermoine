// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:hermione/src/core/constants/colors.dart';
import 'package:hermione/src/features/assessment/presentation/pages/leaderboard/leaderboard.dart';
import 'package:hermione/src/features/auth/data/models/user.dart';
import 'package:hermione/src/features/home/domain/repositories/currentuserrepository.dart';
import 'package:hermione/src/features/home/presentation/widgets/homepage/allcourses.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../assessment/presentation/pages/tutor/createdquizscreen.dart';
import '../../../auth/presentation/pages/auth.dart';
import '../../../auth/presentation/pages/create_account_screen.dart';
import '../../../auth/presentation/pages/signin_screen.dart';
import '../widgets/customdrawer.dart';
import '../widgets/homepage/coursecategory.dart';
import '../widgets/homepage/courseslist.dart';
import '../widgets/styledappbar.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({
    super.key,
    this.userDetails,
  });
  final UserDetails? userDetails;
  static String id = 'homepage';

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  UserDetails? newUser;
  @override
  void initState() {
    newUser = widget.userDetails;
    super.initState();
    fetchUserDetails(FirebaseAuth.instance.currentUser?.email).then((value) {
      ref.watch(userProvider.notifier).assignUserData(value!);
      log(value.name.toString());
      setState(() {
        newUser = value;
      });
    }).onError((error, stackTrace) {
      ref.watch(userProvider.notifier).assignUserData(widget.userDetails!);
      log(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(
        currentUser: newUser!,
      ),
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
                          _page = BottomNavItem.values[index];
                        });
                      },
                      child: Image.asset(BottomNavItem.values[index].data))),
            ),
          )),
      body: HomePageBuilder(page: _page, userDetails: newUser!),
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
                CreatedQuizes(),
                // userDetails.isTutor == true
                //     ? const CreatedQuizes()
                //     : const SizedBox(),
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
  ranking('assets/icons/ranking.png', 'Ranking');

  final String name;
  final String data;
  const BottomNavItem(this.data, this.name);
}

class HomePageBuilder extends StatelessWidget {
  const HomePageBuilder(
      {super.key, required this.page, required this.userDetails});
  final BottomNavItem page;
  final UserDetails userDetails;
  @override
  Widget build(BuildContext context) {
    return page == BottomNavItem.home
        ? HomeDashboardScreen(
            userDetails: userDetails,
          )
        : page == BottomNavItem.courses
            ? const AllCoursesScreen()
            : const LeaderBoardScreen();
  }
}

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
          Get.back(result: true); // Return true when confirmed
        },
        child: const Text(
          'Delete',
          style: TextStyle(color: Colors.black),
        ),
      ),
      ElevatedButton(
        onPressed: () {
          Get.back(result: false); // Return false when cancelled
        },
        child:
            const Text('Keep Account', style: TextStyle(color: Colors.black)),
      ),
    ],
  );

  if (confirmDelete ?? false) {
    try {
      // Delete the user account
      await FirebaseAuth.instance.currentUser?.delete();

      // Delete the user document from Firestore collection
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

BottomNavItem _page = BottomNavItem.home;
