import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/data/model/product/rating_model.dart';
import 'package:flutter_babycare/module/recommender/bloc/recommender_bloc.dart';
import 'package:flutter_babycare/module/recommender/detail/view/ProductDetail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../utils/app_colors.dart';
import '../../../utils/UI_components/error_label.dart';
import '../../../utils/UI_components/fullscreen_loading_widget.dart';
import '../../../utils/UI_components/recommend_first.dart';
import '../../../utils/UI_components/recommend_list.dart';
import '../../../utils/UI_components/solid_button.dart';
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
                  return RecommendFirstProduct(
                    state.list.listHotProduct[0],
                    context,
                    routeName: ProductDetailView.routeName,
                  );
                } else if (index == 1) {
                  if (state.list.listHotProduct == null ||
                      state.list.listHotProduct.length == 0) {
                    return Container();
                  }
                  return RecommendListProduct(
                    "On trend",
                    state.list.listHotProduct,
                    context,
                    routeName: ProductDetailView.routeName,
                  );
                } else if (index == 2) {
                  if (state.list.listSimilarProduct == null ||
                      state.list.listSimilarProduct.length == 0) {
                    return Container();
                  }
                  return RecommendListProduct(
                    "Because you love " +
                        state.list.listSimilarProduct[0].tagName,
                    state.list.listSimilarProduct,
                    context,
                    routeName: ProductDetailView.routeName,
                  );
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
