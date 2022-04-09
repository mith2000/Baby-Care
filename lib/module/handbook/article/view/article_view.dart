import 'package:flutter/material.dart';
import '../../../../constants/app_constants.dart';
import '../../bloc/handbook_bloc.dart';
import '../../bloc/handbook_event.dart';
import '../../bloc/handbook_state.dart';
import '../../../../utils/UI_components/error_label.dart';
import '../../../../utils/UI_components/line_button.dart';
import '../../../../utils/UI_components/loading_widget.dart';
import '../../../../utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ArticleViewArguments {
  final String themeName;
  final String idTip;
  final String themeId;

  ArticleViewArguments(this.themeName, this.idTip, this.themeId);
}

class ArticleView extends StatefulWidget {
  static const routeName = '/article';

  const ArticleView({Key key}) : super(key: key);

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  HandBookBloc handbookBloc;

  @override
  void initState() {
    super.initState();
    handbookBloc = BlocProvider.of<HandBookBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as ArticleViewArguments;
    handbookBloc.add(LoadArticle(idTip: args.idTip));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: AppColors.background,
        child: Stack(
          children: [
            BlocBuilder<HandBookBloc, HandBookState>(
              bloc: handbookBloc,
              builder: (context, state) {
                if (state is HandBookLoading) {
                  return CustomLoadingWidget();
                }
                if (state is LoadedArticle) {
                  if (state.articleModel == null) {
                    return ErrorLabel(label: 'Load article error');
                  }
                  return ListView(
                    children: [
                      _buildTitleLabel(
                          args.themeName, state.articleModel.title),
                      _buildCategoryTag(state.articleModel.category),
                      _buildInduction(state.articleModel.introduction),
                      _buildArticleSection(
                          state.articleModel.header1,
                          state.articleModel.image1,
                          null,
                          state.articleModel.body1),
                      _buildArticleSection(
                          state.articleModel.header2,
                          state.articleModel.image2,
                          null,
                          state.articleModel.body2),
                      _buildArticleSection(
                          state.articleModel.header3,
                          state.articleModel.image3,
                          null,
                          state.articleModel.body3),
                      _buildArticleSection(
                          state.articleModel.header4,
                          state.articleModel.image4,
                          null,
                          state.articleModel.body4),
                      _buildArticleSection(
                          state.articleModel.header5,
                          state.articleModel.image5,
                          null,
                          state.articleModel.body5),
                      SizedBox(height: AppConstants.paddingLargeH),
                      SizedBox(height: AppConstants.paddingSuperLargeH * 2),
                    ],
                  );
                } else {
                  return ErrorLabel();
                }
              },
            ),
            Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildBackButton(args.themeId),
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
        if (header != null && header.isNotEmpty) _buildHeader(header),
        if (imageLink != null && imageLink.isNotEmpty) _buildImage(imageLink),
        if (imageDescription != null && imageDescription.isNotEmpty)
          _buildImageDescription(imageDescription),
        if (body != null && body.isNotEmpty) _buildArticleBody(body),
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

  Widget _buildBackButton(String themeId) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingAppW,
        vertical: AppConstants.paddingAppH,
      ),
      child: LineButton('Back', () {
        handbookBloc.add(LoadListArticle(themeID: themeId));
        Navigator.pop(context);
      }),
    );
  }
}
