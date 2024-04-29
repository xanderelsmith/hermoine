import 'dart:convert';
import 'dart:developer';

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';
import '../../data/models/user.dart';

class ProfileImage extends StatefulWidget {
  final bool isEditMode;
  const ProfileImage({super.key, this.isEditMode = true, this.userDetails});
  final UserDetails? userDetails;

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  Uint8List? pickedImage;

  @override
  void initState() {
    super.initState();
    // Load saved image from local storage on initialization
    loadSavedImage();
  }

  loadSavedImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imageString = prefs.getString('profile_image');
    if (imageString != null) {
      List<int> imageBytes = base64Decode(imageString);
      setState(() {
        pickedImage = Uint8List.fromList(imageBytes);
      });
    }
  }

  pickImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print("No Image Selected");
  }

  void selectedImage() async {
    Uint8List? img = await pickImage(ImageSource.gallery);
    if (img != null) {
      // Save picked image to local storage
      saveImageToLocal(img);
    }
  }

  saveImageToLocal(Uint8List imageBytes) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String imageString = base64Encode(imageBytes);
    prefs.setString('profile_image', imageString);
    setState(() {
      pickedImage = imageBytes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
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
          child: ListView(
            children: [
              const SizedBox(
                height: 5,
              ),
              Stack(
                children: [
                  Center(
                    child: Column(
                      children: [
                        pickedImage != null
                            ? CircleAvatar(
                                radius: 64,
                                backgroundImage: MemoryImage(pickedImage!),
                              )
                            : const CircleAvatar(
                                radius: 64,
                                backgroundImage: AssetImage(
                                    "assets/images/img_ellipse_4.png"),
                              ),
                      ],
                    ),
                  ),
                  if (widget.isEditMode)
                    Positioned(
                      bottom: -10,
                      left: 220,
                      child: IconButton(
                        icon: const Icon(Icons.add_a_photo),
                        color: Colors.black,
                        onPressed: selectedImage,
                      ),
                    ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                currentUser.email!,
                textAlign: TextAlign.center,
              ),
              StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('Users')
                      .doc(currentUser.email)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Center(
                          child:
                              CircularProgressIndicator()); // Display loading indicator
                    } else if (snapshot.data != null) {
                      return const Center(child: Text('No data'));
                    } else if (snapshot.data!.data() != null) {
                      log(snapshot.data!.data().toString());
                      UserDetails userDetails = UserDetails.fromFirebaseData(
                          snapshot.data!.data() as Map<String, dynamic>);

                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/diamond.svg',
                            width: 24, // Adjust width as needed
                            height: 24, // Adjust height as needed
                          ),
                          const SizedBox(width: 8),
                          Text(
                            userDetails.xp ?? '0',
                            style: AppTextStyle.mediumTitlename
                                .copyWith(color: Colors.black),
                          ),
                        ],
                      );
                    } else {
                      return const Center(
                          child:
                              CircularProgressIndicator()); // Display loading indicator
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
