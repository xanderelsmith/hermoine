import 'package:flutter/material.dart';

class MinimalListTileCard extends StatelessWidget {
  const MinimalListTileCard({
    super.key,
    required this.screensize,
    this.height,
    this.color,
    this.child,
    this.width,
    this.decoration,
    this.isOutline,
  });
  final double? height;
  final double? width;
  final Color? color;
  final Size screensize;
  final Widget? child;
  final bool? isOutline;
  final BoxDecoration? decoration;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 5,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: decoration ??
          BoxDecoration(
            border: isOutline == null
                ? null
                : Border.all(
                    width: 2,
                  ),
            borderRadius: BorderRadius.circular(10),
            color: color,
          ),
      height: height ?? 50,
      width: width ?? screensize.width,
      child: child,
    );
  }
}
