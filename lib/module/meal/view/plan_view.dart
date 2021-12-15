import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/data/model/baby_model.dart';
import 'package:flutter_babycare/data/model/food_model.dart';
import 'package:flutter_babycare/utils/UI_components/food_detail_icon.dart';
import 'package:flutter_babycare/utils/UI_components/highlight_box.dart';
import 'package:flutter_babycare/utils/UI_components/line_button.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MealPlanViewArguments {
  final BabyModel baby;

  MealPlanViewArguments(
    this.baby,
  );
}

class MealPlanView extends StatefulWidget {
  static const routeName = '/meal-plan';

  const MealPlanView({Key key}) : super(key: key);

  @override
  _MealPlanViewState createState() => _MealPlanViewState();
}

class _MealPlanViewState extends State<MealPlanView> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as MealPlanViewArguments;
    List<FoodModel> foodListTotal = [];
    for (var i = 0; i < 8; i++) {
      foodListTotal.add(FoodModel(
        idBaby: '',
        type: FoodType.values[i],
        value: 900.0,
        updateDate: DateTime.now(),
      ));
    }
    List<FoodModel> foodListBreakfast = [];
    for (var i = 0; i < 3; i++) {
      foodListBreakfast.add(FoodModel(
        idBaby: '',
        type: FoodType.values[i],
        value: 900.0,
        updateDate: DateTime.now(),
      ));
    }
    List<FoodModel> foodListNoon = [];
    for (var i = 0; i < 3; i++) {
      foodListNoon.add(FoodModel(
        idBaby: '',
        type: FoodType.values[i],
        value: 800.0,
        updateDate: DateTime.now(),
      ));
    }
    List<FoodModel> foodListDinner = [];
    for (var i = 0; i < 3; i++) {
      foodListDinner.add(FoodModel(
        idBaby: '',
        type: FoodType.values[i],
        value: 700.0,
        updateDate: DateTime.now(),
      ));
    }
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
              'Week Plan',
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
          child: Stack(
            children: [
              ListView(
                children: [
                  SizedBox(height: AppConstants.paddingNormalH),
                  _buildTotalWeekDetail(foodListTotal),
                  _buildTomorrowDetail(
                      foodListBreakfast, foodListNoon, foodListDinner),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: 4,
                      itemBuilder: (context, index) {
                        return _buildDateDetail(
                            foodListBreakfast, foodListNoon, foodListDinner);
                      }),
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
      ),
    );
  }

  _buildTotalWeekDetail(List<FoodModel> foodList) {
    return Container(
      height: 152.h,
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            height: 48.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: AppConstants.paddingLargeW),
                Text(
                  'Total food for the next',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(width: AppConstants.paddingNormalW),
                HighlightBox('7', color: AppColors.primary),
                SizedBox(width: AppConstants.paddingNormalW),
                Text(
                  'days',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ],
            ),
          ),
          Divider(
            height: .5,
            thickness: .5,
          ),
          Container(
            margin: EdgeInsets.only(
              left: AppConstants.paddingNormalW,
              top: AppConstants.paddingNormalH,
              bottom: AppConstants.paddingNormalH,
            ),
            child: Wrap(
              runSpacing: AppConstants.paddingNormalH,
              children: foodList
                  .map((item) => FoodDetailIcon(item))
                  .toList()
                  .cast<Widget>(),
            ),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingAppW,
        vertical: AppConstants.paddingNormalH,
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

  _buildTomorrowDetail(
    List<FoodModel> breakfast,
    List<FoodModel> noon,
    List<FoodModel> dinner,
  ) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: Container(
            alignment: Alignment.topCenter,
            height: 120.h,
            margin: EdgeInsets.symmetric(
              horizontal: AppConstants.paddingAppW,
              vertical: AppConstants.paddingNormalH,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.secondary,
                  AppColors.primary,
                  Color(0xffBD88F2),
                  AppColors.danger,
                  AppColors.highlighter,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(AppConstants.cornerRadiusFrame),
              ),
            ),
            child: Container(
              alignment: Alignment.center,
              height: 80.h,
              child: Text(
                'Tomorrow',
                style: TextStyle(
                  fontSize: 46.sp,
                  color: AppColors.whiteBackground,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 10,
                ),
              ),
            ),
          ),
        ),
        Column(
          children: [
            SizedBox(height: 80.h),
            Container(
              height: 152.h,
              alignment: Alignment.center,
              child: Container(
                margin: EdgeInsets.only(
                  left: AppConstants.paddingNormalW,
                  top: AppConstants.paddingNormalH,
                  bottom: AppConstants.paddingNormalH,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 85.w,
                          child: Text(
                            'Breakfast',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                        SizedBox(width: AppConstants.paddingNormalW),
                        Row(
                          children: breakfast
                              .map((item) => FoodDetailIcon(item))
                              .toList()
                              .cast<Widget>(),
                        ),
                      ],
                    ),
                    SizedBox(height: AppConstants.paddingNormalH),
                    Row(
                      children: [
                        Container(
                          width: 85.w,
                          child: Text(
                            'Noon',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                        SizedBox(width: AppConstants.paddingNormalW),
                        Row(
                          children: noon
                              .map((item) => FoodDetailIcon(item))
                              .toList()
                              .cast<Widget>(),
                        ),
                      ],
                    ),
                    SizedBox(height: AppConstants.paddingNormalH),
                    Row(
                      children: [
                        Container(
                          width: 85.w,
                          child: Text(
                            'Dinner',
                            style: Theme.of(context).textTheme.headline1,
                          ),
                        ),
                        SizedBox(width: AppConstants.paddingNormalW),
                        Row(
                          children: dinner
                              .map((item) => FoodDetailIcon(item))
                              .toList()
                              .cast<Widget>(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              margin: EdgeInsets.symmetric(
                horizontal: AppConstants.paddingAppW,
                vertical: AppConstants.paddingNormalH,
              ),
              decoration: BoxDecoration(
                color: AppColors.whiteBackground,
                borderRadius:
                    BorderRadius.circular(AppConstants.cornerRadiusFrame),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    blurRadius: 4,
                    offset: Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  _buildDateDetail(
    List<FoodModel> breakfast,
    List<FoodModel> noon,
    List<FoodModel> dinner,
  ) {
    return Container(
      height: 200.h,
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            height: 48.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: AppConstants.paddingLargeW),
                HighlightBox('7', color: AppColors.primary),
                SizedBox(width: AppConstants.paddingNormalW),
                Text(
                  'days next',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Expanded(child: Container()),
                Text(
                  '20/5/2021',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(width: AppConstants.paddingLargeW),
              ],
            ),
          ),
          Divider(
            height: .5,
            thickness: .5,
          ),
          Container(
            margin: EdgeInsets.only(
              left: AppConstants.paddingNormalW,
              top: AppConstants.paddingNormalH,
              bottom: AppConstants.paddingNormalH,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(
                      width: 85.w,
                      child: Text(
                        'Breakfast',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    SizedBox(width: AppConstants.paddingNormalW),
                    Row(
                      children: breakfast
                          .map((item) => FoodDetailIcon(item))
                          .toList()
                          .cast<Widget>(),
                    ),
                  ],
                ),
                SizedBox(height: AppConstants.paddingNormalH),
                Row(
                  children: [
                    Container(
                      width: 85.w,
                      child: Text(
                        'Noon',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    SizedBox(width: AppConstants.paddingNormalW),
                    Row(
                      children: noon
                          .map((item) => FoodDetailIcon(item))
                          .toList()
                          .cast<Widget>(),
                    ),
                  ],
                ),
                SizedBox(height: AppConstants.paddingNormalH),
                Row(
                  children: [
                    Container(
                      width: 85.w,
                      child: Text(
                        'Dinner',
                        style: Theme.of(context).textTheme.headline1,
                      ),
                    ),
                    SizedBox(width: AppConstants.paddingNormalW),
                    Row(
                      children: dinner
                          .map((item) => FoodDetailIcon(item))
                          .toList()
                          .cast<Widget>(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingAppW,
        vertical: AppConstants.paddingNormalH,
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
