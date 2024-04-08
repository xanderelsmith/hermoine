import 'package:flutter/material.dart';
import 'package:hermione/src/core/constants/size_utils.dart';

import '../../../../core/constants/image_constant.dart';
import '../../../../core/theme/app_decoration.dart';
import '../../../../core/theme/custom_text_style.dart';
import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/widgets.dart';
// ignore_for_file: must_be_immutable

// ignore_for_file: must_be_immutable
class HomepageScreen extends StatelessWidget {
  HomepageScreen({super.key});

  GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary,
        appBar: _buildAppbar(context),
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            children: [
              SizedBox(height: 3.v),
              Container(
                decoration: AppDecoration.fillOnPrimary,
                child: Column(
                  children: [
                    SizedBox(height: 30.v),
                    _buildRowcoursecatego(context),
                    SizedBox(height: 8.v),
                    _buildRowvectorfive(context),
                    SizedBox(height: 19.v),
                    _buildRowcourses(context),
                    SizedBox(height: 7.v),
                    _buildRowbiology(context),
                    SizedBox(height: 30.v),
                    _buildRowdigestive(context),
                    SizedBox(height: 27.v),
                    _buildRow(context),
                    _buildRowdigestive1(context)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
      height: 74.v,
      leadingWidth: 70.h,
      leading: AppbarLeadingCircleimage(
        imagePath: ImageConstant.imgEllipse4,
        margin: EdgeInsets.only(
          left: 26.h,
          bottom: 11.v,
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(left: 16.h),
        child: Column(
          children: [
            Row(
              children: [
                Column(
                  children: [
                    AppbarSubtitleOne(
                      text: "Hello",
                      margin: EdgeInsets.only(right: 74.h),
                    ),
                    SizedBox(height: 6.v),
                    AppbarSubtitle(
                      text: "Victor Adebayo",
                    )
                  ],
                ),
                AppbarTitleImage(
                  imagePath: ImageConstant.imgNotification,
                  margin: EdgeInsets.only(
                    left: 125.h,
                    top: 2.v,
                    bottom: 11.v,
                  ),
                )
              ],
            ),
            SizedBox(height: 4.v),
            AppbarSubtitleTwo(
              text: "What subject would you like to improve on today?",
              margin: EdgeInsets.only(right: 19.h),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRowcoursecatego(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 28.v),
            child: Text(
              "Course Category",
              style: CustomTextStyles.titleSmallBlack900,
            ),
          ),
          Spacer(
            flex: 51,
          ),
          CustomImageView(
            imagePath: ImageConstant.imgVector,
            height: 18.adaptSize,
            width: 18.adaptSize,
            margin: EdgeInsets.only(top: 27.v),
          ),
          CustomImageView(
            imagePath: ImageConstant.imgVector,
            height: 18.adaptSize,
            width: 18.adaptSize,
            margin: EdgeInsets.only(
              left: 24.h,
              top: 16.v,
              bottom: 11.v,
            ),
          ),
          Spacer(
            flex: 48,
          ),
          Padding(
            padding: EdgeInsets.only(top: 30.v),
            child: Text(
              "See all",
              style: CustomTextStyles.labelLargePrimaryBold,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowvectorfive(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: _buildColumnvector(
              context,
              vectorSeven: ImageConstant.imgVectorOnprimary,
              business: "Science",
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 18.h),
            padding: EdgeInsets.symmetric(
              horizontal: 16.h,
              vertical: 9.v,
            ),
            decoration: AppDecoration.outlineOnPrimary.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 3.v),
                CustomImageView(
                  imagePath: ImageConstant.imgGroup8,
                  height: 31.adaptSize,
                  width: 31.adaptSize,
                ),
                SizedBox(height: 9.v),
                Text(
                  "Art",
                  style: theme.textTheme.labelMedium,
                )
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 18.h),
              child: _buildColumnvector(
                context,
                vectorSeven: ImageConstant.imgVectorOnprimary18x18,
                business: "Business",
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 18.h),
            padding: EdgeInsets.symmetric(
              horizontal: 4.h,
              vertical: 8.v,
            ),
            decoration: AppDecoration.outlineOnPrimary.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder15,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 4.v),
                Container(
                  height: 31.adaptSize,
                  width: 31.adaptSize,
                  padding: EdgeInsets.all(5.h),
                  decoration: AppDecoration.fillPrimary.copyWith(
                    borderRadius: BorderRadiusStyle.roundedBorder15,
                  ),
                  child: CustomImageView(
                    imagePath: ImageConstant.imgVectorOnprimary19x20,
                    height: 19.v,
                    width: 20.h,
                    alignment: Alignment.topCenter,
                  ),
                ),
                SizedBox(height: 10.v),
                Text(
                  "Technology",
                  style: theme.textTheme.labelMedium,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowcourses(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Opacity(
            opacity: 0.8,
            child: Text(
              "Courses",
              style: CustomTextStyles.titleSmallBlack900SemiBold,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 2.v),
            child: Text(
              "See all",
              style: CustomTextStyles.bodySmallPrimary,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowbiology(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 25.h,
        right: 21.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 59.h,
            padding: EdgeInsets.symmetric(
              horizontal: 8.h,
              vertical: 1.v,
            ),
            decoration: AppDecoration.outlineIndigo.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder10,
            ),
            child: Text(
              "Biology",
              style: CustomTextStyles.labelLargeOnPrimary,
            ),
          ),
          Container(
            width: 58.h,
            margin: EdgeInsets.only(left: 16.h),
            padding: EdgeInsets.symmetric(
              horizontal: 8.h,
              vertical: 1.v,
            ),
            decoration: AppDecoration.outlineBlack.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder10,
            ),
            child: Text(
              "History",
              style: theme.textTheme.labelLarge,
            ),
          ),
          Container(
            width: 58.h,
            margin: EdgeInsets.only(left: 16.h),
            padding: EdgeInsets.symmetric(
              horizontal: 8.h,
              vertical: 1.v,
            ),
            decoration: AppDecoration.outlineBlack.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder10,
            ),
            child: Text(
              "English",
              style: theme.textTheme.labelLarge,
            ),
          ),
          Container(
            width: 91.h,
            margin: EdgeInsets.only(left: 16.h),
            padding: EdgeInsets.symmetric(
              horizontal: 8.h,
              vertical: 2.v,
            ),
            decoration: AppDecoration.outlineBlack.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder10,
            ),
            child: Text(
              "Mathematics",
              style: theme.textTheme.labelLarge,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildRowdigestive(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(left: 25.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: _buildColumnOne(
                context,
                imageTwo: ImageConstant.imgFrame65,
                anatomy: "Digestive System",
                biologyquizOne: "Biology Quiz",
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 24.h),
                child: _buildColumnOne(
                  context,
                  imageTwo: ImageConstant.imgFrame65144x231,
                  anatomy: "Anatomy",
                  biologyquizOne: "Biology Quiz",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRow(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(left: 25.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomImageView(
              imagePath: ImageConstant.imgFrame65,
              height: 144.v,
              width: 231.h,
              radius: BorderRadius.vertical(
                top: Radius.circular(15.h),
              ),
            ),
            CustomImageView(
              imagePath: ImageConstant.imgFrame65144x231,
              height: 144.v,
              width: 231.h,
              radius: BorderRadius.vertical(
                top: Radius.circular(15.h),
              ),
              margin: EdgeInsets.only(left: 24.h),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRowdigestive1(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: EdgeInsets.only(left: 25.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: _buildColumndigestive(
                context,
                digestiveOne: "Digestive System",
                biologyquizTwo: "Biology Quiz",
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 24.h),
                child: _buildColumndigestive(
                  context,
                  digestiveOne: "Anatomy",
                  biologyquizTwo: "Biology Quiz",
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Common widget
  Widget _buildColumnvector(
    BuildContext context, {
    required String vectorSeven,
    required String business,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.h,
        vertical: 9.v,
      ),
      decoration: AppDecoration.outlineOnPrimary.copyWith(
        borderRadius: BorderRadiusStyle.roundedBorder15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 1.v),
          Container(
            height: 31.adaptSize,
            width: 31.adaptSize,
            padding: EdgeInsets.all(6.h),
            decoration: AppDecoration.fillPrimary.copyWith(
              borderRadius: BorderRadiusStyle.roundedBorder15,
            ),
            child: CustomImageView(
              imagePath: vectorSeven,
              height: 18.adaptSize,
              width: 18.adaptSize,
              alignment: Alignment.topRight,
            ),
          ),
          SizedBox(height: 11.v),
          Text(
            business,
            style: theme.textTheme.labelMedium!.copyWith(
              color: theme.colorScheme.onPrimary.withOpacity(1),
            ),
          )
        ],
      ),
    );
  }

  /// Common widget
  Widget _buildColumnOne(
    BuildContext context, {
    required String imageTwo,
    required String anatomy,
    required String biologyquizOne,
  }) {
    return Column(
      children: [
        CustomImageView(
          imagePath: imageTwo,
          height: 144.v,
          width: 231.h,
          radius: BorderRadius.vertical(
            top: Radius.circular(15.h),
          ),
        ),
        Container(
          width: 231.h,
          padding: EdgeInsets.symmetric(
            horizontal: 4.h,
            vertical: 6.v,
          ),
          decoration: AppDecoration.outlineBlack900.copyWith(
            borderRadius: BorderRadiusStyle.customBorderBL15,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 7.v),
              Text(
                anatomy,
                style: theme.textTheme.labelLarge!.copyWith(
                  color: appTheme.black900.withOpacity(0.8),
                ),
              ),
              SizedBox(height: 14.v),
              Text(
                biologyquizOne,
                style: CustomTextStyles.bodySmallBlack900.copyWith(
                  color: appTheme.black900.withOpacity(0.6),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  /// Common widget
  Widget _buildColumndigestive(
    BuildContext context, {
    required String digestiveOne,
    required String biologyquizTwo,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 4.h,
        vertical: 6.v,
      ),
      decoration: AppDecoration.outlineBlack900.copyWith(
        borderRadius: BorderRadiusStyle.customBorderBL15,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 7.v),
          Text(
            digestiveOne,
            style: theme.textTheme.labelLarge!.copyWith(
              color: appTheme.black900.withOpacity(0.8),
            ),
          ),
          SizedBox(height: 14.v),
          Text(
            biologyquizTwo,
            style: CustomTextStyles.bodySmallBlack900.copyWith(
              color: appTheme.black900.withOpacity(0.6),
            ),
          )
        ],
      ),
    );
  }
}
