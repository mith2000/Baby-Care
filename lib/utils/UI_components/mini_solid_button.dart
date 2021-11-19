import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_colors.dart';

class MiniSolidButton extends StatelessWidget {
  final String label;
  final Function action;
  MiniSolidButton(this.label, this.action, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 183.w,
      height: 64.h,
      child: ElevatedButton(
        onPressed: action,
        child: Text(
          label,
          style: Theme.of(context).textTheme.button,
          textAlign: TextAlign.center,
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          primary: AppColors.primary,
          onPrimary: AppColors.solidButtonPress,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
          ),
        ),
      ),
    );
  }
}
