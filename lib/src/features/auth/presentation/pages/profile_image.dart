import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImage extends StatefulWidget {
  const ProfileImage({super.key});

  @override
  State<ProfileImage> createState() => _ProfileImageState();
}

class _ProfileImageState extends State<ProfileImage> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  Uint8List? pickedImage;

  void pickUploadImage() async {
    final image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxHeight: 512,
        maxWidth: 512,
        imageQuality: 75);
    if (image == null) return;

    Reference ref = FirebaseStorage.instance.ref().child("profilepic.jpg");
    // final imageRef = storageRef.child("user_${currentUser.uid}.jpg");
    await ref.putFile(File(image.path));
    ref.getDownloadURL().then((value) {
      print(value);
    });
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
    setState(() {
      pickedImage = img;
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
                  Positioned(
                    bottom: -10,
                    left: 220,
                    child: IconButton(
                      icon: const Icon(Icons.add_a_photo),
                      color: Colors.black,
                      onPressed: pickUploadImage,
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
