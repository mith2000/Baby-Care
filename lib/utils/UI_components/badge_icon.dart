import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../app_colors.dart';

class BadgeIcon extends StatelessWidget {
  final double size = 20;
  final double xOffset;
  const BadgeIcon({Key key, double xOffset = 0})
      : this.xOffset = xOffset,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: -(size / 2).w + AppConstants.paddingLargeW + xOffset,
      top: -(size / 2).h + AppConstants.paddingNormalH,
      child: Container(
        width: size.w,
        height: size.h,
        decoration: BoxDecoration(
          color: AppColors.danger,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
