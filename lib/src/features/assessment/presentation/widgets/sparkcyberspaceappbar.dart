import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hermione/src/core/constants/constants.dart';
import 'package:hermione/src/features/assessment/presentation/widgets/minimallisttilecard.dart';

class SparkCyberSpaceAppBar extends StatefulWidget
    implements PreferredSizeWidget {
  const SparkCyberSpaceAppBar({super.key});

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
                      const Text('Sean'),
                      const Text('1892 xp'),
                    ],
                  )),
        ),
      ],
    );
  }
}
