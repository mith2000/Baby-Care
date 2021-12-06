import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/data/model/bmi_model.dart';
import 'package:flutter_babycare/module/home/bloc/baby_bloc.dart';
import 'package:flutter_babycare/module/home/bloc/baby_event.dart';
import 'package:flutter_babycare/module/home/bloc/baby_state.dart';
import 'package:flutter_babycare/utils/UI_components/custom_slider.dart';
import 'package:flutter_babycare/utils/UI_components/custom_slider_label.dart';
import 'package:flutter_babycare/utils/UI_components/error_label.dart';
import 'package:flutter_babycare/utils/UI_components/mini_line_button.dart';
import 'package:flutter_babycare/utils/UI_components/mini_solid_button.dart';
import 'package:flutter_babycare/utils/UI_components/title_label.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class UpdateBMIViewArguments {
  final BmiModel height;
  final BmiModel weight;

  UpdateBMIViewArguments(this.height, this.weight);
}

class UpdateBMIView extends StatefulWidget {
  static const routeName = '/update-bmi';

  const UpdateBMIView({Key key}) : super(key: key);

  @override
  _UpdateBMIViewState createState() => _UpdateBMIViewState();
}

class _UpdateBMIViewState extends State<UpdateBMIView> {
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
              'BMI Update',
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
              Center(
                child: Wrap(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          TitleLabel('How did your kid grow up?'),
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
    final args =
        ModalRoute.of(context).settings.arguments as UpdateBMIViewArguments;

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
              if (state is LoadBMIBaby) {
                return MiniSolidButton('Save', () {
                  if (_formData['height'] == 0 || _formData['weight'] == 0) {
                    setState(() {
                      _isNotifyMust2Input = true;
                    });
                    return;
                  }

                  babyBloc.add(
                    UpdateBMIEvent(
                      listBmi: [
                        BmiModel(
                            id: args.height.id,
                            idBaby: args.height.idBaby,
                            type: BMIType.Height,
                            value: _formData['height']),
                        BmiModel(
                            id: args.weight.id,
                            idBaby: args.weight.idBaby,
                            type: BMIType.Weight,
                            value: _formData['weight'] * 100),
                      ],
                    ),
                  );

                  Navigator.pop(context);
                });
              }
              return ErrorLabel();
            }),
      ],
    );
  }
}
