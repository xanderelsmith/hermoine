import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hermione/src/core/constants/constants.dart';
import 'package:hermione/src/features/assessment/presentation/widgets/minimallisttilecard.dart';

class SparkCyberSpaceAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  const SparkCyberSpaceAppBar({super.key, required this.usersList});
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> usersList;
  @override
  State<SparkCyberSpaceAppBar> createState() => _SparkCyberSpaceAppBarState();
  @override
  Size get preferredSize => const Size(200, 200);
}

class _SparkCyberSpaceAppBarState extends State<SparkCyberSpaceAppBar>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Size screensize = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
              3,
              (index) => Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 3,
                              color: index == 2
                                  ? Colors.blueAccent
                                  : index == 0
                                      ? Colors.yellow
                                      : Colors.red,
                            )),
                        height: index == 0
                            ? 60
                            : index == 1
                                ? 80
                                : 50,
                        width: index == 0
                            ? 60
                            : index == 1
                                ? 80
                                : 50,
                      ),
                      Text(index == 1
                          ? widget.usersList[0]['username']
                          : index == 0
                              ? widget.usersList[1]['username']
                              : widget.usersList[2]['username']),
                      Text(index == 1
                          ? widget.usersList[0]['xp']
                          : index == 0
                              ? widget.usersList[1]['xp']
                              : widget.usersList[2]['xp']),
                    ],
                  )),
        ),
      ],
    );
  }
}
