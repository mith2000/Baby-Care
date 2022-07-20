import 'package:flutter/material.dart';
import 'package:flutter_babycare/data/model/product/product_model.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../constants/app_constants.dart';
import '../../../../utils/UI_components/appbar_primary.dart';
import '../../../../utils/UI_components/error_label.dart';
import '../../../../utils/UI_components/fullscreen_loading_widget.dart';
import '../../../../utils/UI_components/line_button.dart';
import '../../../../utils/UI_components/recommend_first.dart';
import '../../../../utils/UI_components/recommend_list.dart';
import '../../../../utils/app_colors.dart';
import '../../bloc/recommender_bloc.dart';
import '../../bloc/recommender_event.dart';
import '../../bloc/recommender_state.dart';

class ProductDetailArguments {
  final ProductModel product;

  ProductDetailArguments(this.product);
}

class ProductDetailView extends StatefulWidget {
  static const routeName = '/product-detail';

  const ProductDetailView({Key key}) : super(key: key);

  @override
  _ProductDetailViewState createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  RecommenderBloc recommenderBloc;

  @override
  void initState() {
    super.initState();
    recommenderBloc = BlocProvider.of<RecommenderBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context).settings.arguments as ProductDetailArguments;
    recommenderBloc.add(LoadListRecommendProduct(idProduct: args.product.id));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppbarPrimary(title: args.product.name),
      body: Stack(
        children: [
          Container(
            color: AppColors.background,
            child: BlocBuilder<RecommenderBloc, RecommenderState>(
              bloc: recommenderBloc,
              builder: (context, state) {
                if (state is RecommenderLoading) {
                  return FullScreenLoadingWidget();
                }
                if (state is LoadedListProduct) {
                  if (state.list == null) {
                    return ErrorLabel(
                        label:
                            'Something error with our server. Please try again.');
                  }
                  return ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemBuilder: ((BuildContext context, int index) {
                      if (index == 0) {
                        if (state.list == null || state.list.length == 0) {
                          return Container();
                        }
                        return RecommendFirstProduct(args.product, context);
                      } else if (index == 1) {
                        if (state.list == null || state.list.length == 0) {
                          return Container();
                        }
                        return RecommendListProduct(
                            "Because you love " + state.list[0].tagName,
                            state.list,
                            context);
                      } else {
                        return SizedBox(
                            height: AppConstants.paddingSuperLargeH * 2);
                      }
                    }),
                  );
                } else {
                  return ErrorLabel();
                }
              },
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildBackButton(),
            ],
          ),
        ],
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
        _loadListProduct();
        Navigator.pop(context);
      }),
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
}
