import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/data/model/product/product_model.dart';
import 'package:flutter_babycare/data/model/product/rating_model.dart';
import 'package:flutter_babycare/module/recommender/bloc/recommender_bloc.dart';
import 'package:flutter_babycare/utils/UI_components/highlight_wrap_box.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../utils/app_colors.dart';
import '../../../utils/UI_components/error_label.dart';
import '../../../utils/UI_components/fullscreen_loading_widget.dart';
import '../../../utils/UI_components/solid_button.dart';
import '../../../utils/converter.dart';
import '../bloc/recommender_event.dart';
import '../bloc/recommender_state.dart';

class RecommenderView extends StatefulWidget {
  static const routeName = '/recommender';
  final User _user;

  const RecommenderView(User user, {Key key})
      : _user = user,
        super(key: key);

  @override
  _RecommenderViewState createState() => _RecommenderViewState();
}

class _RecommenderViewState extends State<RecommenderView> {
  RecommenderBloc recommenderBloc;

  @override
  void initState() {
    super.initState();
    _checkCanOpenRateSheet();

    recommenderBloc = BlocProvider.of<RecommenderBloc>(context);
    _loadListProduct();
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
          if (state is LoadedListHotAndSimilarProduct) {
            if (state.list == null) {
              return ErrorLabel(
                  label: 'Something error with our server. Please try again.');
            }
            return ListView.builder(
              itemCount: 4,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: ((BuildContext context, int index) {
                if (index == 0) {
                  if (state.list.listHotProduct == null ||
                      state.list.listHotProduct.length == 0) {
                    return Container();
                  }
                  return _buildFirstRecommend(state.list.listHotProduct[0]);
                } else if (index == 1) {
                  if (state.list.listHotProduct == null ||
                      state.list.listHotProduct.length == 0) {
                    return Container();
                  }
                  return _buildListProducts(
                      "On trend", state.list.listHotProduct);
                } else if (index == 2) {
                  if (state.list.listSimilarProduct == null ||
                      state.list.listSimilarProduct.length == 0) {
                    return Container();
                  }
                  return _buildListProducts(
                      "Because you love " +
                          state.list.listSimilarProduct[0].tagName,
                      state.list.listSimilarProduct);
                } else {
                  return SizedBox(height: AppConstants.paddingSuperLargeH);
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

  Widget _buildFirstRecommend(ProductModel product) {
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
        _openUrl(product.url);
      },
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
              style: Theme.of(context).textTheme.headline1,
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

  void _saveOpenedProduct(String id, String name) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('productId', id);
    prefs.setString('productName', name);
    prefs.setString('productIdForRecommend', id);
    print('SHARED PREF: ' + 'Save this product id: ' + id);
  }

  void _loadListProduct() async {
    String _savedId = await _getSavedProductId();
    recommenderBloc.add(LoadHotAndSimilarProduct(idProduct: _savedId));
  }

  Future<String> _getSavedProductId() async {
    final prefs = await SharedPreferences.getInstance();
    return await prefs.getString('productIdForRecommend') ?? '';
  }

  void _checkCanOpenRateSheet() async {
    final prefs = await SharedPreferences.getInstance();
    final productId = await prefs.getString('productId') ?? '';
    final productName = await prefs.getString('productName') ?? '';
    if (productId != '') {
      print('SHARED PREF: Saved product id ' + productId);
      _openRateBottomSheet(productId, productName);
    } else {
      print('SHARED PREF: ' + 'No saved product yet');
    }
  }

  void _openRateBottomSheet(String id, String name) async {
    final prefs = await SharedPreferences.getInstance();
    var _ratingPoint = 0.0;
    prefs.remove('productId');
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(AppConstants.paddingLargeW),
              child: RichText(
                text: new TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 16.sp,
                    color: AppColors.text,
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(text: 'You have opened '),
                    TextSpan(
                      text: name,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                        color: AppColors.primary,
                        height: 1.5,
                      ),
                    ),
                    TextSpan(
                      text: '.\nYour rating point',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: AppColors.primary,
                        height: 1.5,
                      ),
                    ),
                    TextSpan(text: ' for this product make us '),
                    TextSpan(
                      text: 'bring you good advice',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16.sp,
                        color: AppColors.primary,
                        height: 1.5,
                      ),
                    ),
                    TextSpan(text: ' later.'),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: AppConstants.paddingLargeW),
              child: RatingBar(
                initialRating: 3,
                itemCount: 5,
                ratingWidget: RatingWidget(
                  full: SvgPicture.asset('assets/icon/star_active.svg'),
                  empty: SvgPicture.asset('assets/icon/star_inactive.svg'),
                  half: SvgPicture.asset('assets/icon/star_inactive.svg'),
                ),
                itemPadding: EdgeInsets.symmetric(
                    horizontal: AppConstants.paddingSlightW),
                onRatingUpdate: (rating) {
                  _ratingPoint = rating;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(AppConstants.paddingLargeW),
              child: SolidButton('Send your rating', () {
                // todo Send rate to server
                print('Rated value: ' + _ratingPoint.toString());
                print('User id: ' + widget._user.uid);
                print('Product id: ' + id);
                recommenderBloc.add(CreateRating(
                    ratingModel: RatingModel(
                        idProduct: id,
                        userId: widget._user.uid,
                        ratePoint: _ratingPoint.round())));
                Navigator.pop(context);
              }),
            ),
          ],
        );
      },
    );
  }
}
