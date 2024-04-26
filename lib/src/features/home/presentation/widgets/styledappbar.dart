import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../auth/data/models/user.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  CustomAppBar({super.key, this.userDetails});

  final UserDetails? userDetails;

  final currentUser = FirebaseAuth.instance.currentUser!;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Wrap the CircleAvatar with a GestureDetector
                GestureDetector(
                  onTap: () {
                    // Open the drawer on tap (assuming you have a drawer widget)
                    Scaffold.of(context).openDrawer();
                  },
                  child: const CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 150, 158, 160),
                    child: Icon(Icons.person),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Hello',
                              style: AppTextStyle.titlename
                                  .copyWith(color: Colors.white),
                            ),
                          ],
                        ),
                        // StreamBuilder<DocumentSnapshot>(
                        //     stream: FirebaseFirestore.instance
                        //         .collection('Users')
                        //         .doc(currentUser.email)
                        //         .snapshots(),
                        //     builder: (context, snapshot) {
                        //       if (!snapshot.hasData) {
                        //         return const CircularProgressIndicator(); // Display loading indicator
                        //       }
                        //
                        //       UserDetails userDetails =
                        //           UserDetails.fromFirebaseData(snapshot.data!
                        //               .data() as Map<String, dynamic>);
                        //
                        //       return Text(
                        //         userDetails.name ?? 'N/A',
                        //         style: AppTextStyle.mediumTitlename
                        //             .copyWith(color: Colors.white),
                        //       );
                        //     }),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            StreamBuilder<DocumentSnapshot>(
                                stream: FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(currentUser.email)
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) {
                                    return const CircularProgressIndicator(); // Display loading indicator
                                  }

                                  UserDetails userDetails =
                                      UserDetails.fromFirebaseData(
                                          snapshot.data!.data()
                                              as Map<String, dynamic>);

                                  return Text(
                                    userDetails.username ?? 'N/A',
                                    style: AppTextStyle.mediumTitlename
                                        .copyWith(color: Colors.white),
                                  );
                                }),
                            Icon(
                              Icons.notifications_none_outlined,
                              color: AppColor.white,
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: Text(
                    'What subject would you like to improve on today?',
                    style: AppTextStyle.tinyTitlename
                        .copyWith(color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size(200, 100);
}
