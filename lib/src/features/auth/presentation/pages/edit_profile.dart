import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hermione/src/core/constants/size_utils.dart';
import 'package:hermione/src/features/auth/presentation/pages/profile_image.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/theme/custom_text_style.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print("No Image Selected");
  }

  void selectedImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  Uint8List? _image;

  void updateUserDocument(
    String email,
  ) async {
    try {
      await FirebaseFirestore.instance.collection("Users").doc(email).update({
        'username': usernameController.text,
        'birthday': birthdayController.text,
        'gender': genderController.text,
        'bio': bioController.text,
        'name': nameController.text,
      });

      Get.dialog(
        AlertDialog(
          title: const Text('Success'),
          content: const Text('Your profile has been updated successfully.'),
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
    } catch (e) {
      print('Error updating user document: $e');
      Get.dialog(
        AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to update profile: $e'),
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

  TextEditingController usernameController = TextEditingController();

  TextEditingController birthdayController = TextEditingController();

  TextEditingController genderController = TextEditingController();

  TextEditingController bioController = TextEditingController();

  TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    birthdayController.dispose();
    bioController.dispose();
    nameController.dispose();
    genderController.dispose();
    super.dispose();
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
          "Edit Profile",
        )),
      ),
      body: Column(
        children: [
          const ProfileImage(),
          Padding(
            padding: const EdgeInsets.all(25),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 310,
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
                              controller: nameController,
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
                              controller: birthdayController,
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
                              controller: genderController,
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
                              controller: bioController,
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
          ),
          // Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomElevatedButton(
                onPressed: () {
                  updateUserDocument(currentUser.email!);
                },
                text: "Save",
                buttonTextStyle: CustomTextStyles.titleMediumOnPrimary),
          )
        ],
      ),
    ));
  }
}
