import 'package:flutter/material.dart';
import 'package:flutter_babycare/utils/UI_components/appbar_primary.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../../../constants/app_constants.dart';
import '../../../../data/model/baby/baby_model.dart';
import '../../../../data/model/baby/food_model.dart';
import '../../../../data/model/baby/food_suggest_model.dart';
import '../../../../data/source/baby/food_suggest_repository.dart';
import '../../../../data/source/local_data_source.dart';
import '../../../../utils/UI_components/error_label.dart';
import '../../../../utils/UI_components/food_detail_icon.dart';
import '../../../../utils/UI_components/highlight_box.dart';
import '../../../../utils/UI_components/line_button.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/converter.dart';

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

  Future<List<FoodSuggestModel>> future;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as MealPlanViewArguments;
    FoodSuggestRepository foodSuggestRepository = new FoodSuggestRepository();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppbarPrimary(title: 'Week Plan'),
      body: Center(
        child: Container(
          color: AppColors.background,
          child: Stack(
            children: [
              ListView(
                children: [
                  SizedBox(height: AppConstants.paddingNormalH),
                  FutureBuilder(
                      future: foodSuggestRepository
                          .listTotalMealSuggestForWeek(args.baby.id),
                      builder: (context, state) {
                        if (state.hasData) {
                          return _buildTotalWeekDetail(state.data);
                        } else {
                          return ErrorLabel();
                        }
                      }),
                  _buildTomorrowDetail(
                      LocalDataSource.fetchBreakfastSuggest(1),
                      LocalDataSource.fetchNoonSuggest(1),
                      LocalDataSource.fetchDinnerSuggest(1)),
                  ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return _buildDateDetail(
                            LocalDataSource.fetchBreakfastSuggest(index + 2),
                            LocalDataSource.fetchNoonSuggest(index + 2),
                            LocalDataSource.fetchDinnerSuggest(index + 2),
                            index + 2);
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

  _buildTotalWeekDetail(List<FoodSuggestModel> foodList) {
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
                  .map((item) => _buildFoodSuggestDetailIcon(item))
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

  _buildFoodSuggestDetailIcon(FoodSuggestModel item) {
    return Container(
      width: 92.w,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            _icons[Converter.FoodTypeToIconNameString(item.type)],
            width: 40.w,
            height: 40.w,
          ),
          item.value < 1000
              ? SizedBox(width: AppConstants.paddingNormalW)
              : Container(),
          Text(
            item.value.toInt().toString() +
                Converter.FoodTypeToUnitString(item.type),
            style: Theme.of(context).textTheme.bodyText1,
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
    int dayNext,
  ) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

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
                HighlightBox(dayNext.toString(), color: AppColors.primary),
                SizedBox(width: AppConstants.paddingNormalW),
                Text(
                  'days next',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Expanded(child: Container()),
                Text(
                  formatter.format(
                      DateTime.now().subtract(Duration(days: -dayNext))),
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
