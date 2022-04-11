import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_colors.dart';

class AppbarPrimary extends StatelessWidget with PreferredSizeWidget {
  final String title;
  final double height =
      AppConstants.paddingAppH + AppConstants.paddingSuperLargeH;

  AppbarPrimary({
    Key key,
    @required String title,
  })  : this.title = title,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          height: 32.h,
          alignment: Alignment.bottomCenter,
          margin: EdgeInsets.only(left: AppConstants.paddingAppW),
          child: Text(
            title,
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
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
