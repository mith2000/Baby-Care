import 'package:flutter/material.dart';
import 'package:flutter_babycare/utils/app_colors.dart';

class ListArticleView extends StatefulWidget {
  static const routeName = '/sam-ple';

  const ListArticleView({Key key}) : super(key: key);

  @override
  _ListArticleViewState createState() => _ListArticleViewState();
}

class _ListArticleViewState extends State<ListArticleView> {
  @override
  Widget build(BuildContext context) {
    return Container(color: AppColors.background);
  }
}
