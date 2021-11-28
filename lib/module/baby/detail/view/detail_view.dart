import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/data/model/baby_model.dart';
import 'package:flutter_babycare/utils/UI_components/baby_status_icon.dart';
import 'package:flutter_babycare/utils/UI_components/badge_icon.dart';
import 'package:flutter_babycare/utils/UI_components/highlight_box.dart';
import 'package:flutter_babycare/utils/UI_components/icon_button.dart';
import 'package:flutter_babycare/utils/UI_components/line_button.dart';
import 'package:flutter_babycare/utils/UI_components/solid_button.dart';
import 'package:flutter_babycare/utils/UI_components/title_label.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BabyDetailViewArguments {
  final BabyModel model;

  BabyDetailViewArguments(this.model);
}

class BabyDetailView extends StatefulWidget {
  static const routeName = '/baby-detail';

  const BabyDetailView({Key key}) : super(key: key);

  @override
  _BabyDetailViewState createState() => _BabyDetailViewState();
}

class _BabyDetailViewState extends State<BabyDetailView> {
  final Map<String, String> _icons = {
    'Carbohydrate': 'assets/icon/carbohydrate.svg',
    'Fat': 'assets/icon/fat.svg',
    'Protein': 'assets/icon/protein.svg',
    'Vitamin A': 'assets/icon/vitamin_a.svg',
    'Vitamin B': 'assets/icon/vitamin_b.svg',
    'Vitamin C': 'assets/icon/vitamin_c.svg',
    'Vitamin D': 'assets/icon/vitamin_d.svg',
    'Iron': 'assets/icon/iron.svg',
    'Calcium': 'assets/icon/calcium.svg',
    'Iodine': 'assets/icon/iodine.svg',
    'info': 'assets/icon/info.svg',
  };

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as BabyDetailViewArguments;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: AppColors.background,
        child: Stack(
          children: [
            ListView(
              children: [
                _buildBabyImage(args),
                Container(
                  child: Column(
                    children: [
                      _buildBMIFrame(
                        height: 1500,
                        heightStatus: BabyStatus.Cry,
                        weight: 1500,
                        weightStatus: BabyStatus.Sad,
                      ),
                      SizedBox(height: AppConstants.paddingLargeH),
                      _buildNIFrame(
                        statusCarbohydrate: BabyStatus.Love,
                        statusFat: BabyStatus.Happy,
                        statusProtein: BabyStatus.Smile,
                        statusVitaminA: BabyStatus.Sad,
                        statusVitaminB: BabyStatus.Cry,
                        statusVitaminC: BabyStatus.Love,
                        statusVitaminD: BabyStatus.Happy,
                        statusIron: BabyStatus.Smile,
                        statusCalcium: BabyStatus.Sad,
                        statusIodine: BabyStatus.Cry,
                        infoActionCarbohydrate: () {},
                        infoActionFat: () {},
                        infoActionProtein: () {},
                        infoActionVitaminA: () {},
                        infoActionVitaminB: () {},
                        infoActionVitaminC: () {},
                        infoActionVitaminD: () {},
                        infoActionIron: () {},
                        infoActionCalcium: () {},
                        infoActionIodine: () {},
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(
                    left: AppConstants.paddingLargeW,
                    right: AppConstants.paddingLargeW,
                    top: AppConstants.paddingNormalH,
                    bottom: AppConstants.paddingLargeH,
                  ),
                ),
                SizedBox(height: AppConstants.paddingSuperLargeH * 2),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildBackButton(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildBabyImage(BabyDetailViewArguments args) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/image/default_baby.png',
      height: ScreenUtil().screenWidth,
      fit: BoxFit.cover,
      image: args.model.image,
    );
  }

  Widget _buildBMIFrame({
    int height,
    BabyStatus heightStatus,
    int weight,
    BabyStatus weightStatus,
  }) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            child: TitleLabel('Body Mass Index'),
            padding: EdgeInsets.only(
              top: AppConstants.paddingLargeH,
              bottom: AppConstants.paddingNormalH,
            ),
          ),
          _buildBMIContent(
            'Current height:',
            'cm',
            value: height,
            status: heightStatus,
          ),
          _buildBMIContent(
            'Current weight:',
            'g',
            value: weight,
            status: weightStatus,
          ),
          Container(
            child: SolidButton('Update', () {}),
            padding: EdgeInsets.only(
              left: AppConstants.paddingLargeW,
              right: AppConstants.paddingLargeW,
              top: AppConstants.paddingNormalH,
              bottom: AppConstants.paddingLargeH,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteBackground,
        borderRadius: BorderRadius.circular(AppConstants.cornerRadiusFrame),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
    );
  }

  Widget _buildBMIContent(
    String label,
    String unit, {
    int value,
    BabyStatus status,
  }) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 40.h,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 111.w),
                  HighlightBox(
                    value.toString() + unit,
                    width: 96,
                    color: AppColors.primary,
                  ),
                  Expanded(child: Container()),
                  BabyStatusIcon(status: status),
                ],
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.paddingLargeW,
            vertical: AppConstants.paddingSlightH,
          ),
          margin: EdgeInsets.symmetric(
            horizontal: AppConstants.paddingLargeW,
            vertical: AppConstants.paddingNormalH,
          ),
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
          ),
        ),
        (status == BabyStatus.Sad || status == BabyStatus.Cry)
            ? BadgeIcon()
            : Container(),
      ],
    );
  }

  Widget _buildNIFrame({
    BabyStatus statusCarbohydrate,
    BabyStatus statusFat,
    BabyStatus statusProtein,
    BabyStatus statusVitaminA,
    BabyStatus statusVitaminB,
    BabyStatus statusVitaminC,
    BabyStatus statusVitaminD,
    BabyStatus statusIron,
    BabyStatus statusCalcium,
    BabyStatus statusIodine,
    Function infoActionCarbohydrate,
    Function infoActionFat,
    Function infoActionProtein,
    Function infoActionVitaminA,
    Function infoActionVitaminB,
    Function infoActionVitaminC,
    Function infoActionVitaminD,
    Function infoActionIron,
    Function infoActionCalcium,
    Function infoActionIodine,
  }) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Container(
            child: TitleLabel('Nutrition Index'),
            padding: EdgeInsets.only(
              top: AppConstants.paddingLargeH,
              bottom: AppConstants.paddingNormalH,
            ),
          ),
          _buildRowOfNI(
            'Carbohydrate',
            'Fat',
            status1: statusCarbohydrate,
            status2: statusFat,
            infoAction1: infoActionCarbohydrate,
            infoAction2: infoActionFat,
          ),
          _buildRowOfNI(
            'Protein',
            'Vitamin A',
            status1: statusProtein,
            status2: statusVitaminA,
            infoAction1: infoActionProtein,
            infoAction2: infoActionVitaminA,
          ),
          _buildRowOfNI(
            'Vitamin B',
            'Vitamin C',
            status1: statusVitaminB,
            status2: statusVitaminC,
            infoAction1: infoActionVitaminB,
            infoAction2: infoActionVitaminC,
          ),
          _buildRowOfNI(
            'Vitamin D',
            'Iron',
            status1: statusVitaminD,
            status2: statusIron,
            infoAction1: infoActionVitaminD,
            infoAction2: infoActionIron,
          ),
          _buildRowOfNI(
            'Calcium',
            'Iodine',
            status1: statusCalcium,
            status2: statusIodine,
            infoAction1: infoActionCalcium,
            infoAction2: infoActionIodine,
          ),
          Container(
            child: SolidButton('Update', () {}),
            padding: EdgeInsets.only(
              left: AppConstants.paddingLargeW,
              right: AppConstants.paddingLargeW,
              top: AppConstants.paddingNormalH,
              bottom: AppConstants.paddingLargeH,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteBackground,
        borderRadius: BorderRadius.circular(AppConstants.cornerRadiusFrame),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
    );
  }

  Widget _buildRowOfNI(
    String nutriName1,
    String nutriName2, {
    BabyStatus status1,
    BabyStatus status2,
    Function infoAction1,
    Function infoAction2,
  }) {
    // bán kính của badge
    final double badgeRadius = 10;
    return Row(
      children: [
        SizedBox(width: badgeRadius.w),
        _buildNIContent(
          nutriName1,
          badgeRadius: badgeRadius,
          status: status1,
          infoAction: infoAction1,
        ),
        _buildNIContent(
          nutriName2,
          badgeRadius: badgeRadius,
          status: status2,
          infoAction: infoAction2,
        ),
      ],
    );
  }

  Widget _buildNIContent(
    String nutriName, {
    double badgeRadius,
    BabyStatus status,
    Function infoAction,
  }) {
    return Stack(
      children: [
        Container(
          width: 167.w,
          height: 164.h,
          child: Column(
            children: [
              SizedBox(height: AppConstants.paddingLargeH),
              SvgPicture.asset(
                _icons[nutriName],
                width: 60.w,
                height: 60.h,
              ),
              SizedBox(height: AppConstants.paddingNormalH),
              Text(
                nutriName,
                style: Theme.of(context).textTheme.bodyText1,
              ),
              SizedBox(height: AppConstants.paddingNormalH),
              BabyStatusIcon(status: status),
            ],
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.paddingLargeW,
            vertical: AppConstants.paddingSlightH,
          ),
          margin: EdgeInsets.only(
            left: AppConstants.paddingLargeW - badgeRadius.w,
            right: badgeRadius.w,
            top: AppConstants.paddingNormalH,
            bottom: AppConstants.paddingNormalH,
          ),
          decoration: BoxDecoration(
            color: AppColors.secondary,
            borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
          ),
        ),
        (status == BabyStatus.Sad || status == BabyStatus.Cry)
            ? BadgeIcon(xOffset: -(AppConstants.paddingLargeW - badgeRadius.w))
            : Container(),
        Positioned(
          right: AppConstants.paddingSlightW,
          top: AppConstants.paddingSlightH,
          child: CircleIconButton(SvgPicture.asset(_icons['info']), infoAction),
        ),
      ],
    );
  }

  Widget _buildBackButton() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingAppW,
        vertical: AppConstants.paddingAppH,
      ),
      child: LineButton('Back', () {
        Navigator.pop(context);
      }),
    );
  }
}
