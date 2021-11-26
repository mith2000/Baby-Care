import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/utils/UI_components/mini_line_button.dart';
import 'package:flutter_babycare/utils/UI_components/mini_solid_button.dart';
import 'package:flutter_babycare/utils/UI_components/title_label.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

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
                          _buildInputLabel(
                              label: 'Height: ' +
                                  _formData['height'].toString() +
                                  'cm ~ ' +
                                  (_formData['height'].toDouble() / 100.0)
                                      .toString() +
                                  'm'),
                          _buildInputField(
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
                          _buildInputLabel(
                              label: 'Weight: ' +
                                  _formData['weight'].toString() +
                                  '00g ~ ' +
                                  (_formData['weight'].toDouble() / 10.0)
                                      .toString() +
                                  'kg'),
                          _buildInputField(
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

  Widget _buildInputLabel({Widget icon, String label}) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        icon == null ? Container() : icon,
        Text(
          label,
          style: Theme.of(context).textTheme.headline1,
        ),
      ],
    );
  }

  Widget _buildInputField(
      {@required int value,
      int min = 0,
      @required int max,
      double stepSize = 1,
      @required Function(dynamic) onChanged}) {
    return SfSliderTheme(
      data: SfSliderThemeData(
        thumbRadius: 16.w,
        inactiveTrackColor: AppColors.secondary,
      ),
      child: SfSlider(
        interval: 1.0,
        stepSize: stepSize,
        min: min,
        max: max,
        thumbIcon: Container(
          alignment: Alignment.center,
          child: Text(
            value.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16.sp,
              color: AppColors.whiteBackground,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        value: value,
        onChanged: (dynamic values) => onChanged(values),
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

          // weight submit to repository = weight * 100
        }),
      ],
    );
  }
}
