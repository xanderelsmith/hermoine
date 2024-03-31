import 'package:flutter/material.dart';
import 'package:hermione/src/core/constants/constants.dart';
import 'package:hermione/src/core/global/userdetail.dart';
import 'package:hermione/src/core/utils/screensizeutils.dart';
import '../../data/sources/homepagedatasources.dart';
import '../widgets/bottomnavbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.userDetails});
  final UserDetails userDetails;
  static String id = 'homepage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const StyledBottomNavBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                color: AppColor.transparentContainer.withOpacity(0.2),
                child: SizedBox(
                  height: 200,
                  width: getScreenSize(context).width - 100,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Hi ${userDetails.user.username!}',
                                style: AppTextStyle.titlename,
                              ),
                              const Text(
                                  'Let\'s automate your wards assessment '),
                            ],
                          ),
                        ),
                        const Card(
                          child: SizedBox(
                            height: 100,
                            width: 100,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const Text('Scheduled Assessment'),
              SizedBox(
                height: getScreenSize(context).height / 2.1,
                child: ListView.builder(
                  // addAutomaticKeepAlives: true,
                  cacheExtent: BorderSide.strokeAlignOutside,
                  itemCount: 10,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      tileColor: AppColor.transparentContainer.withOpacity(0.2),
                      leading: const CircleAvatar(),
                      subtitle: const Text('Mrs johny'),
                      onTap: () {},
                      title: const Text('Physics, Chemistry'),
                      trailing: const Text('40 mins ago'),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
