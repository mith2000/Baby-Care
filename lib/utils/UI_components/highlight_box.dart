import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_colors.dart';

class HighlightBox extends StatelessWidget {
  final double width;
  final String text;
  final Color boxColor;
  const HighlightBox(
    String text, {
    Key key,
    double width = 32,
    Color color = AppColors.danger,
  })  : this.width = width,
        this.text = text,
        this.boxColor = color,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 32.h,
      width: width.w,
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius:
            BorderRadius.circular(AppConstants.cornerRadiusHighlightBox),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 22.sp,
          color: AppColors.whiteBackground,
        ),
      ),
    );
  }
}
