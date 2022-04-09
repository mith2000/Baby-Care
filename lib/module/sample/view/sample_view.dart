import 'package:flutter/material.dart';
import '../../../utils/app_colors.dart';

class SampleView extends StatefulWidget {
  static const routeName = '/sam-ple';

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
