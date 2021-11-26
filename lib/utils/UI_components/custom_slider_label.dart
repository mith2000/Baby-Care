import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';

class CustomSliderLabel extends StatelessWidget {
  final Widget icon;
  final String label;
  const CustomSliderLabel({Key key, Widget icon, String label})
      : this.icon = icon,
        this.label = label,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        icon == null
            ? Container()
            : Row(
                children: [
                  icon,
                  SizedBox(width: AppConstants.paddingNormalW),
                ],
              ),
        Text(
          label,
          style: Theme.of(context).textTheme.headline1,
        ),
      ],
    );
  }
}
