import 'package:flutter/material.dart';
import 'package:hermione/src/core/global/userdetail.dart';
import 'package:hermione/src/core/utils/screensizeutils.dart';

import '../../../../core/constants/colors.dart';
import '../../data/sources/homepagedatasources.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.userDetails});
  final UserDetails userDetails;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
              2,
              (index) => Card(
                  color: AppColor.transparentContainer.withOpacity(0.2),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(homeIcons[index].imageUrl),
                  )))),
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
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text('Hi johnny'),
                              Text('Let\'s automate your wards assessment '),
                            ],
                          ),
                        ),
                        Card(
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
                  itemCount: 10,
                  itemBuilder: (context, index) => ListTile(
                    leading: const CircleAvatar(),
                    subtitle: const Text('Mrs johny'),
                    onTap: () {},
                    title: const Text('Physics, Chemistry'),
                    trailing: const Text('40 mins ago'),
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
