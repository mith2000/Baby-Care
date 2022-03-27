import 'package:flutter/material.dart';
import 'package:flutter_babycare/utils/app_colors.dart';

class HandbookThemeView extends StatefulWidget {
  static const routeName = '/handbook-theme';

  const HandbookThemeView({Key key}) : super(key: key);

  @override
  _HandbookThemeViewState createState() => _HandbookThemeViewState();
}

class _HandbookThemeViewState extends State<HandbookThemeView> {
  @override
  Widget build(BuildContext context) {
    return Container(color: AppColors.background);
  }
}
