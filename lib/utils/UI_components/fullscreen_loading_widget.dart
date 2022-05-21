import 'package:flutter/material.dart';

import '../app_colors.dart';

class FullScreenLoadingWidget extends StatelessWidget {
  const FullScreenLoadingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      height: double.infinity,
      width: double.infinity,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      ),
    );
  }
}
