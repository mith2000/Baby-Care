import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_colors.dart';

class HighlightExpandableBox extends StatelessWidget {
  final double width;
  final String text;
  final Color boxColor;
  const HighlightExpandableBox(
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
      padding: EdgeInsets.symmetric(vertical: AppConstants.paddingSlightH),
      width: width.w,
      decoration: BoxDecoration(
        color: boxColor,
        borderRadius:
            BorderRadius.circular(AppConstants.cornerRadiusHighlightBox),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 22.sp,
          color: AppColors.whiteBackground,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
