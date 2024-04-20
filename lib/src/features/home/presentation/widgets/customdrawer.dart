import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../auth/presentation/pages/profile.dart';
import '../pages/homepage.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircleAvatar(),
                Text('name'),
                Text('email'),
              ],
            ),
          ),
          Column(
            children: [
              InkWell(
                child: ListTile(
                  onTap: () {
                    Get.to(() => ProfileScreen());
                  },
                  leading: const Icon(Icons.person, color: Color(0xFF065774)),
                  title: const Text('Profile'),
                ),
              ),
              const ListTile(
                leading: Icon(
                  Icons.lock,
                  color: Color(0xFF065774),
                ),
                title: Text('Security'),
              ),
              const ListTile(
                leading: Icon(Icons.info, color: Color(0xFF065774)),
                title: Text('About '),
              ),
              const ListTile(
                leading: Icon(Icons.help, color: Color(0xFF065774)),
                title: Text('Help & Support'),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 25),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.logout_outlined,
                      color: Color(0xFF065774)),
                  title: InkWell(
                      onTap: () {
                        logout();
                      },
                      child: const Text('Log out')),
                ),
                const ListTile(
                  leading: Icon(Icons.delete, color: Color(0xFF065774)),
                  title: Text('Delete account'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
