import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/module/handbook/article/view/article_view.dart';
import 'package:flutter_babycare/module/handbook/bloc/handbook_bloc.dart';
import 'package:flutter_babycare/module/handbook/bloc/handbook_event.dart';
import 'package:flutter_babycare/module/handbook/bloc/handbook_state.dart';
import 'package:flutter_babycare/utils/UI_components/error_label.dart';
import 'package:flutter_babycare/utils/UI_components/highlight_expandable_box.dart';
import 'package:flutter_babycare/utils/UI_components/line_button.dart';
import 'package:flutter_babycare/utils/UI_components/loading_widget.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  HandBookBloc handbookBloc;

  @override
  void initState() {
    super.initState();
    handbookBloc = BlocProvider.of<HandBookBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as ListArticleViewArguments;
    handbookBloc.add(LoadListArticle(themeID: args.themeId));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: AppColors.background,
        child: Stack(
          children: [
            ListView(
              children: [
                Container(
                  child: BlocBuilder<HandBookBloc, HandBookState>(
                    bloc: handbookBloc,
                    builder: (context, state) {
                      if (state is HandBookLoading) {
                        return CustomLoadingWidget();
                      }
                      if (state is LoadedListArticle) {
                        if (state.list == null || state.list.length == 0) {
                          return ErrorLabel(label: 'No Tip available now');
                        }
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: state.list.length,
                          itemBuilder: (context, index) {
                            return _buildArticleButton(
                              title: state.list[index].title,
                              induction: state.list[index].induction,
                              category: state.list[index].category,
                              action: () {
                                Navigator.pushNamed(
                                    context, ArticleView.routeName,
                                    arguments: ArticleViewArguments(
                                        state.list[index].id));
                              },
                              image: AssetImage(state.list[index].urlImage),
                            );
                          },
                        );
                      } else {
                        return ErrorLabel();
                      }
                    },
                  ),
                  margin: EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingLargeW,
                    vertical: AppConstants.paddingNormalH,
                  ),
                ),
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

  Widget _buildArticleButton({
    String title,
    String induction,
    String category,
    Function action,
    ImageProvider image,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: AppConstants.paddingNormalH),
      child: ElevatedButton(
        onPressed: action,
        child: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100.h,
                child: Column(
                  children: [
                    Container(
                      height: 100.h,
                      width: double.infinity,
                      margin:
                          EdgeInsets.only(bottom: AppConstants.paddingNormalH),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            AppConstants.cornerRadiusFrame),
                        child: Image(
                          width: double.infinity,
                          fit: BoxFit.cover,
                          image: image,
                        ),
                      ),
                    ),
                    HighlightExpandableBox(
                      category,
                      width: double.infinity,
                      color: AppColors.primary,
                    ),
                  ],
                ),
              ),
              SizedBox(width: AppConstants.paddingLargeW),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 24.sp,
                          color: AppColors.text,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(height: AppConstants.paddingNormalH),
                    Container(
                      child: Text(
                        induction,
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: AppColors.text,
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          padding: EdgeInsets.all(AppConstants.paddingLargeH),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size.zero,
          padding: EdgeInsets.zero,
          primary: AppColors.whiteBackground,
          onPrimary: AppColors.lineButtonPress,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.cornerRadiusFrame),
            side: BorderSide(
              width: 1.w,
              color: AppColors.stroke,
            ),
          ),
        ),
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
