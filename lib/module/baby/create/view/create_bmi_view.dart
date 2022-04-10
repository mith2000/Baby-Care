import 'package:flutter/material.dart';
import '../../../../constants/app_constants.dart';
import '../../../../data/model/baby/bmi_model.dart';
import '../../../home/bloc/baby_bloc.dart';
import '../../../home/bloc/baby_event.dart';
import '../../../home/bloc/baby_state.dart';
import '../../../../utils/UI_components/custom_slider.dart';
import '../../../../utils/UI_components/custom_slider_label.dart';
import '../../../../utils/UI_components/error_label.dart';
import '../../../../utils/UI_components/loading_widget.dart';
import '../../../../utils/UI_components/mini_line_button.dart';
import '../../../../utils/UI_components/mini_solid_button.dart';
import '../../../../utils/UI_components/title_label.dart';
import '../../../../utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'create_food_view.dart';

class CreateBabyBMIViewArguments {
  final String idBaby;

  CreateBabyBMIViewArguments(
    this.idBaby,
  );
}

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
    final args =
        ModalRoute.of(context).settings.arguments as CreateBabyBMIViewArguments;
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
                  _buildMainButtons(args),
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

  Widget _buildMainButtons(args) {
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
              if (state is BabyLoading) {
                return CustomLoadingWidget();
              }
              if (state is LoadedBaby) {
                return MiniSolidButton('Next', () {
                  if (_formData['height'] == 0 || _formData['weight'] == 0) {
                    setState(() {
                      _isNotifyMust2Input = true;
                    });
                    return;
                  }
                  babyBloc.add(CreateBMI(listBMIModel: [
                    BmiModel(
                        idBaby: args.idBaby,
                        type: BMIType.Height,
                        updateDate: DateTime.now(),
                        value: _formData['height']),
                    BmiModel(
                        idBaby: args.idBaby,
                        type: BMIType.Weight,
                        updateDate: DateTime.now(),
                        value: _formData['weight'] * 100),
                  ]));

                  Navigator.pushNamed(
                    context,
                    CreateBabyFoodView.routeName,
                  );
                });
              }
              return ErrorLabel();
            }),
      ],
    );
  }
}
