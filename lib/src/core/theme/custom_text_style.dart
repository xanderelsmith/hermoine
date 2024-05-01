import 'package:flutter/material.dart';
import 'package:hermione/src/core/constants/size_utils.dart';
import 'package:hermione/src/core/theme/theme.dart';

extension on TextStyle {
  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }
}

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.
class CustomTextStyles {
  // Body text style
  static get bodyMediumPrimary => theme.textTheme.bodyMedium!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get bodySmallBlack900 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black900.withOpacity(0.6),
      );
  static get bodySmallBlack90012 => theme.textTheme.bodySmall!.copyWith(
        color: appTheme.black900.withOpacity(0.54),
        fontSize: 12.fSize,
      );
  static get bodySmallOnPrimary => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );
  static get bodySmallPrimary => theme.textTheme.bodySmall!.copyWith(
        color: theme.colorScheme.primary,
        fontSize: 18.fSize,
      );
// Label text style
  static get labelLargeOnPrimary => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );
  static get labelLargePrimary => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.primary,
      );
  static get labelLargePrimaryBold => theme.textTheme.labelLarge!.copyWith(
        color: theme.colorScheme.primary,
        fontWeight: FontWeight.w700,
      );
// Title text style
  static get titleMediumOnPrimary => theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.onPrimary.withOpacity(1),
      );
  static get titleSmallBlack900 => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900.withOpacity(0.8),
        fontWeight: FontWeight.w600,
      );
  static get titleSmallBlack900Medium => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900.withOpacity(0.8),
        fontWeight: FontWeight.w500,
      );
  static get titleSmallBlack900SemiBold => theme.textTheme.titleSmall!.copyWith(
        color: appTheme.black900.withOpacity(0.64),
        fontWeight: FontWeight.w600,
      );
  static get titleSmallMedium => theme.textTheme.titleSmall!.copyWith(
        fontWeight: FontWeight.w500,
      );
  static get titleSmallPrimary => theme.textTheme.titleSmall!.copyWith(
        color: theme.colorScheme.primary,
      );
}
