import 'package:flutter/material.dart';
import 'package:flutter_babycare/constants/app_constants.dart';

class ErrorLabel extends StatelessWidget {
  final String label;
  const ErrorLabel(String label, {Key key})
      : this.label = label,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: AppConstants.paddingLargeH),
        child: Text(
          label,
          style: Theme.of(context).textTheme.headline1,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
