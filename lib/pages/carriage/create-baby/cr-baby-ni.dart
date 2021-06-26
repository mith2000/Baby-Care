import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../UI widgets/gradient-bg.dart';
import '../../home.dart';

class CreateBabyNI extends StatefulWidget {
  @override
  _CreateBabyNIState createState() => _CreateBabyNIState();
}

class _CreateBabyNIState extends State<CreateBabyNI> {
  final Map<String, dynamic> _formData = {
    'gender': null,
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final Map<String, String> _icons = {
    'Porridge': 'assets/icon/porridge.svg',
    'Milk': 'assets/icon/milk.svg',
    'Meat': 'assets/icon/beef.svg',
    'Fish': 'assets/icon/vitamin_d.svg',
    'Egg': 'assets/icon/egg.svg',
    'Green Vegets': 'assets/icon/salad.svg',
    'Red Vegets': 'assets/icon/carrot.svg',
    'Citrus fruit': 'assets/icon/orange.svg',
  };

  Widget _buildHeading() {
    return Center(
      child: Text(
        'Can you remember what \n your baby ate last week?',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headline3,
      ),
    );
  }

  Widget _buildSliderInput(String name) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          _icons[name],
          width: 40,
          height: 40,
        ),
        SizedBox(width: 10),
        Container(
          width: 220,
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(
                width: 1.0, color: Theme.of(context).backgroundColor),
            borderRadius: BorderRadius.circular(32),
          ),
        ),
      ],
    );
  }

  Widget _buildNextButton() {
    return Center(
      child: Container(
        width: 140,
        height: 65,
        child: ElevatedButton(
          child: Text(
            'DONE',
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: () => _submitForm(), //model.authenticate),
        ),
      ),
    );
  }

  Widget _buildSkipButton() {
    return Center(
      child: Container(
        width: 140,
        height: 65,
        child: ElevatedButton(
          child: Text(
            'SKIP',
            style: TextStyle(
              fontSize: 14.0,
              color: Theme.of(context).buttonColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          onPressed: () => _submitForm(),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(45),
              ),
            ),
            side: MaterialStateProperty.all<BorderSide>(
              BorderSide(
                width: 1.0,
                color: Theme.of(context).buttonColor,
              ),
            ),
            elevation: MaterialStateProperty.resolveWith<double>(
              (Set<MaterialState> states) {
                if (states.contains(MaterialState.pressed)) {
                  return 0;
                }
                return 10;
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSkipButton(),
        SizedBox(width: 20),
        _buildNextButton(),
      ],
    );
  }

  void _submitForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => HomePage(
          selectedIndex: 0,
        ),
      ),
    );
  }

  Widget _buildBodyWidget() {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;

    final List<Widget> _widgets = [
      _buildHeading(),
      SizedBox(height: 20),
      _buildSliderInput('Porridge'),
      SizedBox(height: 10),
      _buildSliderInput('Milk'),
      SizedBox(height: 10),
      _buildSliderInput('Meat'),
      SizedBox(height: 10),
      _buildSliderInput('Fish'),
      SizedBox(height: 10),
      _buildSliderInput('Egg'),
      SizedBox(height: 10),
      _buildSliderInput('Green Vegets'),
      SizedBox(height: 10),
      _buildSliderInput('Red Vegets'),
      SizedBox(height: 10),
      _buildSliderInput('Citrus fruit'),
      SizedBox(height: 20),
      _buildBottomButtons(),
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
              height: 680,
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
