import 'package:flutter/material.dart';

import '../app_colors.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.background,
      child: Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
        ),
      ),
    );
  }
}
