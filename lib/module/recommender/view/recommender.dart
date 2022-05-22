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
                'https://www.google.com/',
                1086000,
                50,
                'Xe đẩy  •  4 - 18 '
                    'tháng',
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
            image:
                'https://vcdn1-giaitri.vnecdn.net/2022/05/12/doctor-strange-2.jpg?w=900&h=540&q=100&dpr=1&fit=crop&s=wrRoA7M4Vm1JL3UwNDZaDw',
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
                return _buildProductItem();
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem() {
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
              height: 195.w,
              fit: BoxFit.fitHeight,
              image:
                  'https://vcdn1-giaitri.vnecdn.net/2022/05/12/doctor-strange-2.jpg?w=900&h=540&q=100&dpr=1&fit=crop&s=wrRoA7M4Vm1JL3UwNDZaDw',
            ),
          ],
        ),
      ),
      onTap: () {
        print("Navigate to Shop");
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
