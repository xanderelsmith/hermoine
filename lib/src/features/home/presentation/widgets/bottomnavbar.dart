import 'package:flutter/material.dart';
import 'package:hermione/src/features/home/data/sources/homepagedatasources.dart';

import '../../../../core/constants/colors.dart';

class StyledBottomNavBar extends StatelessWidget {
  const StyledBottomNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.deepColor,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
              2,
              (index) => GestureDetector(
                    onTap: () {
                      homeIcons(context)[index].onTap();
                    },
                    child: Card(
                        color: AppColor.transparentContainer.withOpacity(0.2),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                              Image.asset(homeIcons(context)[index].imageUrl),
                        )),
                  ))),
    );
  }
}
