import 'package:flutter/material.dart';

import '../../constants/app_constants.dart';
import '../app_colors.dart';

class ErrorLabel extends StatelessWidget {
  final String label;
  const ErrorLabel({
    Key key,
    String label,
  })  : this.label = label,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return label != null
        ? Center(
            child: Container(
              margin:
                  EdgeInsets.symmetric(vertical: AppConstants.paddingLargeH),
              child: Text(
                label,
                style: Theme.of(context).textTheme.headline1,
                textAlign: TextAlign.center,
              ),
            ),
          )
        : Wrap(
            children: [
              Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
                ),
              )
            ],
          );
  }
}
