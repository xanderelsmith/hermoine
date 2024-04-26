import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
    return StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            displayMessageToUser("something went wrong", context);
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData == null) {
            return const Text("No data");
          }
          final users = snapshot.data!.docs;
          return CustomScrollView(
            // physics: const BouncingScrollPhysics(),
            slivers: [
              const SliverAppBar(
                collapsedHeight: 100,
                expandedHeight: 180,
                flexibleSpace: FlexibleSpaceBar(
                    stretchModes: <StretchMode>[
                      StretchMode.blurBackground,
                      StretchMode.zoomBackground,
                      StretchMode.fadeTitle
                    ],
                    // centerTitle: false,

                    background: SparkCyberSpaceAppBar()),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Column(
                    children: [
                      MinimalListTileCard(
                        screensize: getScreenSize(context),
                        height: 5,
                        color: Colors.yellow,
                        width: 100,
                      ),
                      Column(children: [
                        ...List.generate(
                            users.length,
                            (index) => MinimalListTileCard(
                                color: Theme.of(context).canvasColor,
                                screensize: getScreenSize(context),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: CircleAvatar(
                                          backgroundColor:
                                              const Color(0xFFD9D9D9),
                                          radius: 12,
                                          child: Text((index + 4).toString())),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: CircleAvatar(),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    SizedBox(
                                        width: 250,
                                        child: Text(
                                          users[index]['username'],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        )),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/diamond.svg',
                                          width: 24, // Adjust width as needed
                                          height: 24, // Adjust height as needed
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          users[index]['xp'],
                                          style: AppTextStyle.mediumTitlename
                                              .copyWith(color: Colors.black),
                                        ),
                                      ],
                                    )
                                  ],
                                ))),
                      ]),
                    ],
                  )
                ]),
              )
            ],
          );
        });
  }
}
