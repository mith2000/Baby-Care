import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../app_colors.dart';

class CustomSlider extends StatelessWidget {
  final int value;
  final int min;
  final int max;
  final double stepSize;
  final Function(dynamic) onChanged;
  const CustomSlider({
    Key key,
    @required int value,
    int min = 0,
    @required int max,
    double stepSize = 1,
    @required Function(dynamic) onChanged,
  })  : this.value = value,
        this.min = min,
        this.max = max,
        this.stepSize = stepSize,
        this.onChanged = onChanged,
        super(key: key);

  @override
  Widget build(BuildContext context) {
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
}
