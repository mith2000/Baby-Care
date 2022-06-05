import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_constants.dart';
import '../../data/model/product/product_model.dart';
import '../../module/recommender/detail/view/ProductDetail.dart';
import '../app_colors.dart';
import '../converter.dart';

class RecommendListProduct extends StatelessWidget {
  final String title;
  final List<ProductModel> products;
  final BuildContext parentContext;
  final String routeName;

  RecommendListProduct(
      String title, List<ProductModel> products, BuildContext context,
      {Key key, String routeName})
      : this.title = title,
        this.products = products,
        this.parentContext = context,
        this.routeName = routeName,
        super(key: key);

  @override
  Widget build(BuildContext context) {
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
                return _buildProductItem(products[index]);
              }),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductItem(ProductModel product) {
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
              image: product.primaryImage,
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
                product.name,
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
                    Converter.priceToString(product.basePrice),
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
                        (product.basePrice * (100 - product.salePercent) / 100)
                            .round()),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22.sp,
                      color: AppColors.primary,
                      height: 1.37,
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
                        if (index + 1 <= product.ratePoint) {
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
                    "Đã bán " + product.totalBought.toString(),
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
        _saveOpenedProduct(product.id, product.name);
        if (routeName == null) {
          _openUrl(product.url);
        } else {
          Navigator.pushNamed(parentContext, routeName,
              arguments: ProductDetailArguments(product));
        }
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
