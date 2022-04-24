import 'package:flutter/material.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_constants.dart';

class OwnMessageCard extends StatelessWidget {
  final String text;

  OwnMessageCard(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: ScreenUtil().screenWidth * 0.7),
        child: Card(
          margin: EdgeInsets.only(top: AppConstants.paddingSlightH),
          shape: RoundedRectangleBorder(
              borderRadius:
                  BorderRadius.circular(AppConstants.cornerRadiusFrame)),
          color: AppColors.secondary,
          child: Padding(
            padding: EdgeInsets.all(AppConstants.paddingNormalW),
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
      ),
    );
  }
}
