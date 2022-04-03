import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
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
                _buildTitleLabel('Trẻ sơ sinh',
                    'Những điều cần chú ý khi tiêm vắc xin cho trẻ dưới 6 tháng'),
                _buildCategoryTag('type vaccine'),
                _buildInduction('Tiêm phòng đầy đủ và đúng lịch là cách tốt '
                    'nhất giúp trẻ phòng tránh bệnh tật. Dưới đây là những '
                    'lưu ý quan trọng bố mẹ cần ghi nhớ khi đưa trẻ đi tiêm phòng'),
                _buildArticleSection(
                    'Header 1 Header 1 Header 1 Header 1 Header 1 Header 1 ',
                    'https://i.pinimg.com/736x/7f/49/95/7f4995b970f96ec2dd7cf305d298284f.jpg',
                    'Image 1 description',
                    'Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 '),
                _buildArticleSection(
                    'Header 1 Header 1 Header 1 Header 1 Header 1 Header 1 ',
                    null,
                    null,
                    'Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 '),
                _buildArticleSection(
                    'Header 1 Header 1 Header 1 Header 1 Header 1 Header 1 ',
                    'https://i.pinimg.com/736x/7f/49/95/7f4995b970f96ec2dd7cf305d298284f.jpg',
                    'Image 1 description',
                    null),
                _buildArticleSection(
                    'Header 1 Header 1 Header 1 Header 1 Header 1 Header 1 ',
                    null,
                    null,
                    null),
                _buildArticleSection(
                    'Header 1 Header 1 Header 1 Header 1 Header 1 Header 1 ',
                    'https://i.pinimg.com/736x/7f/49/95/7f4995b970f96ec2dd7cf305d298284f.jpg',
                    'Image 1 description',
                    'Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 Body 1 '),
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

  Widget _buildTitleLabel(String theme, String title) {
    return Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingLargeW,
        vertical: AppConstants.paddingNormalH,
      ),
      margin: EdgeInsets.only(
        left: AppConstants.paddingLargeW,
        right: AppConstants.paddingLargeW,
        top: AppConstants.paddingLargeH,
      ),
      child: Text(
        theme + ' -> ' + title,
        style: Theme.of(context).textTheme.caption,
        textAlign: TextAlign.start,
      ),
      decoration: BoxDecoration(
        color: AppColors.whiteBackground,
        borderRadius: BorderRadius.circular(AppConstants.cornerRadiusFrame),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 4,
            offset: Offset(0, 4), // changes position of shadow
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTag(String category) {
    return Row(
      children: [
        Container(
          height: 32.h,
          alignment: Alignment.center,
          margin: EdgeInsets.only(
            left: AppConstants.paddingLargeW,
            right: AppConstants.paddingLargeW,
            top: AppConstants.paddingLargeH,
          ),
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.paddingNormalW,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary,
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
            category,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 22.sp,
              color: AppColors.whiteBackground,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Expanded(child: Container())
      ],
    );
  }

  Widget _buildInduction(String induction) {
    return Container(
      margin: EdgeInsets.only(
        left: AppConstants.paddingLargeW,
        right: AppConstants.paddingLargeW,
        top: AppConstants.paddingLargeH,
      ),
      child: Text(
        induction,
        style: Theme.of(context).textTheme.headline1,
        textAlign: TextAlign.start,
      ),
    );
  }

  Widget _buildArticleSection(
      String header, String imageLink, String imageDescription, String body) {
    return Column(
      children: [
        if (header != null) _buildHeader(header),
        if (imageLink != null) _buildImage(imageLink),
        if (imageDescription != null) _buildImageDescription(imageDescription),
        if (body != null) _buildArticleBody(body),
      ],
    );
  }

  Widget _buildHeader(String header) {
    return Container(
      margin: EdgeInsets.only(
        left: AppConstants.paddingLargeW,
        right: AppConstants.paddingLargeW,
        top: AppConstants.paddingLargeH,
      ),
      child: Text(
        header,
        textAlign: TextAlign.start,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 24.sp,
          color: AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildImage(String imageLink) {
    return Container(
      margin: EdgeInsets.only(
        top: AppConstants.paddingLargeH,
      ),
      child: FadeInImage.assetNetwork(
        placeholder: 'assets/image/default_baby.png',
        height: ScreenUtil().screenWidth,
        fit: BoxFit.cover,
        image: imageLink,
      ),
    );
  }

  Widget _buildImageDescription(String imageDescription) {
    return Container(
      margin: EdgeInsets.only(
        top: AppConstants.paddingNormalH,
      ),
      child: Text(
        imageDescription,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  Widget _buildArticleBody(String body) {
    return Container(
      margin: EdgeInsets.only(
        left: AppConstants.paddingLargeW,
        right: AppConstants.paddingLargeW,
        top: AppConstants.paddingLargeH,
      ),
      child: Text(
        body,
        textAlign: TextAlign.start,
        style: Theme.of(context).textTheme.bodyText1,
      ),
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
