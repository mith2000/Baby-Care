import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/data/model/bmi_model.dart';
import 'package:flutter_babycare/module/home/bloc/baby_bloc.dart';
import 'package:flutter_babycare/module/home/bloc/baby_event.dart';
import 'package:flutter_babycare/module/home/bloc/baby_state.dart';
import 'package:flutter_babycare/utils/UI_components/custom_slider.dart';
import 'package:flutter_babycare/utils/UI_components/custom_slider_label.dart';
import 'package:flutter_babycare/utils/UI_components/mini_line_button.dart';
import 'package:flutter_babycare/utils/UI_components/mini_solid_button.dart';
import 'package:flutter_babycare/utils/UI_components/title_label.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'create_ni_view.dart';

class CreateBabyBMIView extends StatefulWidget {
  static const routeName = '/create-baby-bmi';

  const CreateBabyBMIView({Key key}) : super(key: key);

  @override
  _CreateBabyBMIViewState createState() => _CreateBabyBMIViewState();
}

class _CreateBabyBMIViewState extends State<CreateBabyBMIView> {
  Map<String, int> _formData = {
    'height': 0,
    'weight': 0,
  };
  bool _isNotifyMust2Input = false;
  BabyBloc babyBloc;

  @override
  void initState() {
    super.initState();
    babyBloc = BlocProvider.of<BabyBloc>(context);
  }

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
                child: Wrap(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          TitleLabel('How is your kid growing?'),
                          SizedBox(height: AppConstants.paddingLargeH),
                          CustomSliderLabel(
                              label: 'Height: ' +
                                  _formData['height'].toString() +
                                  'cm ~ ' +
                                  (_formData['height'].toDouble() / 100.0)
                                      .toString() +
                                  'm'),
                          CustomSlider(
                            value: _formData['height'],
                            max: 150,
                            stepSize: 10,
                            onChanged: (dynamic values) => {
                              setState(() {
                                if (_formData['height'] != 0 &&
                                    _formData['weight'] != 0) {
                                  _isNotifyMust2Input = false;
                                }
                                double valueToInt = values as double;
                                _formData['height'] = valueToInt.round();
                              })
                            },
                          ),
                          SizedBox(height: AppConstants.paddingLargeH),
                          CustomSliderLabel(
                              label: 'Weight: ' +
                                  _formData['weight'].toString() +
                                  '00g ~ ' +
                                  (_formData['weight'].toDouble() / 10.0)
                                      .toString() +
                                  'kg'),
                          CustomSlider(
                            value: _formData['weight'],
                            max: 400,
                            onChanged: (dynamic values) => {
                              setState(() {
                                if (_formData['height'] != 0 &&
                                    _formData['weight'] != 0) {
                                  _isNotifyMust2Input = false;
                                }
                                double valueToInt = values as double;
                                _formData['weight'] = valueToInt.round();
                              })
                            },
                          ),
                          _isNotifyMust2Input
                              ? _buildNotifyLable()
                              : Container()
                        ],
                      ),
                      margin: EdgeInsets.symmetric(
                        horizontal: AppConstants.paddingSuperLargeW -
                            AppConstants.paddingAppW,
                        vertical: AppConstants.paddingSuperLargeH -
                            AppConstants.paddingAppH,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: AppConstants.paddingLargeW,
                        vertical: AppConstants.paddingLargeH,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.whiteBackground,
                        borderRadius: BorderRadius.circular(
                            AppConstants.cornerRadiusFrame),
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

  Widget _buildNotifyLable() {
    return Center(
      child: Text(
        'Must to input height and weight',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
          color: AppColors.danger,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildMainButtons() {
    return BlocBuilder<BabyBloc, BabyState>(
        bloc: babyBloc,
        builder: (context, state) {
          if (state is BabyCreated) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MiniLineButton('Back', () {
                  Navigator.pop(context);
                }),
                SizedBox(width: AppConstants.paddingLargeW),
                MiniSolidButton('Next', () {
                  if (_formData['height'] == 0 || _formData['weight'] == 0) {
                    setState(() {
                      _isNotifyMust2Input = true;
                    });
                    return;
                  }

                  babyBloc.add(CreateBMI(listBMIModel: [
                    BmiModel(
                        idBaby: state.idBaby,
                        type: BMIType.Height,
                        value: _formData['height']),
                    BmiModel(
                        idBaby: state.idBaby,
                        type: BMIType.Weight,
                        value: _formData['weight'] * 100),
                  ]));

                  Navigator.pushNamed(
                    context,
                    CreateBabyNIView.routeName,
                  );
                }),
              ],
            );
          }
          return Container();
        });
  }
}
