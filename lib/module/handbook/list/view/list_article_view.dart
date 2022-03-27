import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListArticleViewArguments {
  final String themeId;

  ListArticleViewArguments(this.themeId);
}

class ListArticleView extends StatefulWidget {
  static const routeName = '/list-article';

  const ListArticleView({Key key}) : super(key: key);

  @override
  _ListArticleViewState createState() => _ListArticleViewState();
}

class _ListArticleViewState extends State<ListArticleView> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as ListArticleViewArguments;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingAppW,
        vertical: AppConstants.paddingAppH,
      ),
      color: AppColors.background,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ScrollPhysics(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return _buildThemeButton(
            themeName: args.themeId,
            themeDescription: 'Theme Description',
            action: () {
              Navigator.pushNamed(context, ListArticleView.routeName,
                  arguments: ListArticleViewArguments("themeId"));
            },
            image: AssetImage('assets/image/default_baby.png'),
            isRedFrame: index % 2 == 1 ? true : false,
          );
        },
      ),
    );
  }

  Widget _buildThemeButton({
    String themeName,
    String themeDescription,
    Function action,
    ImageProvider image,
    bool isRedFrame = false,
  }) {
    return Container(
      height: 132.h,
      margin: EdgeInsets.symmetric(vertical: AppConstants.paddingNormalH),
      child: ElevatedButton(
        onPressed: action,
        child: Container(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        themeName,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 24.sp,
                          color: AppColors.whiteBackground,
                        ),
                      ),
                    ),
                    SizedBox(height: AppConstants.paddingNormalH),
                    Container(
                      child: Text(
                        themeDescription,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 22.sp,
                          color: AppColors.whiteBackground,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: AppConstants.paddingNormalW),
              Container(
                height: double.infinity,
                margin: EdgeInsets.only(
                    top: AppConstants.paddingNormalH,
                    bottom: AppConstants.paddingLargeH),
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular(AppConstants.cornerRadiusFrame),
                  child: Image(
                    width: 100.w,
                    fit: BoxFit.cover,
                    image: image,
                  ),
                ),
              ),
            ],
          ),
          padding: EdgeInsets.only(
            top: AppConstants.paddingNormalH,
            left: AppConstants.paddingLargeW,
            right: AppConstants.paddingLargeW,
          ),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isRedFrame == false
                  ? [
                      AppColors.primary,
                      AppColors.secondary,
                    ]
                  : [
                      AppColors.danger,
                      AppColors.highlighter,
                    ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(AppConstants.cornerRadiusFrame),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 4,
                offset: Offset(0, 4), // changes position of shadow
              ),
            ],
          ),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          primary: AppColors.primary,
          onPrimary: AppColors.solidButtonPress,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.cornerRadiusFrame),
          ),
        ),
      ),
    );
  }
}
