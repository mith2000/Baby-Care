import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/data/model/baby_model.dart';
import 'package:flutter_babycare/data/model/ni_model.dart';
import 'package:flutter_babycare/module/baby/update/view/update_food_view.dart';
import 'package:flutter_babycare/utils/UI_components/highlight_box.dart';
import 'package:flutter_babycare/utils/UI_components/line_button.dart';
import 'package:flutter_babycare/utils/UI_components/mini_line_button.dart';
import 'package:flutter_babycare/utils/UI_components/mini_solid_button.dart';
import 'package:flutter_babycare/utils/UI_components/solid_button.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MealSuggestionViewArguments {
  final BabyModel baby;
  //final List<NIModel> listNI;

  MealSuggestionViewArguments(this.baby);
}

class MealSuggestionView extends StatefulWidget {
  static const routeName = '/meal-suggestion';

  const MealSuggestionView({Key key}) : super(key: key);

  @override
  _MealSuggestionViewState createState() => _MealSuggestionViewState();
}

class _MealSuggestionViewState extends State<MealSuggestionView> {
  final Map<String, String> _icons = {
    'porridge': 'assets/icon/porridge.svg',
    'milk': 'assets/icon/milk.svg',
    'meat': 'assets/icon/meat.svg',
    'fish': 'assets/icon/fish.svg',
    'egg': 'assets/icon/egg.svg',
    'green_vegets': 'assets/icon/green_vegets.svg',
    'red_vegets': 'assets/icon/red_vegets.svg',
    'citrus_fruit': 'assets/icon/citrus_fruit.svg',
  };

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments
        as MealSuggestionViewArguments;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
            AppConstants.paddingAppH + AppConstants.paddingSuperLargeH),
        child: AppBar(
          automaticallyImplyLeading: false,
          title: Container(
            height: 32.h,
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(left: AppConstants.paddingAppW),
            child: Text(
              'Meal Suggestion',
              style: GoogleFonts.dosis(
                fontWeight: FontWeight.w700,
                fontSize: 24.sp,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: AppColors.primary,
          elevation: 0,
        ),
      ),
      body: Center(
        child: Container(
          color: AppColors.background,
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.paddingAppW,
            vertical: AppConstants.paddingAppH,
          ),
          child: Stack(
            children: [
              ListView(
                children: [
                  _buildTrackerView(),
                  SizedBox(height: AppConstants.paddingLargeH),
                  _buildUpdateNIButton(args),
                  SizedBox(height: AppConstants.paddingLargeH),
                  _buildNutriDeficiencyList(),
                  SizedBox(height: AppConstants.paddingLargeH),
                  _buildNutriDeficiencyDetail(),
                  SizedBox(height: AppConstants.paddingLargeH),
                  _buildNutriDeficiencyDetail(),
                  SizedBox(height: AppConstants.paddingSuperLargeH * 4),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildMealHistoryButton(),
                  SizedBox(height: AppConstants.paddingLargeH),
                  _buildMainButtons(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildTrackerView() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'The last time you updated Nutrition Index was',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(width: AppConstants.paddingNormalW),
        HighlightBox(
          " ",
          color: AppColors.primary,
        ),
        SizedBox(width: AppConstants.paddingNormalW),
        Text(
          'days ago',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }

  _buildNutriDeficiencyList() {
    return Column(
      children: [
        Text(
          'Your baby is deficient in',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(height: AppConstants.paddingNormalH),
        Wrap(
          runSpacing: AppConstants.paddingNormalH,
          children: [
            _buildNutriDeficiencyHighlightBox('Carbohydrate'),
            _buildNutriDeficiencyHighlightBox('Fat'),
            _buildNutriDeficiencyHighlightBox('Vitamin A'),
            _buildNutriDeficiencyHighlightBox('Vitamin B'),
          ],
        ),
      ],
    );
  }

  _buildNutriDeficiencyHighlightBox(String name) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: AppConstants.paddingNormalW,
          vertical: AppConstants.paddingSlightH),
      margin: EdgeInsets.only(right: AppConstants.paddingNormalW),
      decoration: BoxDecoration(
        color: AppColors.danger,
        borderRadius:
            BorderRadius.circular(AppConstants.cornerRadiusHighlightBox),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Text(
        name,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 22.sp,
          color: AppColors.whiteBackground,
        ),
      ),
    );
  }

  _buildNutriDeficiencyDetail() {
    return Container(
      height: 196.h,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'His vitamin B index: ',
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(height: AppConstants.paddingLargeH),
          Stack(
            children: [
              Container(
                width: 300.w,
                height: 30.h,
                decoration: BoxDecoration(
                  color: AppColors.stroke,
                  borderRadius: BorderRadius.circular(25.w),
                ),
              ),
              Container(
                width: 300.w * 0.5,
                height: 30.h,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.w),
                    bottomLeft: Radius.circular(25.w),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppConstants.paddingLargeH),
          Center(
            child: Text(
              'He needs more',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          SizedBox(height: AppConstants.paddingNormalH),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                _icons['fish'],
                width: 40.w,
                height: 40.h,
              ),
              SizedBox(width: AppConstants.paddingNormalW),
              SvgPicture.asset(
                _icons['egg'],
                width: 40.w,
                height: 40.h,
              ),
              SizedBox(width: AppConstants.paddingNormalW),
              SvgPicture.asset(
                _icons['milk'],
                width: 40.w,
                height: 40.h,
              ),
              SizedBox(width: AppConstants.paddingNormalW),
              SvgPicture.asset(
                _icons['meat'],
                width: 40.w,
                height: 40.h,
              ),
              SizedBox(width: AppConstants.paddingNormalW),
              SvgPicture.asset(
                _icons['green_vegets'],
                width: 40.w,
                height: 40.h,
              ),
            ],
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingLargeW,
      ),
      margin: EdgeInsets.symmetric(
          horizontal:
              AppConstants.paddingSuperLargeW - AppConstants.paddingAppW),
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

  _buildUpdateNIButton(MealSuggestionViewArguments args) {
    return SolidButton('Update Nutrition Index', () {
      Navigator.pushNamed(
        context,
        UpdateFoodView.routeName,
        arguments: UpdateFoodViewArguments(args.baby),
      );
    });
  }

  _buildMealHistoryButton() {
    return LineButton('Meal History', () {});
  }

  Widget _buildMainButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MiniLineButton('Back', () {
          Navigator.pop(context);
        }),
        SizedBox(width: AppConstants.paddingLargeW),
        MiniSolidButton('Week Plan', () {}),
      ],
    );
  }
}