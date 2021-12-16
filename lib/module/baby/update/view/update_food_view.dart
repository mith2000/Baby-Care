import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/data/model/baby_model.dart';
import 'package:flutter_babycare/data/model/food_model.dart';
import 'package:flutter_babycare/data/model/ni_model.dart';
import 'package:flutter_babycare/module/home/bloc/baby_bloc.dart';
import 'package:flutter_babycare/module/home/bloc/baby_event.dart';
import 'package:flutter_babycare/module/home/bloc/baby_state.dart';
import 'package:flutter_babycare/utils/UI_components/baby_status_icon.dart';
import 'package:flutter_babycare/utils/UI_components/custom_slider.dart';
import 'package:flutter_babycare/utils/UI_components/custom_slider_label.dart';
import 'package:flutter_babycare/utils/UI_components/error_label.dart';
import 'package:flutter_babycare/utils/UI_components/highlight_box.dart';
import 'package:flutter_babycare/utils/UI_components/mini_line_button.dart';
import 'package:flutter_babycare/utils/UI_components/mini_solid_button.dart';
import 'package:flutter_babycare/utils/UI_components/title_label.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_babycare/utils/converter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class UpdateFoodViewArguments {
  final BabyModel baby;
  final List<NIModel> NIList;

  UpdateFoodViewArguments(this.baby, this.NIList);
}

class UpdateFoodView extends StatefulWidget {
  static const routeName = '/update-food';

  const UpdateFoodView({Key key}) : super(key: key);

  @override
  _UpdateFoodViewState createState() => _UpdateFoodViewState();
}

class _UpdateFoodViewState extends State<UpdateFoodView> {
  Map<String, int> _formData = {
    'porridge': 0,
    'milk': 0,
    'meat': 0,
    'fish': 0,
    'egg': 0,
    'green_vegets': 0,
    'red_vegets': 0,
    'citrus_fruit': 0,
  };
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
  bool _isNotifyMustInput = false;
  BabyBloc babyBloc;

