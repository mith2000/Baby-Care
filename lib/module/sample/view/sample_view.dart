import 'package:flutter/material.dart';
import 'package:flutter_babycare/utils/app_colors.dart';

class SampleView extends StatefulWidget {
  const SampleView({Key key}) : super(key: key);

  @override
  _SampleViewState createState() => _SampleViewState();
}

class _SampleViewState extends State<SampleView> {
  @override
  Widget build(BuildContext context) {
    return Container(color: AppColors.background);
  }
}
