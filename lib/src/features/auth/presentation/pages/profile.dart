import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hermione/src/core/constants/size_utils.dart';
import 'package:hermione/src/features/auth/presentation/pages/edit_profile.dart';
import 'package:hermione/src/features/auth/presentation/pages/signin_screen.dart';

import '../../../../core/widgets/widgets.dart';
import 'forget_password.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

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
            Padding(
              padding: const EdgeInsets.all(25),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Container(
                  height: 210,
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
                  child: Center(
                    child: ListView(
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Stack(
                          children: [
                            Column(
                              children: [
                                Center(
                                  child: CustomImageView(
                                    imagePath:
                                        "assets/images/img_ellipse_4.png",
                                    height: 105.adaptSize,
                                    width: 105.adaptSize,
                                  ),
                                ),
                              ],
                            ),
                            const Positioned(
                              top: 90,
                              right: 0,
                              left: 0,
                              child: Center(
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 32,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          currentUser.email!,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
              ),
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
                          Get.to(() => EditProfileScreen());
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
                      InkWell(
                        onTap: (){
                          Get.to(()=>ForgetPasswordScreen());
                        },
                        child: const ListTile(
                          leading: Icon(Icons.lock, color: Color(0xFF065774)),
                          title: Text('Change Password'),
                          trailing: Icon(Icons.arrow_forward_ios),
                        ),
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
                      const ListTile(
                        leading: Icon(Icons.delete, color: Color(0xFF065774)),
                        title: Text('Delete Account'),
                        trailing: Icon(Icons.arrow_forward_ios),
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
