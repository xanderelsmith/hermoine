import 'package:flutter/material.dart';
import 'package:hermione/src/core/constants/text_style.dart';

class ResultDataSubComponent extends StatelessWidget {
  const ResultDataSubComponent({
    super.key,
    required this.name,
    required this.value,
    required this.tagcolor,
  });
  final String name;
  final String value;
  final Color tagcolor;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: tagcolor,
          radius: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                value,
                style: AppTextStyle.titlename.copyWith(color: tagcolor),
              ),
              Text(name),
            ],
          ),
        ),
      ],
    );
  }
}
