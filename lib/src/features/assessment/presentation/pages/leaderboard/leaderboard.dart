import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hermione/src/core/constants/constants.dart';
import 'package:hermione/src/features/assessment/presentation/widgets/minimallisttilecard.dart';
import 'package:hermione/src/features/assessment/presentation/widgets/sparkcyberspaceappbar.dart';

import '../../../../../core/constants/size_utils.dart';
import '../../../../auth/presentation/pages/helper_function.dart';

class LeaderBoardScreen extends StatelessWidget {
  const LeaderBoardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Users").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (!snapshot.hasError) {
              final users = snapshot.data!.docs;
              users.sort((a, b) => int.parse(b['xp'].isEmpty ? '0' : b['xp'])
                  .compareTo(int.parse(a['xp'].isEmpty ? '0' : a['xp'])));

              return CustomScrollView(
                // physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    title: const Text('LeaderBoard'),
                    collapsedHeight: 100,
                    expandedHeight: 180,
                    flexibleSpace: FlexibleSpaceBar(
                        stretchModes: const <StretchMode>[
                          StretchMode.blurBackground,
                          StretchMode.zoomBackground,
                          StretchMode.fadeTitle
                        ],
                        // centerTitle: false,

                        background: SparkCyberSpaceAppBar(usersList: [
                          users[0],
                          users[1],
                          users[2],
                        ])),
                  ),
                  SliverList(
                    delegate:
                        SliverChildListDelegate([OtherUserList(users: users)]),
                  )
                ],
              );
            } else {
              displayMessageToUser("something went wrong", context);
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}

class OtherUserList extends StatelessWidget {
  const OtherUserList({
    super.key,
    required this.users,
  });

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> users;

  @override
  Widget build(BuildContext context) {
    final List data = users..removeRange(0, 3);
    log(data.toString());
    return Column(
      children: [
        MinimalListTileCard(
          screensize: getScreenSize(context),
          height: 5,
          color: Colors.yellow,
          width: 100,
        ),
        Column(children: [
          ...List.generate(
              data.length,
              (index) => MinimalListTileCard(
                  color: Theme.of(context).canvasColor,
                  screensize: getScreenSize(context),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: CircleAvatar(
                            backgroundColor: const Color(0xFFD9D9D9),
                            radius: 12,
                            child: Text((index + 4).toString())),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          data[index]['username'],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/diamond.svg',
                            width: 24, // Adjust width as needed
                            height: 24, // Adjust height as needed
                          ),
                          const SizedBox(width: 4),
                          Text(
                            users[index]['xp'].isEmpty
                                ? '0'
                                : users[index]['xp'],
                            style: AppTextStyle.mediumTitlename
                                .copyWith(color: Colors.black),
                          ),
                        ],
                      )
                    ],
                  ))),
        ]),
      ],
    );
  }
}
