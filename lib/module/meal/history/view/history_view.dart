import 'package:flutter/material.dart';
import 'package:flutter_babycare/utils/UI_components/appbar_primary.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../../constants/app_constants.dart';
import '../../../../data/model/baby/baby_model.dart';
import '../../../../data/model/baby/food_model.dart';
import '../../../../utils/UI_components/error_label.dart';
import '../../../../utils/UI_components/food_detail_icon.dart';
import '../../../../utils/UI_components/highlight_box.dart';
import '../../../../utils/UI_components/line_button.dart';
import '../../../../utils/UI_components/loading_widget.dart';
import '../../../../utils/app_colors.dart';
import '../../../home/bloc/baby_bloc.dart';
import '../../../home/bloc/baby_event.dart';
import '../../../home/bloc/baby_state.dart';

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
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as MealHistoryViewArguments;
    babyBloc.add(FetchFood(idBaby: args.baby.id, dayAgo: 6));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppbarPrimary(title: 'Meal History'),
      body: Center(
        child: Container(
          color: AppColors.background,
          child: Stack(
            children: [
              ListView(
                children: [
                  SizedBox(height: AppConstants.paddingNormalH),
                  BlocBuilder<BabyBloc, BabyState>(
                      bloc: babyBloc,
                      builder: (context, state) {
                        if (state is FoodLoading) {
                          return CustomLoadingWidget();
                        }
                        if (state is LoadedFood) {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: state.list.length,
                              itemBuilder: (context, index) {
                                if (state.list[index].listFood.length > 0)
                                  return _buildDateDetail(
                                    state.list[index].listFood,
                                    state.list[index].dayAgo,
                                  );
                                else
                                  return Container();
                              });
                        }
                        return ErrorLabel();
                      }),
                  SizedBox(height: AppConstants.paddingSuperLargeH * 2),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildBackButton(args),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildDateDetail(List<FoodModel> foodList, int dayAgo) {
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
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
                HighlightBox(dayAgo.toString(), color: AppColors.primary),
                SizedBox(width: AppConstants.paddingNormalW),
                Text(
                  'days ago',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                Expanded(child: Container()),
                Text(
                  formatter
                      .format(DateTime.now().subtract(Duration(days: dayAgo))),
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

  Widget _buildBackButton(MealHistoryViewArguments args) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingAppW,
        vertical: AppConstants.paddingAppH,
      ),
      child: LineButton('Back', () {
        babyBloc.add(FetchBMIAndNI(idBaby: args.baby.id));

        Navigator.pop(context);
      }),
    );
  }
}
