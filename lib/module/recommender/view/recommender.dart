import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../utils/app_colors.dart';

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
            return _buildFirstRecommend();
          } else if (index == 4) {
            return SizedBox(height: AppConstants.paddingSuperLargeH);
          } else {
            return _buildRecommendItems("On trend");
          }
        }),
      ),
    );
  }

  Widget _buildFirstRecommend() {
    return Stack(
      children: [
        FadeInImage.assetNetwork(
          placeholder: 'assets/image/default_baby.png',
          height: ScreenUtil().screenWidth,
          fit: BoxFit.cover,
          image:
              'https://vcdn1-giaitri.vnecdn.net/2022/05/12/doctor-strange-2.jpg?w=900&h=540&q=100&dpr=1&fit=crop&s=wrRoA7M4Vm1JL3UwNDZaDw',
        ),
      ],
    );
  }

  Widget _buildRecommendItems(String title) {
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
}
