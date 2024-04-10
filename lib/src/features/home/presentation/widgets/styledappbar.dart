import 'package:flutter/material.dart';

import '../../../../core/constants/constants.dart';
import '../../../auth/data/models/user.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, this.userDetails});
  final UserDetails? userDetails;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 700,
      color: AppColor.primaryColor,
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 150, 158, 160),
                  child: Icon(Icons.person),
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
                        Text(
                          userDetails!.email! ?? 'no name',
                          style: AppTextStyle.mediumTitlename
                              .copyWith(color: Colors.white),
                        ),
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
