import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../UI widgets/gradient-bg.dart';
import 'cr-baby-bmi.dart';

class CreateBabyGender extends StatefulWidget {
  @override
  _CreateBabyGenderState createState() => _CreateBabyGenderState();
}

class _CreateBabyGenderState extends State<CreateBabyGender> {
  final Map<String, dynamic> _formData = {
    'gender': null,
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, String> _icons = {
    'eye': 'assets/icon/open_eye.svg',
    'correct': 'assets/icon/correct.svg',
    'uncorrect': 'assets/icon/uncorrect.svg',
  };

  Widget _buildHeading() {
    return Center(
      child: Text(
        'What gender is the kid?',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }

  Widget _buildChooseGenderButtons() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(
            Icons.arrow_circle_up,
            color: Theme.of(context).backgroundColor,
          ),
          iconSize: 100,
          onPressed: () {
            print('male');
          },
        ),
        IconButton(
          icon: Icon(
            Icons.arrow_circle_up,
            color: Theme.of(context).backgroundColor,
          ),
          iconSize: 100,
          onPressed: () {
            print('female');
          },
        ),
      ],
    );
  }

  Widget _buildNextButton() {
    return Center(
      child: Container(
        width: 300,
        height: 65,
        child: ElevatedButton(
          child: Text(
            'NEXT',
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: () => _submitForm(), //model.authenticate),
        ),
      ),
    );
  }

  void _submitForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => CreateBabyBMI(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;

    final List<Widget> _widgets = [
      _buildHeading(),
      SizedBox(height: 20),
      _buildChooseGenderButtons(),
      SizedBox(height: 20),
      _buildNextButton(),
    ];
    return Form(
      key: _formKey,
      child: Container(
        child: GlassContainer(
          height: deviceHeight,
          width: deviceWidth,
          gradient: new RadialGradient(
            colors: [
              Colors.white.withOpacity(.42),
              Colors.white.withOpacity(.06),
            ],
            radius: 1,
            center: Alignment(-0.66, -0.66),
          ),
          blur: 12,
          borderColor: Colors.white,
          borderWidth: 0,
          elevation: 10.0,
          child: Center(
            child: Container(
              width: 330,
              height: 335,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 8,
                      offset: Offset(0, 8),
                    ),
                  ]),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: _widgets,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSize _appBar = PreferredSize(
      preferredSize: Size.fromHeight(65),
      child: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );

    return GradientBackground(_buildBodyWidget(), context, _appBar);
  }
}
