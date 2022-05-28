import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/data/model/product/product_model.dart';
import 'package:flutter_babycare/module/recommender/bloc/recommender_bloc.dart';
import 'package:flutter_babycare/utils/UI_components/highlight_wrap_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/app_colors.dart';
import '../../../utils/UI_components/error_label.dart';
import '../../../utils/UI_components/fullscreen_loading_widget.dart';
import '../../../utils/converter.dart';
import '../bloc/recommender_event.dart';
import '../bloc/recommender_state.dart';

class RecommenderView extends StatefulWidget {
  static const routeName = '/recommender';

  const RecommenderView({Key key}) : super(key: key);

  @override
  _RecommenderViewState createState() => _RecommenderViewState();
}

class _RecommenderViewState extends State<RecommenderView> {
  RecommenderBloc recommenderBloc;

  @override
  void initState() {
    super.initState();
    recommenderBloc = BlocProvider.of<RecommenderBloc>(context);
    recommenderBloc.add(LoadListHotProduct());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: BlocBuilder<RecommenderBloc, RecommenderState>(
        bloc: recommenderBloc,
        builder: (context, state) {
          if (state is RecommenderLoading) {
            return FullScreenLoadingWidget();
          }
          if (state is LoadedListProduct) {
            if (state.list == null || state.list.length == 0) {
              return ErrorLabel(
                  label: 'Something error with our server. Please try again.');
            }
            return ListView.builder(
              itemCount: 3,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: ((BuildContext context, int index) {
                if (index == 0) {
                  return BlocBuilder<RecommenderBloc, RecommenderState>(
                    bloc: recommenderBloc,
                    builder: (context, state) {
                      if (state is RecommenderLoading) {
                        return FullScreenLoadingWidget();
                      }
                      if (state is LoadedListProduct) {
                        if (state.list == null || state.list.length == 0) {
                          return ErrorLabel(
                              label:
                                  'Something error with our server. Please try again.');
                        }
                        return _buildFirstRecommend(
                            state.list[0].url,
                            state.list[0].primaryImage,
                            state.list[0].basePrice,
                            state.list[0].salePercent,
                            state.list[0].tagName,
                            state.list[0].ratePoint);
                      } else {
                        return ErrorLabel();
                      }
                    },
                  );
                } else if (index == 2) {
                  return SizedBox(height: AppConstants.paddingSuperLargeH);
                } else {
                  return _buildListProducts("On trend", state.list);
                }
              }),
            );
          } else {
            return ErrorLabel();
          }
        },
      ),
    );
  }

  Widget _buildFirstRecommend(
    String url,
    String image,
    int basePrice,
    int salePercent,
    String category,
    double starRated,
  ) {
    return Container(
      height: ScreenUtil().screenWidth,
      child: Stack(
        children: [
          FadeInImage.assetNetwork(
            placeholder: 'assets/image/default_baby.png',
            height: ScreenUtil().screenWidth,
            fit: BoxFit.cover,
            image: image,
            imageErrorBuilder: (BuildContext context, Object exception,
                StackTrace stackTrace) {
              return Image(
                height: ScreenUtil().screenWidth,
                fit: BoxFit.fitHeight,
                image: AssetImage('assets/image/default_baby.png'),
              );
            },
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildProductInfo(category, starRated),
              _buildPaymentInfo(basePrice, salePercent, url),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildListProducts(String title, List<ProductModel> products) {
    return Padding(
      padding: EdgeInsets.only(
          top: AppConstants.paddingLargeH, left: AppConstants.paddingNormalW),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headline1,
          ),
          Container(
            height: 327.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: ((BuildContext context, int index) {
                return _buildProductItem(
                    products[index].url,
                    products[index].primaryImage,
                    products[index].name,
                    products[index].basePrice,
                    products[index].salePercent,
                    products[index].ratePoint,
                    'Đã bán ' + products[index].totalBought.toString() + 'k');
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(
    String url,
    String image,
    String name,
    int basePrice,
    int salePercent,
    double starRated,
    String sold,
  ) {
    return InkWell(
      child: Container(
        color: AppColors.whiteBackground,
        width: 195.w,
        height: 319.h,
        margin: EdgeInsets.only(
            right: AppConstants.paddingNormalW,
            top: AppConstants.paddingNormalH),
        child: Column(
          children: [
            FadeInImage.assetNetwork(
              placeholder: 'assets/image/default_baby.png',
              height: 195.h,
              fit: BoxFit.fitHeight,
              image: image,
              imageErrorBuilder: (BuildContext context, Object exception,
                  StackTrace stackTrace) {
                return Image(
                  height: 195.h,
                  fit: BoxFit.fitHeight,
                  image: AssetImage('assets/image/default_baby.png'),
                );
              },
            ),
            Container(
              margin: EdgeInsets.only(
                left: AppConstants.paddingSlightW,
                right: AppConstants.paddingSlightW,
                top: AppConstants.paddingNormalH,
              ),
              child: Text(
                name,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16.sp,
                  color: AppColors.text,
                  height: 1.5,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                left: AppConstants.paddingSlightW,
                right: AppConstants.paddingSlightW,
                top: AppConstants.paddingSlightH,
              ),
              child: Row(
                children: [
                  Text(
                    Converter.priceToString(basePrice),
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: AppColors.stroke,
                      height: 1.57,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  SizedBox(width: AppConstants.paddingSlightW),
                  Text(
                    Converter.priceToString(
                        (basePrice * salePercent / 100).round()),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22.sp,
                      color: AppColors.primary,
                      height: 1.37,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 22.h,
              margin: EdgeInsets.only(
                left: AppConstants.paddingSlightW,
                right: AppConstants.paddingSlightW,
                top: AppConstants.paddingSlightH,
              ),
              child: Row(
                children: [
                  Container(
                    height: 16.h,
                    width: 100.w,
                    child: ListView.builder(
                      itemCount: 5,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: ((BuildContext context, int index) {
                        if (index + 1 <= starRated) {
                          return SvgPicture.asset(
                            'assets/icon/star_active.svg',
                            width: 16.w,
                            height: 16.h,
                          );
                        } else {
                          return SvgPicture.asset(
                            'assets/icon/star_inactive.svg',
                            width: 16.w,
                            height: 16.h,
                          );
                        }
                      }),
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                    sold,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14.sp,
                      color: AppColors.text,
                      height: 1.57,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        _openUrl(url);
      },
    );
  }

  Widget _buildPaymentInfo(int basePrice, int salePercent, String url) {
    return Container(
      margin: EdgeInsets.only(
          right: AppConstants.paddingLargeW,
          bottom: AppConstants.paddingLargeH),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            Converter.priceToString(basePrice),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
              color: AppColors.whiteBackground,
              decoration: TextDecoration.lineThrough,
            ),
          ),
          SizedBox(height: AppConstants.paddingSlightH),
          Row(
            children: [
              Text(
                Converter.priceToString(
                    (basePrice * salePercent / 100).round()),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 22.sp,
                  color: AppColors.whiteBackground,
                ),
              ),
              SizedBox(width: AppConstants.paddingNormalW),
              HighlightWrapBox('$salePercent%'),
            ],
          ),
          SizedBox(height: AppConstants.paddingNormalH),
          _buildShopNowButton(url),
        ],
      ),
    );
  }

  Widget _buildShopNowButton(String url) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: AppConstants.paddingNormalW),
        decoration: BoxDecoration(
          color: AppColors.whiteBackground,
          borderRadius:
              BorderRadius.circular(AppConstants.cornerRadiusHighlightBox),
        ),
        height: 48.h,
        child: Row(
          children: [
            SvgPicture.asset('assets/icon/shopee.svg'),
            SizedBox(width: AppConstants.paddingNormalW),
            Text(
              "Shop now",
              style: Theme.of(context).textTheme.headline1,
            ),
          ],
        ),
      ),
      onTap: () {
        _openUrl(url);
      },
    );
  }

  void _openUrl(String url) async {
    final _uri = Uri.parse(url);
    if (await canLaunchUrl(_uri)) {
      await launchUrl(_uri);
    } else {
      // can't launch url, there is some error
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.showSnackBar(
        SnackBar(
          content: Text('Could not open Shopee link'),
          action: SnackBarAction(
              label: 'Close', onPressed: scaffold.hideCurrentSnackBar),
        ),
      );
      throw "Could not launch $url";
    }
  }

  Widget _buildProductInfo(String category, double starRated) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            category,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
              color: AppColors.whiteBackground,
            ),
          ),
          SizedBox(height: AppConstants.paddingNormalH),
          Container(
            height: 40.h,
            margin: EdgeInsets.only(
                left: AppConstants.paddingNormalW,
                bottom: AppConstants.paddingLargeH),
            child: ListView.builder(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              itemBuilder: ((BuildContext context, int index) {
                if (index + 1 <= starRated) {
                  return SvgPicture.asset('assets/icon/star_active.svg');
                } else {
                  return SvgPicture.asset('assets/icon/star_inactive.svg');
                }
              }),
            ),
          ),
        ],
      ),
    );
  }
}
