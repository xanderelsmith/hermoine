import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hermione/src/features/auth/presentation/pages/edit_profile.dart';
import 'package:hermione/src/features/auth/presentation/pages/forget_password.dart';
import 'package:hermione/src/features/auth/presentation/pages/profile_image.dart';
import 'package:hermione/src/features/auth/presentation/pages/signin_screen.dart';

import 'create_account_screen.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios)),
          title: const Center(
              child: Text(
            "Profile",
          )),
        ),
        body: Column(
          children: [
            const ProfileImage(
              isEditMode: false,
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 410,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6),
                        offset: const Offset(5, 5), // Right and bottom shadow
                        blurRadius: 6,
                        spreadRadius: 4,
                      ),
                      const BoxShadow(
                        color:
                            Colors.black, // Left and top shadow (transparent)
                        offset: Offset(-5, -5),
                        blurRadius: 6,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: ListView(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.to(() => const EditProfileScreen());
                        },
                        child: const ListTile(
                          leading: Icon(Icons.person, color: Color(0xFF065774)),
                          title: Text('Edit  Profile'),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                      Container(
                        height: 0.5,
                        color: Colors.black,
                        width: double.maxFinite,
                      ),
                      ListTile(
                        leading:
                            const Icon(Icons.lock, color: Color(0xFF065774)),
                        title: InkWell(
                            onTap: () {
                              Get.to(() => ForgetPasswordScreen());
                            },
                            child: const Text('Change Password')),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                      Container(
                        height: 0.3,
                        color: Colors.black,
                        width: double.maxFinite,
                      ),
                      const ListTile(
                        leading: Icon(Icons.info, color: Color(0xFF065774)),
                        title: Text('About App'),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      Container(
                        height: 0.5,
                        color: Colors.black,
                        width: double.maxFinite,
                      ),
                      ListTile(
                        leading:
                            const Icon(Icons.delete, color: Color(0xFF065774)),
                        title: InkWell(
                            onTap: () {
                              deleteUserAccount();
                            },
                            child: const Text('Delete Account')),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                      Container(
                        height: 0.3,
                        color: Colors.black,
                        width: double.maxFinite,
                      ),
                      ListTile(
                        leading:
                            const Icon(Icons.logout, color: Color(0xFF065774)),
                        title: InkWell(
                          onTap: () {
                            logout();
                          },
                          child: const Text('Log out'),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                      ),
                      Container(
                        height: 0.5,
                        color: Colors.black,
                        width: double.maxFinite,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
