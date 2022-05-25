import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/utils/UI_components/highlight_wrap_box.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/app_colors.dart';
import '../../../utils/converter.dart';

class RecommenderView extends StatefulWidget {
  static const routeName = '/recommender';

  const RecommenderView({Key key}) : super(key: key);

  @override
  _RecommenderViewState createState() => _RecommenderViewState();
}

class _RecommenderViewState extends State<RecommenderView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemBuilder: ((BuildContext context, int index) {
          if (index == 0) {
            return _buildFirstRecommend(
                'https://shopee.vn/-M%C3%A3-FMCGHOT-10-%C4%91%C6%A1n-400K-Mi%E1%BA%BFng-l%C3%B3t-s%C6%A1-sinh-Bobby-Newborn-1-108-mi%E1%BA%BFng-i.63521925.6816312877?sp_atk=e097e93d-e715-4ff5-b692-9383171c8f31&xptdk=e097e93d-e715-4ff5-b692-9383171c8f31',
                'https://cf.shopee.vn/file/4d49b176c38969cc3260e7f95d89c224',
                1086000,
                50,
                'Tã giấy',
                4.0);
          } else if (index == 4) {
            return SizedBox(height: AppConstants.paddingSuperLargeH);
          } else {
            return _buildListProducts("On trend");
          }
        }),
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

  Widget _buildListProducts(String title) {
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
              itemCount: 5,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: ((BuildContext context, int index) {
                return _buildProductItem(
                    'https://shopee.vn/-M%C3%A3-FMCGHOT-10-%C4%91%C6%A1n-400K-Mi%E1%BA%BFng-l%C3%B3t-s%C6%A1-sinh-Bobby-Newborn-1-108-mi%E1%BA%BFng-i.63521925.6816312877?sp_atk=e097e93d-e715-4ff5-b692-9383171c8f31&xptdk=e097e93d-e715-4ff5-b692-9383171c8f31',
                    'https://cf.shopee.vn/file/3445f34aabbb827251299a306b42fff9',
                    'Miếng lót Bobby Newborn 1 - 108 miếng - Tặng thêm',
                    219000,
                    50,
                    4.0,
                    'Đã bán 1,6k');
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
