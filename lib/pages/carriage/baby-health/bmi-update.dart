import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../UI widgets/gradient-bg.dart';
import 'baby-prf-head.dart';

class BMIUpdatePage extends StatefulWidget {
  @override
  _BMIUpdatePageState createState() => _BMIUpdatePageState();
}

class _BMIUpdatePageState extends State<BMIUpdatePage> {
  final Map<String, dynamic> _formData = {
    'username': null,
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildBodyMassSlider() {
    return Container(
      width: 300,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        border:
            Border.all(width: 1.0, color: Theme.of(context).backgroundColor),
        borderRadius: BorderRadius.circular(32),
      ),
    );
  }

  Widget _buildNextButton() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 300,
        height: 65,
        margin: EdgeInsets.only(bottom: 20),
        child: ElevatedButton(
            child: Text(
              'NEXT',
              style: Theme.of(context).textTheme.button,
            ),
            onPressed: () {
              Navigator.pop(context);
            }), //model.authenticate),
      ),
    );
  }

  Widget _buildBodyWidget() {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeight = MediaQuery.of(context).size.height;

    final List<Widget> _widgets = [
      SizedBox(height: 15),
      BabyProfileHeaderPage(),
      SizedBox(height: 20),
      Container(
        child: GlassContainer(
          height: 80,
          width: 350,
          color: Colors.white.withOpacity(0.33),
          blur: 12,
          borderColor: Colors.white.withOpacity(.3),
          borderRadius: BorderRadius.circular(32.0),
          borderWidth: 1.0,
          elevation: 10.0,
          child: Container(
            margin: EdgeInsets.only(left: 5, top: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Last Height: ',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Last Weight: ',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color.fromRGBO(0, 0, 0, 1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '888cm',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '4000g',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color.fromRGBO(0, 0, 0, 1),
                      ),
                    ),
                  ],
                ),
                Text(
                  'since',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  margin: EdgeInsets.only(left: 5, right: 5),
                  decoration: BoxDecoration(
                    color: HexColor('#FF4A05'),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '15',
                    style: Theme.of(context).textTheme.button,
                  ),
                ),
                Text(
                  'days ago',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      SizedBox(height: 20),
      Center(
        child: Container(
          height: 237,
          width: 330,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              HexColor('#7ed1f2'),
              HexColor('#bd88f2'),
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
            borderRadius: BorderRadius.circular(32.0),
            boxShadow: [
              BoxShadow(
                color: HexColor('#bd88f2').withOpacity(0.5),
                spreadRadius: 0,
                blurRadius: 8,
                offset: Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 220,
                child: Text(
                  'How much did your kid grow up?',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color.fromRGBO(255, 255, 255, 1),
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.visible,
                ),
              ),
              SizedBox(height: 20),
              _buildBodyMassSlider(),
              SizedBox(height: 20),
              _buildBodyMassSlider(),
            ],
          ),
        ),
      )
    ];
    return Form(
      key: _formKey,
      child: Container(
        child: GlassContainer(
          height: deviceHeight,
          width: deviceWidth,
          color: Colors.white.withOpacity(.7),
          blur: 12,
          borderColor: Colors.white,
          borderWidth: 0,
          elevation: 10.0,
          child: SafeArea(
            child: Stack(
              children: [
                ListView(
                  children: _widgets,
                ),
                _buildNextButton(),
              ],
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
        centerTitle: true,
        title: Container(
          child: Text(
            'BMI Update',
            style: TextStyle(
              fontFamily: 'Dosis',
              fontSize: 26.0,
              fontWeight: FontWeight.bold,
              color: HexColor('#bd88f2'),
            ),
          ),
        ),
        iconTheme: IconThemeData(
          color: HexColor('#bd88f2'),
          size: 40,
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
    );

    return GradientBackground(_buildBodyWidget(), context, _appBar);
  }
}
