import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../UI widgets/gradient-bg.dart';
import 'bmi-update.dart';
import 'ni-update.dart';

class BabyHealthPage extends StatelessWidget {
  Widget _buildImages(double width) {
    return FadeInImage(
      placeholder: AssetImage('assets/image/baby_default.jpg'),
      height: width,
      width: width,
      fit: BoxFit.cover,
      image: AssetImage('assets/image/baby_default.jpg'),
    );
  }

  Widget _buildBackButton(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, top: 64),
      child: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 40,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  Widget _buildChooseImageButton(BuildContext context) {
    return Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.only(right: 15, top: 64),
      child: IconButton(
        icon: Icon(
          Icons.photo_library,
          color: Colors.black,
          size: 40,
        ),
        onPressed: () {},
      ),
    );
  }

  Widget _buildBMIButton(BuildContext context, double deviceWidth) {
    return GestureDetector(
      child: Container(
        width: deviceWidth / 2,
        height: 75,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
        ),
        child: Icon(
          Icons.line_weight_rounded,
          size: 40,
          color: Colors.white,
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => BMIUpdatePage(),
          ),
        );
      },
    );
  }

  Widget _buildNIButton(BuildContext context, double deviceWidth) {
    return GestureDetector(
      child: Container(
        width: deviceWidth / 2,
        height: 75,
        decoration: BoxDecoration(
          color: Theme.of(context).buttonColor,
        ),
        child: Icon(
          Icons.fastfood,
          size: 40,
          color: Colors.white,
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => NIUpdatePage(),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeigth = MediaQuery.of(context).size.height;

    final List<Widget> _widgets = [
      Container(
        alignment: Alignment.center,
        height: 60,
        child: Text(
          'Baby Name',
          style: Theme.of(context).textTheme.headline4,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      SizedBox(height: 16),
      Container(
        alignment: Alignment.center,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Baby\'s age: ',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: HexColor('#85b4f2'),
                borderRadius: BorderRadius.circular(10.0),
              ),
              alignment: Alignment.center,
              child: Text(
                '15',
                style: Theme.of(context).textTheme.button,
              ),
            ),
            Text(
              ' month',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            VerticalDivider(
              width: 30,
              thickness: 1,
              indent: 5,
              endIndent: 5,
            ),
            Text(
              'Status ',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Icon(
              Icons.face_retouching_natural,
              size: 32,
              color: Colors.pink[200],
            ),
          ],
        ),
      ),
      SizedBox(height: 16),
      Container(
        width: deviceWidth * 0.8,
        height: 40,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            HexColor('#ffff90'),
            Colors.white,
            HexColor('#ffff90'),
          ], stops: [
            0.1,
            0.5,
            1,
          ], begin: Alignment.centerLeft, end: Alignment.centerRight),
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 8,
              offset: Offset(0, 8),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          '15d left to one month old',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
      SizedBox(height: 16),
      Container(
        alignment: Alignment.center,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.highlight,
              size: 40,
              color: HexColor('#ffff90'),
            ),
            Container(
              width: 180,
              margin: EdgeInsets.only(right: 5),
              alignment: Alignment.center,
              child: Text(
                'Next achievement',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color.fromRGBO(0, 0, 0, .5),
                ),
              ),
            ),
            Container(
              width: 155,
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  HexColor('#ffff90'),
                  Colors.white,
                  HexColor('#ffff90'),
                ], stops: [
                  0.1,
                  0.5,
                  1,
                ], begin: Alignment.centerLeft, end: Alignment.centerRight),
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 0,
                    blurRadius: 8,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                'Start to walk',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 20),
      Container(
        alignment: Alignment.center,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              child: Icon(
                Icons.warning_rounded,
                size: 40,
                color: HexColor('#FF4A05'),
              ),
            ),
            Container(
              width: 80,
              alignment: Alignment.center,
              child: Text(
                'It\'s been',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color.fromRGBO(0, 0, 0, .5),
                ),
              ),
            ),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: HexColor('#FF4A05'),
                borderRadius: BorderRadius.circular(10.0),
              ),
              alignment: Alignment.center,
              child: Text(
                '10',
                style: Theme.of(context).textTheme.button,
              ),
            ),
            Container(
              width: 200,
              margin: EdgeInsets.only(left: 5),
              alignment: Alignment.centerLeft,
              child: Text(
                'days last BMI updated',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color.fromRGBO(0, 0, 0, .5),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 16),
      Container(
        alignment: Alignment.center,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 40,
              child: null,
            ),
            Container(
              width: 80,
              alignment: Alignment.center,
              child: Text(
                'It\'s been',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color.fromRGBO(0, 0, 0, .5),
                ),
              ),
            ),
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: HexColor('#B4DD7F'),
                borderRadius: BorderRadius.circular(10.0),
              ),
              alignment: Alignment.center,
              child: Text(
                '4',
                style: Theme.of(context).textTheme.button,
              ),
            ),
            Container(
              width: 200,
              margin: EdgeInsets.only(left: 5),
              alignment: Alignment.centerLeft,
              child: Text(
                'days last NI updated',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Color.fromRGBO(0, 0, 0, .5),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: 20),
      Container(
        width: deviceWidth * 0.95,
        height: 290,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 8,
              offset: Offset(0, 8),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 40,
              child: Text(
                'Body Mass Index',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            SizedBox(height: 5),
            Container(
              alignment: Alignment.center,
              width: deviceWidth * 0.85,
              height: 50,
              decoration: BoxDecoration(
                color: HexColor('#7ED1F2'),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    child: Icon(
                      Icons.arrow_circle_up_rounded,
                      size: 40,
                      color: HexColor('#A79BF2'),
                    ),
                  ),
                  Container(
                    width: 140,
                    alignment: Alignment.center,
                    child: Text(
                      'Current height: ',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color.fromRGBO(0, 0, 0, .5),
                      ),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 32,
                    decoration: BoxDecoration(
                      color: HexColor('#A79BF2'),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '999cm',
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                  Expanded(child: Container()),
                  Icon(
                    Icons.face_retouching_natural,
                    size: 32,
                    color: Colors.pink[200],
                  ),
                  SizedBox(width: 5),
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.center,
              width: deviceWidth * 0.85,
              height: 50,
              decoration: BoxDecoration(
                color: HexColor('#7ED1F2'),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    child: Icon(
                      Icons.arrow_circle_up_rounded,
                      size: 40,
                      color: HexColor('#A79BF2'),
                    ),
                  ),
                  Container(
                    width: 140,
                    alignment: Alignment.center,
                    child: Text(
                      'Current weight: ',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Color.fromRGBO(0, 0, 0, .5),
                      ),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 32,
                    decoration: BoxDecoration(
                      color: HexColor('#A79BF2'),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '4000g',
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                  Expanded(child: Container()),
                  Icon(
                    Icons.face_retouching_natural,
                    size: 32,
                    color: Colors.pink[200],
                  ),
                  SizedBox(width: 5),
                ],
              ),
            ),
            SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 150,
                height: 65,
                margin: EdgeInsets.only(right: 20),
                child: ElevatedButton(
                  child: Text(
                    'Update',
                    style: Theme.of(context).textTheme.button,
                  ),
                  onPressed: () {}, //model.authenticate),
                ),
              ),
            )
          ],
        ),
      ),
      SizedBox(height: 20),
      Container(
        width: deviceWidth * 0.95,
        height: 1147,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              spreadRadius: 0,
              blurRadius: 8,
              offset: Offset(0, 8),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              height: 40,
              child: Text(
                'Nutrition Index',
                style: Theme.of(context).textTheme.headline5,
              ),
            ),
            SizedBox(height: 20),
            Container(
              height: 180,
              margin: EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 140,
                    decoration: BoxDecoration(
                      color: HexColor('#7ED1F2'),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fastfood,
                          size: 40,
                          color: Colors.brown,
                        ),
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(top: 5, bottom: 15),
                          alignment: Alignment.center,
                          child: Text(
                            'Carbohydrate',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Color.fromRGBO(0, 0, 0, .5),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.face_retouching_natural,
                          size: 50,
                          color: Colors.pink[200],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 40),
                  Container(
                    width: 140,
                    decoration: BoxDecoration(
                      color: HexColor('#7ED1F2'),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fastfood,
                          size: 40,
                          color: Colors.brown,
                        ),
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(top: 5, bottom: 15),
                          alignment: Alignment.center,
                          child: Text(
                            'Carbohydrate',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Color.fromRGBO(0, 0, 0, .5),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.face_retouching_natural,
                          size: 50,
                          color: Colors.pink[200],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 180,
              margin: EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 140,
                    decoration: BoxDecoration(
                      color: HexColor('#7ED1F2'),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fastfood,
                          size: 40,
                          color: Colors.brown,
                        ),
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(top: 5, bottom: 15),
                          alignment: Alignment.center,
                          child: Text(
                            'Carbohydrate',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Color.fromRGBO(0, 0, 0, .5),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.face_retouching_natural,
                          size: 50,
                          color: Colors.pink[200],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 40),
                  Container(
                    width: 140,
                    decoration: BoxDecoration(
                      color: HexColor('#7ED1F2'),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fastfood,
                          size: 40,
                          color: Colors.brown,
                        ),
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(top: 5, bottom: 15),
                          alignment: Alignment.center,
                          child: Text(
                            'Carbohydrate',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Color.fromRGBO(0, 0, 0, .5),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.face_retouching_natural,
                          size: 50,
                          color: Colors.pink[200],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 180,
              margin: EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 140,
                    decoration: BoxDecoration(
                      color: HexColor('#7ED1F2'),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fastfood,
                          size: 40,
                          color: Colors.brown,
                        ),
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(top: 5, bottom: 15),
                          alignment: Alignment.center,
                          child: Text(
                            'Carbohydrate',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Color.fromRGBO(0, 0, 0, .5),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.face_retouching_natural,
                          size: 50,
                          color: Colors.pink[200],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 40),
                  Container(
                    width: 140,
                    decoration: BoxDecoration(
                      color: HexColor('#7ED1F2'),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fastfood,
                          size: 40,
                          color: Colors.brown,
                        ),
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(top: 5, bottom: 15),
                          alignment: Alignment.center,
                          child: Text(
                            'Carbohydrate',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Color.fromRGBO(0, 0, 0, .5),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.face_retouching_natural,
                          size: 50,
                          color: Colors.pink[200],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 180,
              margin: EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 140,
                    decoration: BoxDecoration(
                      color: HexColor('#7ED1F2'),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fastfood,
                          size: 40,
                          color: Colors.brown,
                        ),
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(top: 5, bottom: 15),
                          alignment: Alignment.center,
                          child: Text(
                            'Carbohydrate',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Color.fromRGBO(0, 0, 0, .5),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.face_retouching_natural,
                          size: 50,
                          color: Colors.pink[200],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 40),
                  Container(
                    width: 140,
                    decoration: BoxDecoration(
                      color: HexColor('#7ED1F2'),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fastfood,
                          size: 40,
                          color: Colors.brown,
                        ),
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(top: 5, bottom: 15),
                          alignment: Alignment.center,
                          child: Text(
                            'Carbohydrate',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Color.fromRGBO(0, 0, 0, .5),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.face_retouching_natural,
                          size: 50,
                          color: Colors.pink[200],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 180,
              margin: EdgeInsets.only(bottom: 15),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 140,
                    decoration: BoxDecoration(
                      color: HexColor('#7ED1F2'),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fastfood,
                          size: 40,
                          color: Colors.brown,
                        ),
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(top: 5, bottom: 15),
                          alignment: Alignment.center,
                          child: Text(
                            'Carbohydrate',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Color.fromRGBO(0, 0, 0, .5),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.face_retouching_natural,
                          size: 50,
                          color: Colors.pink[200],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 40),
                  Container(
                    width: 140,
                    decoration: BoxDecoration(
                      color: HexColor('#7ED1F2'),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.fastfood,
                          size: 40,
                          color: Colors.brown,
                        ),
                        Container(
                          width: 140,
                          margin: EdgeInsets.only(top: 5, bottom: 15),
                          alignment: Alignment.center,
                          child: Text(
                            'Carbohydrate',
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Color.fromRGBO(0, 0, 0, .5),
                            ),
                          ),
                        ),
                        Icon(
                          Icons.face_retouching_natural,
                          size: 50,
                          color: Colors.pink[200],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 5),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                width: 150,
                height: 65,
                margin: EdgeInsets.only(right: 20),
                child: ElevatedButton(
                  child: Text(
                    'Update',
                    style: Theme.of(context).textTheme.button,
                  ),
                  onPressed: () {}, //model.authenticate),
                ),
              ),
            )
          ],
        ),
      ),
    ];
    return Container(
      child: GlassContainer(
        height: deviceHeigth,
        width: deviceWidth,
        color: Colors.white.withOpacity(.7),
        blur: 12,
        borderColor: Colors.white,
        borderWidth: 0,
        elevation: 10.0,
        child: Stack(
          children: [
            ListView(
              children: [
                Stack(
                  children: [
                    _buildImages(deviceWidth),
                    _buildBackButton(context),
                    _buildChooseImageButton(context),
                  ],
                ),
                Container(
                  height: 1916,
                  child: Column(
                    children: _widgets,
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  _buildBMIButton(context, deviceWidth),
                  _buildNIButton(context, deviceWidth),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      _buildBody(context),
      context,
      null,
      null,
    );
  }
}
