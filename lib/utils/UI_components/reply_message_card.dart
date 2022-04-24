import 'package:flutter/material.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/app_constants.dart';

class ReplyMessageCard extends StatelessWidget {
  final String text;

  ReplyMessageCard(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          CircleAvatar(
            radius: 20.w,
            backgroundImage: AssetImage('assets/image/logo_s150.png'),
          ),
          SizedBox(width: AppConstants.paddingNormalW),
          ConstrainedBox(
            constraints: BoxConstraints(
                maxWidth: ScreenUtil().screenWidth * 0.7 -
                    AppConstants.paddingSuperLargeW),
            child: Card(
              margin: EdgeInsets.only(top: AppConstants.paddingSlightH),
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(AppConstants.cornerRadiusFrame)),
              color: AppColors.stroke,
              child: Padding(
                padding: EdgeInsets.all(AppConstants.paddingNormalW),
                child: Text(
                  text,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
