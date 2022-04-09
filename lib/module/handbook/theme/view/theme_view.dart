import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/module/handbook/bloc/handbook_bloc.dart';
import 'package:flutter_babycare/module/handbook/bloc/handbook_event.dart';
import 'package:flutter_babycare/module/handbook/bloc/handbook_state.dart';
import 'package:flutter_babycare/module/handbook/list/view/list_article_view.dart';
import 'package:flutter_babycare/utils/UI_components/error_label.dart';
import 'package:flutter_babycare/utils/UI_components/loading_widget.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HandbookThemeView extends StatefulWidget {
  static const routeName = '/handbook-theme';

  const HandbookThemeView({Key key}) : super(key: key);

  @override
  _HandbookThemeViewState createState() => _HandbookThemeViewState();
}

class _HandbookThemeViewState extends State<HandbookThemeView> {
  HandBookBloc handbookBloc;

  @override
  void initState() {
    super.initState();
    handbookBloc = BlocProvider.of<HandBookBloc>(context);
    handbookBloc.add(LoadThemeHandBook());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppConstants.paddingAppW,
        vertical: AppConstants.paddingAppH,
      ),
      color: AppColors.background,
      child: BlocBuilder<HandBookBloc, HandBookState>(
        bloc: handbookBloc,
        builder: (context, state) {
          if (state is HandBookLoading) {
            return CustomLoadingWidget();
          }
          if (state is LoadedTheme) {
            if (state.list == null || state.list.length == 0) {
              return ErrorLabel(label: 'No Handbook theme available now');
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: state.list.length,
              itemBuilder: (context, index) {
                return _buildThemeButton(
                  title: state.list[index].title,
                  description: state.list[index].description,
                  action: () {
                    print(state.list[index].id);
                    Navigator.pushNamed(
                      context,
                      ListArticleView.routeName,
                      arguments: ListArticleViewArguments(
                        state.list[index].id,
                        state.list[index].title,
                      ),
                    );
                  },
                  imageUrl: state.list[index].urlImage,
                  isRedFrame: index % 2 == 1 ? true : false,
                );
              },
            );
          } else {
            return ErrorLabel();
          }
        },
      ),
    );
  }

  Widget _buildThemeButton({
    String title,
    String description,
    Function action,
    String imageUrl,
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
                        title,
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
                        description,
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
                  child: imageUrl == null
                      ? Container(
                          width: 100.w,
                        )
                      : FadeInImage.assetNetwork(
                          placeholder: 'assets/image/default_baby.png',
                          width: 100.w,
                          fit: BoxFit.cover,
                          image: imageUrl,
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
