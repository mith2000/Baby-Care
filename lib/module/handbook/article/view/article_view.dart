import 'package:flutter/material.dart';
import 'package:flutter_babycare/utils/app_colors.dart';

class ArticleView extends StatefulWidget {
  static const routeName = '/article';

  const ArticleView({Key key}) : super(key: key);

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  @override
  Widget build(BuildContext context) {
    return Container(color: AppColors.background);
  }
}