  @override
  void initState() {
    super.initState();
    babyBloc = BlocProvider.of<BabyBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as UpdateFoodViewArguments;
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
              'Food Update',
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
                  _buildBabyInfoView(args),
                  _buildTrackerView(args),
                  _buildInputFrame(),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildMainButtons(args),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBabyInfoView(UpdateFoodViewArguments args, {BabyStatus status}) {
    return Wrap(
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 75.w,
              backgroundImage: NetworkImage(args.baby.image),
              backgroundColor: Colors.transparent,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    args.baby.name,
                    style: Theme.of(context).textTheme.caption,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: AppConstants.paddingNormalH),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Baby\'s age:',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(width: AppConstants.paddingNormalW),
                      HighlightBox(
                        Converter.dateToMonthDouble(DateFormat('dd/MM/yyyy')
                                .format(args.baby.birth))
                            .toInt()
                            .toString(),
                        color: AppColors.primary,
                      ),
                      SizedBox(width: AppConstants.paddingNormalW),
                      Text(
                        'months',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                  SizedBox(height: AppConstants.paddingNormalH),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Status',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      SizedBox(width: AppConstants.paddingNormalW),
                      BabyStatusIcon(status: status),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTrackerView(
    UpdateFoodViewArguments args,
  ) {
    var nutriUpdateDates = <int>[];
    for (var i = 0; i < args.NIList.length; i++) {
      nutriUpdateDates.add(Converter.dateToDayDouble(
              DateFormat('dd/MM/yyyy').format(args.NIList[i].updateDate))
          .toInt());
    }

    int updateDateNI = 0;
    updateDateNI =
        nutriUpdateDates.reduce((curr, next) => curr < next ? curr : next);
    ;

    return Container(
      height: 80.h,
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingLargeW,
      ),
      margin: EdgeInsets.symmetric(vertical: AppConstants.paddingLargeH),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Last update',
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(width: AppConstants.paddingNormalW),
          Text(
            'since',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(width: AppConstants.paddingNormalW),
          HighlightBox(
            updateDateNI.toString(),
            color: updateDateNI <= AppConstants.dateDanger
                ? AppColors.primary
                : AppColors.danger,
          ),
          SizedBox(width: AppConstants.paddingNormalW),
          Text(
            'days ago',
            style: Theme.of(context).textTheme.bodyText1,
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

  Widget _buildInputFrame() {
    return Container(
      child: Column(
        children: [
          TitleLabel('Can you remember what your baby ate yesterday?'),
          SizedBox(height: AppConstants.paddingLargeH),
          _isNotifyMustInput
              ? Column(
                  children: [
                    _buildNotifyLabel(),
                    SizedBox(height: AppConstants.paddingLargeH),
                  ],
                )
              : Container(),
          CustomSliderLabel(
              icon: SvgPicture.asset(
                _icons['porridge'],
                width: 30.w,
                height: 30.h,
              ),
              label: 'Porridge: ' +
                  (_formData['porridge'] * 100).toString() +
                  'g ~ ' +
                  (_formData['porridge'].toDouble() / 10.0).toString() +
                  'kg'),
          CustomSlider(
            value: _formData['porridge'],
            max: 10,
            onChanged: (dynamic values) => {
              setState(() {
                _isNotifyMustInput = false;
                double valueToInt = values as double;
                _formData['porridge'] = valueToInt.round();
              })
            },
          ),
          SizedBox(height: AppConstants.paddingLargeH),
          CustomSliderLabel(
              icon: SvgPicture.asset(
                _icons['milk'],
                width: 30.w,
                height: 30.h,
              ),
              label: 'Milk: ' +
                  (_formData['milk'] * 100).toString() +
                  'ml ~ ' +
                  (_formData['milk'].toDouble() / 10.0).toString() +
                  'l'),
          CustomSlider(
            value: _formData['milk'],
            max: 10,
            onChanged: (dynamic values) => {
              setState(() {
                _isNotifyMustInput = false;
                double valueToInt = values as double;
                _formData['milk'] = valueToInt.round();
              })
            },
          ),
          SizedBox(height: AppConstants.paddingLargeH),
          CustomSliderLabel(
              icon: SvgPicture.asset(
                _icons['meat'],
                width: 30.w,
                height: 30.h,
              ),
              label: 'Meat: ' +
                  (_formData['meat'] * 100).toString() +
                  'g ~ ' +
                  (_formData['meat'].toDouble() / 10.0).toString() +
                  'kg'),
          CustomSlider(
            value: _formData['meat'],
            max: 10,
            onChanged: (dynamic values) => {
              setState(() {
                _isNotifyMustInput = false;
                double valueToInt = values as double;
                _formData['meat'] = valueToInt.round();
              })
            },
          ),
          SizedBox(height: AppConstants.paddingLargeH),
          CustomSliderLabel(
              icon: SvgPicture.asset(
                _icons['fish'],
                width: 30.w,
                height: 30.h,
              ),
              label: 'Fish: ' +
                  (_formData['fish'] * 100).toString() +
                  'g ~ ' +
                  (_formData['fish'].toDouble() / 10.0).toString() +
                  'kg'),
          CustomSlider(
            value: _formData['fish'],
            max: 10,
            onChanged: (dynamic values) => {
              setState(() {
                _isNotifyMustInput = false;
                double valueToInt = values as double;
                _formData['fish'] = valueToInt.round();
              })
            },
          ),
          SizedBox(height: AppConstants.paddingLargeH),
          CustomSliderLabel(
              icon: SvgPicture.asset(
                _icons['egg'],
                width: 30.w,
                height: 30.h,
              ),
              label: 'Egg: ' + _formData['egg'].toString() + ' unit'),
          CustomSlider(
            value: _formData['egg'],
            max: 10,
            onChanged: (dynamic values) => {
              setState(() {
                _isNotifyMustInput = false;
                double valueToInt = values as double;
                _formData['egg'] = valueToInt.round();
              })
            },
          ),
          SizedBox(height: AppConstants.paddingLargeH),
          CustomSliderLabel(
              icon: SvgPicture.asset(
                _icons['green_vegets'],
                width: 30.w,
                height: 30.h,
              ),
              label: 'Green Vegets: ' +
                  (_formData['green_vegets'] * 100).toString() +
                  'g ~ ' +
                  (_formData['green_vegets'].toDouble() / 10.0).toString() +
                  'kg'),
          CustomSlider(
            value: _formData['green_vegets'],
            max: 10,
            onChanged: (dynamic values) => {
              setState(() {
                _isNotifyMustInput = false;
                double valueToInt = values as double;
                _formData['green_vegets'] = valueToInt.round();
              })
            },
          ),
          SizedBox(height: AppConstants.paddingLargeH),
          CustomSliderLabel(
              icon: SvgPicture.asset(
                _icons['red_vegets'],
                width: 30.w,
                height: 30.h,
              ),
              label: 'Red Vegets: ' +
                  (_formData['red_vegets'] * 100).toString() +
                  'g ~ ' +
                  (_formData['red_vegets'].toDouble() / 10.0).toString() +
                  'kg'),
          CustomSlider(
            value: _formData['red_vegets'],
            max: 10,
            onChanged: (dynamic values) => {
              setState(() {
                _isNotifyMustInput = false;
                double valueToInt = values as double;
                _formData['red_vegets'] = valueToInt.round();
              })
            },
          ),
          SizedBox(height: AppConstants.paddingLargeH),
          CustomSliderLabel(
              icon: SvgPicture.asset(
                _icons['citrus_fruit'],
                width: 30.w,
                height: 30.h,
              ),
              label: 'Citrus Fruit: ' +
                  (_formData['citrus_fruit'] * 100).toString() +
                  'g ~ ' +
                  (_formData['citrus_fruit'].toDouble() / 10.0).toString() +
                  'kg'),
          CustomSlider(
            value: _formData['citrus_fruit'],
            max: 10,
            onChanged: (dynamic values) => {
              setState(() {
                _isNotifyMustInput = false;
                double valueToInt = values as double;
                _formData['citrus_fruit'] = valueToInt.round();
              })
            },
          ),
        ],
      ),
      margin: EdgeInsets.only(
        left: AppConstants.paddingSuperLargeW - AppConstants.paddingAppW,
        right: AppConstants.paddingSuperLargeW - AppConstants.paddingAppW,
        bottom: AppConstants.paddingSuperLargeH * 3 - AppConstants.paddingAppH,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingLargeW,
        vertical: AppConstants.paddingLargeH,
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

  Widget _buildNotifyLabel() {
    return Center(
      child: Text(
        'Must to input at least one',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
          color: AppColors.danger,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildMainButtons(
    UpdateFoodViewArguments args,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MiniLineButton('Back', () {
          Navigator.pop(context);
        }),
        SizedBox(width: AppConstants.paddingLargeW),
        BlocBuilder<BabyBloc, BabyState>(
            bloc: babyBloc,
            builder: (context, state) {
              if (state is LoadBMIAndNIBaby) {
                return MiniSolidButton('Save', () {
                  if (_formData['porridge'] == 0 &&
                      _formData['milk'] == 0 &&
                      _formData['meat'] == 0 &&
                      _formData['fish'] == 0 &&
                      _formData['egg'] == 0 &&
                      _formData['green_vegets'] == 0 &&
                      _formData['red_vegets'] == 0 &&
                      _formData['citrus_fruit'] == 0) {
                    setState(() {
                      _isNotifyMustInput = true;
                    });
                    return;
                  }
                  List<FoodModel> foodList = [];
                  List<int> foodValues = [];
                  foodValues.add(_formData['porridge'] * 100);
                  foodValues.add(_formData['milk'] * 100);
                  foodValues.add(_formData['meat'] * 100);
                  foodValues.add(_formData['fish'] * 100);
                  foodValues.add(_formData['egg']);
                  foodValues.add(_formData['green_vegets'] * 100);
                  foodValues.add(_formData['red_vegets'] * 100);
                  foodValues.add(_formData['citrus_fruit'] * 100);
                  for (var i = 0; i < FoodType.values.length; i++) {
                    foodList.add(FoodModel(
                      idBaby: args.baby.id,
                      type: FoodType.values[i],
                      value: foodValues[i].toDouble(),
                      updateDate: DateTime.now(),
                    ));
                  }
                  babyBloc.add(UpdateFoodEvent(listFood: foodList));
                  babyBloc.add(FetchBMIAndNI(idBaby: args.baby.id));
                  Navigator.pop(context);
                });
              }
              return ErrorLabel();
            }),
      ],
    );
  }
}
