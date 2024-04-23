import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../auth/data/models/user.dart';
import '../pages/homepage.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.userDetails});
  final UserDetails? userDetails;

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
                        Text(
                          'Hello',
                          style: AppTextStyle.titlename
                              .copyWith(color: Colors.white),
                        ),
                        // Text(
                        //   userDetails?.name ?? 'no name',
                        //   style: AppTextStyle.mediumTitlename
                        //       .copyWith(color: Colors.white),
                        // ),
                        Text(
                          userDetails!.email,
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ),
                Icon(
                  Icons.notifications_none_outlined,
                  color: AppColor.white,
                )
              ],
            ),
            Text(
              'What subject would you like to improve on today?',
              style: AppTextStyle.tinyTitlename.copyWith(color: Colors.white),
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
