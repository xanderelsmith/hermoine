import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
                        MinimalListTileCard(
                            color: AppColor.primaryColor,
                            screensize: getScreenSize(context),
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text((46).toString()),
                                ),
                                const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 8.0),
                                  child: CircleAvatar(),
                                ),
                                const Text('Tunde (you)')
                              ],
                            )),
                        ...List.generate(
                            users.length,
                            (index) => MinimalListTileCard(
                                color: Theme.of(context).canvasColor,
                                screensize: getScreenSize(context),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 8.0),
                                      child: Text((index + 4).toString()),
                                    ),
                                    const Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 8.0),
                                      child: CircleAvatar(),
                                    ),
                                    Text(users[index]['username'])
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
