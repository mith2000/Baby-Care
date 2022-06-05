import 'package:flutter/material.dart';
import 'package:flutter_babycare/utils/UI_components/highlight_wrap_box.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_constants.dart';
import '../../data/model/product/product_model.dart';
import '../app_colors.dart';
import '../converter.dart';

class RecommendFirstProduct extends StatelessWidget {
  final ProductModel product;
  final BuildContext parentContext;

  RecommendFirstProduct(ProductModel product, BuildContext context, {Key key})
      : this.product = product,
        this.parentContext = context,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().screenWidth,
      child: Stack(
        children: [
          FadeInImage.assetNetwork(
            placeholder: 'assets/image/default_baby.png',
            height: ScreenUtil().screenWidth,
            fit: BoxFit.cover,
            image: product.primaryImage,
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
              _buildProductInfo(
                product.tagName,
                product.ratePoint,
              ),
              _buildPaymentInfo(
                product.id,
                product.name,
                product.basePrice,
                product.salePercent,
                product.url,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductInfo(
    String category,
    double starRated,
  ) {
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

  Widget _buildPaymentInfo(
    String id,
    String name,
    int basePrice,
    int salePercent,
    String url,
  ) {
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
                    (basePrice * (100 - salePercent) / 100).round()),
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
          _buildShopNowButton(id, name, url),
        ],
      ),
    );
  }

  Widget _buildShopNowButton(String id, String name, String url) {
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
              style: Theme.of(parentContext).textTheme.headline1,
            ),
          ],
        ),
      ),
      onTap: () {
        _saveOpenedProduct(id, name);
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
      final scaffold = ScaffoldMessenger.of(parentContext);
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

  void _saveOpenedProduct(String id, String name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('productId', id);
    prefs.setString('productName', name);
    prefs.setString('productIdForRecommend', id);
    print('SHARED PREF: ' + 'Save this product id: ' + id);
  }
}
