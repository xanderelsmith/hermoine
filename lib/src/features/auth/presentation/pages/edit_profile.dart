import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hermione/src/core/constants/size_utils.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({super.key});

  final currentUser = FirebaseAuth.instance.currentUser!;

  TextEditingController usernameController = TextEditingController();

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
          "Edit Profile",
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
                      color: Colors.black, // Left and top shadow (transparent)
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
                                  imagePath: "assets/images/img_ellipse_4.png",
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
                      color: Colors.black, // Left and top shadow (transparent)
                      offset: Offset(-5, -5),
                      blurRadius: 6,
                      spreadRadius: 4,
                    ),
                  ],
                ),
                child: ListView(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Name",
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                            SizedBox(height: 5.v),
                            CustomTextFormField(
                              controller: usernameController,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.visiblePassword,
                              obscureText: false,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 4.h),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Birthday",
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                            SizedBox(height: 5.v),
                            CustomTextFormField(
                              controller: usernameController,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.visiblePassword,
                              obscureText: false,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 4.h),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Gender",
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                            SizedBox(height: 5.v),
                            CustomTextFormField(
                              controller: usernameController,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.visiblePassword,
                              obscureText: false,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 4.h),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                "Bio",
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                            SizedBox(height: 5.v),
                            CustomTextFormField(
                              controller: usernameController,
                              textInputAction: TextInputAction.done,
                              textInputType: TextInputType.visiblePassword,
                              obscureText: false,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 4.h),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    ));
  }
}
