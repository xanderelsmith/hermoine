import 'dart:convert';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileImage extends StatefulWidget {
  final bool isEditMode;
  const ProfileImage({super.key, this.isEditMode = true});

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
                height: 25,
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
                height: 10,
              ),
              Text(
                currentUser.email!,
                textAlign: TextAlign.center,
              ),
              // Text(
              //   currentUser.email!,
              //   textAlign: TextAlign.center,
              // )
            ],
          ),
        ),
      ),
    );
  }
}
