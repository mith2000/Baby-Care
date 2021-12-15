import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/data/model/baby_model.dart';
import 'package:flutter_babycare/data/model/food_model.dart';
import 'package:flutter_babycare/module/home/bloc/baby_bloc.dart';
import 'package:flutter_babycare/module/home/bloc/baby_event.dart';
import 'package:flutter_babycare/module/home/bloc/baby_state.dart';
import 'package:flutter_babycare/utils/UI_components/error_label.dart';
import 'package:flutter_babycare/utils/UI_components/food_detail_icon.dart';
import 'package:flutter_babycare/utils/UI_components/highlight_box.dart';
import 'package:flutter_babycare/utils/UI_components/line_button.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MealHistoryViewArguments {
  final BabyModel baby;

  MealHistoryViewArguments(
    this.baby,
  );
}

class MealHistoryView extends StatefulWidget {
  static const routeName = '/meal-history';

  const MealHistoryView({Key key}) : super(key: key);

  @override
  _MealHistoryViewState createState() => _MealHistoryViewState();
}

class _MealHistoryViewState extends State<MealHistoryView> {
  BabyBloc babyBloc;

  @override
  void initState() {
    super.initState();
    babyBloc = BlocProvider.of<BabyBloc>(context);
  }

  @override
  void dispose() {
    babyBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as MealHistoryViewArguments;
    babyBloc.add(FetchFood(idBaby: args.baby.id, dayAgo: 0));
    // dayAgo = 0 là hôm nay, =1 là 1 ngày trước, =2 là 2 ngày trước
    List<FoodModel> foodList = [];
    for (var i = 0; i < 8; i++) {
      foodList.add(FoodModel(
        idBaby: '',
        type: FoodType.values[i],
        value: 900.0,
        updateDate: DateTime.now(),
      ));
    }
    return BlocBuilder<BabyBloc, BabyState>(
        bloc: babyBloc,
        builder: (context, state) {
          if (state is LoadFoodBaby) {
            print(state.list.length);
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
                      'Meal History',
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
                          ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: 4,
                              itemBuilder: (context, index) {
                                return _buildDateDetail(foodList);
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
          return ErrorLabel();
        });
  }

  _buildDateDetail(List<FoodModel> foodList) {
    return Container(
      height: 152.h,
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
                  'days ago',
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
