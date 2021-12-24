import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/data/model/baby_model.dart';
import 'package:flutter_babycare/data/model/ni_model.dart';
import 'package:flutter_babycare/module/baby/update/view/update_food_view.dart';
import 'package:flutter_babycare/module/meal/view/plan_view.dart';
import 'package:flutter_babycare/utils/UI_components/highlight_box.dart';
import 'package:flutter_babycare/utils/UI_components/line_button.dart';
import 'package:flutter_babycare/utils/UI_components/mini_line_button.dart';
import 'package:flutter_babycare/utils/UI_components/mini_solid_button.dart';
import 'package:flutter_babycare/utils/UI_components/solid_button.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_babycare/utils/converter.dart';
import 'package:flutter_babycare/utils/food_suggester.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'history_view.dart';

class MealSuggestionViewArguments {
  final BabyModel baby;
  final int updateDateNI;
  final List<NIModel> NIDeficiencyList;

  MealSuggestionViewArguments(
    this.baby,
    this.NIDeficiencyList,
    this.updateDateNI,
  );
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
                  _buildTrackerView(args),
                  SizedBox(height: AppConstants.paddingLargeH),
                  _buildUpdateNIButton(args),
                  SizedBox(height: AppConstants.paddingLargeH),
                  _buildNutriDeficiencyList(args),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: args.NIDeficiencyList.length,
                      itemBuilder: (context, index) {
                        return _buildNutriDeficiencyDetail(
                            args.baby.gender, args.NIDeficiencyList[index]);
                      }),
                  SizedBox(height: AppConstants.paddingSuperLargeH * 4),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildMealHistoryButton(args),
                  SizedBox(height: AppConstants.paddingLargeH),
                  _buildMainButtons(args),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildTrackerView(MealSuggestionViewArguments args) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'The last time you updated Nutrition Index was',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(width: AppConstants.paddingNormalW),
        HighlightBox(
          args.updateDateNI.toString(),
          color: args.updateDateNI < AppConstants.dateDanger
              ? AppColors.primary
              : AppColors.danger,
        ),
        SizedBox(width: AppConstants.paddingNormalW),
        Text(
          'days ago',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }

  _buildNutriDeficiencyList(MealSuggestionViewArguments args) {
    return Column(
      children: [
        Text(
          'Your baby is deficient in',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        SizedBox(height: AppConstants.paddingNormalH),
        Wrap(
          runSpacing: AppConstants.paddingNormalH,
          children: args.NIDeficiencyList.map((item) =>
                  _buildNutriDeficiencyHighlightBox(
                      Converter.NITypeToTypeString(item.type)))
              .toList()
              .cast<Widget>(),
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

  _buildNutriDeficiencyDetail(String gender, NIModel nutri) {
    List<FoodType> suggestFoods = FoodSuggester.getFoodSuggest(nutri.type);
    return Container(
      height: 196.h,
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            gender == "boy"
                ? "His "
                : "Her " + Converter.NITypeToTypeString(nutri.type) + " index:",
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
                width: 300.w * (nutri.value / 100.0),
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
              gender == "boy" ? "He" : "She" + " need more",
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          SizedBox(height: AppConstants.paddingNormalH),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: suggestFoods
                .map(
                  (item) => Row(
                    children: [
                      SvgPicture.asset(
                        _icons[Converter.FoodTypeToIconNameString(item)],
                        width: 40.w,
                        height: 40.h,
                      ),
                      SizedBox(width: AppConstants.paddingNormalW),
                    ],
                  ),
                )
                .toList()
                .cast<Widget>(),
          ),
        ],
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingLargeW,
      ),
      margin: EdgeInsets.only(
        left: AppConstants.paddingSuperLargeW - AppConstants.paddingAppW,
        right: AppConstants.paddingSuperLargeW - AppConstants.paddingAppW,
        top: AppConstants.paddingLargeH,
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

  _buildUpdateNIButton(MealSuggestionViewArguments args) {
    return SolidButton('Update Nutrition Index', () {
      Navigator.pushNamed(
        context,
        UpdateFoodView.routeName,
        arguments: UpdateFoodViewArguments(args.baby, args.NIDeficiencyList),
      );
    });
  }

  _buildMealHistoryButton(MealSuggestionViewArguments args) {
    return LineButton('Meal History', () {
      Navigator.pushNamed(
        context,
        MealHistoryView.routeName,
        arguments: MealHistoryViewArguments(args.baby),
      );
    });
  }

  Widget _buildMainButtons(MealSuggestionViewArguments args) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MiniLineButton('Back', () {
          Navigator.pop(context);
        }),
        SizedBox(width: AppConstants.paddingLargeW),
        MiniSolidButton('Week Plan', () {
          Navigator.pushNamed(
            context,
            MealPlanView.routeName,
            arguments: MealPlanViewArguments(args.baby),
          );
        }),
      ],
    );
  }
}
