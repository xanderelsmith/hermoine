import 'package:flutter/material.dart';
import 'package:hermione/src/core/constants/size_utils.dart';
import 'package:hermione/src/core/theme/theme.dart';

class AppDecoration {
  // Fill decorations
  static BoxDecoration get fillBlueGray => BoxDecoration(
        color: appTheme.blueGray100,
      );
  static BoxDecoration get fillOnPrimary => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );
  static BoxDecoration get fillPrimary => BoxDecoration(
        color: theme.colorScheme.primary,
      );
// Outline decorations
  static BoxDecoration get outlineBlack => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.25),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              0,
              6,
            ),
          )
        ],
      );
  static BoxDecoration get outlineBlack900 => BoxDecoration(
        color: theme.colorScheme.onPrimary.withOpacity(1),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.25),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              0,
              4,
            ),
          )
        ],
      );
  static BoxDecoration get outlineIndigo => BoxDecoration(
        color: theme.colorScheme.primary,
        boxShadow: [
          BoxShadow(
            color: appTheme.indigo900.withOpacity(0.25),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              0,
              6,
            ),
          )
        ],
      );
  static BoxDecoration get outlineOnPrimary => BoxDecoration(
        color: appTheme.indigo900.withOpacity(0.47),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.onPrimary.withOpacity(1),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              0,
              6,
            ),
          )
        ],
      );
  static BoxDecoration get outlineOnPrimary1 => BoxDecoration(
        color: appTheme.indigo900.withOpacity(0.25),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.onPrimary.withOpacity(1),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: const Offset(
              0,
              6,
            ),
          )
        ],
      );
}

class BorderRadiusStyle {
  // Circle borders
  static BorderRadius get circleBorder152 => BorderRadius.circular(
        152.h,
      );
  static BorderRadius get circleBorder22 => BorderRadius.circular(
        22.h,
      );
  static BorderRadius get circleBorder75 => BorderRadius.circular(
        75.h,
      );
// Custom borders
  static BorderRadius get customBorderBL10 => BorderRadius.vertical(
        bottom: Radius.circular(10.h),
      );
  static BorderRadius get customBorderBL15 => BorderRadius.vertical(
        bottom: Radius.circular(15.h),
      );
  static BorderRadius get customBorderTL15 => BorderRadius.vertical(
        top: Radius.circular(15.h),
      );
// Rounded borders
  static BorderRadius get roundedBorder10 => BorderRadius.circular(
        10.h,
      );
  static BorderRadius get roundedBorder15 => BorderRadius.circular(
        15.h,
      );
}
