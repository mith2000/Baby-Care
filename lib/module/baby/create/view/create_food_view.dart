import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/module/home/view/home_view.dart';
import 'package:flutter_babycare/utils/UI_components/custom_slider.dart';
import 'package:flutter_babycare/utils/UI_components/custom_slider_label.dart';
import 'package:flutter_babycare/utils/UI_components/mini_line_button.dart';
import 'package:flutter_babycare/utils/UI_components/mini_solid_button.dart';
import 'package:flutter_babycare/utils/UI_components/title_label.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateBabyFoodView extends StatefulWidget {
  static const routeName = '/create-baby-food';

  const CreateBabyFoodView({Key key}) : super(key: key);

  @override
  _CreateBabyFoodViewState createState() => _CreateBabyFoodViewState();
}

class _CreateBabyFoodViewState extends State<CreateBabyFoodView> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          color: AppColors.background,
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.paddingAppW,
            vertical: AppConstants.paddingAppH,
          ),
          child: Stack(
            children: [
              Center(
                child: Container(
                  child: ListView(
                    children: [
                      TitleLabel(
                          'Can you remember what your baby ate yesterday?'),
                      SizedBox(height: AppConstants.paddingNormalH),
                      _buildNotifyLabel(),
                      SizedBox(height: AppConstants.paddingLargeH),
                      CustomSliderLabel(
                          icon: SvgPicture.asset(
                            _icons['porridge'],
                            width: 30.w,
                            height: 30.h,
                          ),
                          label: 'Porridge: ' +
                              (_formData['porridge'] * 100).toString() +
                              'g ~ ' +
                              (_formData['porridge'].toDouble() / 10.0)
                                  .toString() +
                              'kg'),
                      CustomSlider(
                        value: _formData['porridge'],
                        max: 10,
                        onChanged: (dynamic values) => {
                          setState(() {
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
                          label:
                              'Egg: ' + _formData['egg'].toString() + ' unit'),
                      CustomSlider(
                        value: _formData['egg'],
                        max: 10,
                        onChanged: (dynamic values) => {
                          setState(() {
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
                              (_formData['green_vegets'].toDouble() / 10.0)
                                  .toString() +
                              'kg'),
                      CustomSlider(
                        value: _formData['green_vegets'],
                        max: 10,
                        onChanged: (dynamic values) => {
                          setState(() {
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
                              (_formData['red_vegets'].toDouble() / 10.0)
                                  .toString() +
                              'kg'),
                      CustomSlider(
                        value: _formData['red_vegets'],
                        max: 10,
                        onChanged: (dynamic values) => {
                          setState(() {
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
                              (_formData['citrus_fruit'].toDouble() / 10.0)
                                  .toString() +
                              'kg'),
                      CustomSlider(
                        value: _formData['citrus_fruit'],
                        max: 10,
                        onChanged: (dynamic values) => {
                          setState(() {
                            double valueToInt = values as double;
                            _formData['citrus_fruit'] = valueToInt.round();
                          })
                        },
                      ),
                    ],
                  ),
                  margin: EdgeInsets.only(
                    left: AppConstants.paddingSuperLargeW -
                        AppConstants.paddingAppW,
                    right: AppConstants.paddingSuperLargeW -
                        AppConstants.paddingAppW,
                    top: AppConstants.paddingSuperLargeH -
                        AppConstants.paddingAppH,
                    bottom: AppConstants.paddingSuperLargeH * 3 -
                        AppConstants.paddingAppH,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingLargeW,
                    vertical: AppConstants.paddingLargeH,
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
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _buildMainButtons(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _buildNotifyLabel() {
    return Center(
      child: Text(
        'You can skip this section and try again later',
        style: Theme.of(context).textTheme.bodyText1,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildMainButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MiniLineButton('Back', () {
          Navigator.pop(context);
        }),
        SizedBox(width: AppConstants.paddingLargeW),
        MiniSolidButton('Next', () {
          // moi data * 100 tru egg

          Navigator.pushNamed(
            context,
            HomeView.routeName,
          );
        }),
      ],
    );
  }
}
