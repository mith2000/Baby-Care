import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/module/baby/detail/view/detail_view.dart';
import 'package:flutter_babycare/utils/UI_components/line_button.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArticleView extends StatefulWidget {
  static const routeName = '/article';

  const ArticleView({Key key}) : super(key: key);

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: AppColors.background,
        child: Stack(
          children: [
            ListView(
              children: [
                _buildImage(""),
                SizedBox(height: AppConstants.paddingLargeH),
                SizedBox(height: AppConstants.paddingSuperLargeH * 2),
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildBackButton(),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String imageLink) {
    return FadeInImage.assetNetwork(
      placeholder: 'assets/image/default_baby.png',
      height: ScreenUtil().screenWidth,
      fit: BoxFit.cover,
      image: imageLink,
    );
  }

  Widget _buildBackButton() {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingAppW,
        vertical: AppConstants.paddingAppH,
      ),
      child: LineButton('Back', () {
        Navigator.pop(context);
      }),
    );
  }
}
