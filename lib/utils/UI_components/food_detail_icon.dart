import 'package:flutter/material.dart';
import 'package:flutter_babycare/data/model/baby/food_model.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/app_constants.dart';
import '../../data/model/baby/food_model.dart';
import '../converter.dart';

class FoodDetailIcon extends StatelessWidget {
  final FoodModel item;

  const FoodDetailIcon(FoodModel item, {Key key})
      : this.item = item,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, String> _icons = {
      'porridge': 'assets/icon/porridge.svg',
      'milk': 'assets/icon/milk.svg',
      'meat': 'assets/icon/meat.svg',
      'fish': 'assets/icon/fish.svg',
      'egg': 'assets/icon/egg.svg',
      'green_vegets': 'assets/icon/green_vegets.svg',
      'red_vegets': 'assets/icon/red_vegets.svg',
      'citrus_fruit': 'assets/icon/citrus_fruit.svg',
    };

    return Container(
      // this container for spacing food icon eventually
      width: 92.w,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            _icons[Converter.FoodTypeToIconNameString(item.type)],
            width: 40.w,
            height: 40.w,
          ),
          SizedBox(width: AppConstants.paddingSlightW),
          Expanded(
            child: Text(
              item.value < 1000
                  ? (item.value.toInt().toString() +
                      Converter.FoodTypeToUnitString(item.type))
                  : ('999' + Converter.FoodTypeToUnitString(item.type)),
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ],
      ),
    );
  }
}
