import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../UI widgets/gradient-bg.dart';
import 'bmi-update.dart';
import 'ni-update.dart';

class BabyHealthPage extends StatelessWidget {
  final Map<String, String> _icons = {
    'images': 'assets/icon/images_outlined.svg',
    'crown': 'assets/icon/crown.svg',
    'warn': 'assets/icon/warn.svg',
    'height': 'assets/icon/height.svg',
    'weight': 'assets/icon/weight.svg',
    'Carbohydrate': 'assets/icon/bread.svg',
    'Fat': 'assets/icon/fat.svg',
    'Protein': 'assets/icon/protein.svg',
    'Vitamin A': 'assets/icon/vitamin_a.svg',
    'Vitamin B': 'assets/icon/vitamin_b.svg',
    'Vitamin C': 'assets/icon/vitamin_c.svg',
    'Vitamin D': 'assets/icon/vitamin_d.svg',
    'Iron': 'assets/icon/beef.svg',
    'Calcium': 'assets/icon/milk.svg',
    'Iodine': 'assets/icon/seafood.svg',
  };

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
        icon: SvgPicture.asset(
          _icons['images'],
          width: 40,
          height: 40,
        ),
        onPressed: () {
          print('choose image');
        },
      ),
    );
  }

  Widget _buildBodyMassWidget(BuildContext context, double deviceWidth,
      String name, int value, String status) {
    return Container(
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
          SizedBox(width: 5),
          SvgPicture.asset(
            _icons[name],
            width: 40,
            height: 40,
          ),
          Container(
            width: 140,
            alignment: Alignment.center,
            child: Text(
              'Current $name: ',
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
              name == 'height' ? '$value' + 'cm' : '$value' + 'g',
              style: Theme.of(context).textTheme.button,
            ),
          ),
          Expanded(child: Container()),
          FadeInImage(
            placeholder: AssetImage('assets/image/EmojiHeartEye.png'),
            height: 32,
            width: 32,
            fit: BoxFit.cover,
            image: AssetImage('assets/image/Emoji$status.png'),
          ),
          SizedBox(width: 5),
        ],
      ),
    );
  }

  Widget _buildNutriWidget(
      BuildContext context, String nutriName, String status) {
    return Container(
      width: 140,
      decoration: BoxDecoration(
        color: HexColor('#7ED1F2'),
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            _icons[nutriName],
            width: 40,
            height: 40,
          ),
          Container(
            width: 140,
            margin: EdgeInsets.only(top: 5, bottom: 15),
            alignment: Alignment.center,
            child: Text(
              nutriName,
              style: TextStyle(
                fontSize: 12.0,
                color: Color.fromRGBO(0, 0, 0, .5),
              ),
            ),
          ),
          FadeInImage(
            placeholder: AssetImage('assets/image/EmojiHeartEye.png'),
            height: 50,
            width: 50,
            fit: BoxFit.cover,
            image: AssetImage('assets/image/Emoji$status.png'),
          ),
        ],
      ),
    );
  }

  Widget _buildPairOfNutriWidget(BuildContext context, String nutriName1,
      String nutriName2, String status1, String status2) {
    return Container(
      height: 180,
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNutriWidget(context, nutriName1, status1),
          SizedBox(width: 40),
          _buildNutriWidget(context, nutriName2, status2),
        ],
      ),
    );
  }

  Widget _buildUpdateBMIButton(BuildContext context) {
    return Align(
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => BMIUpdatePage(),
              ),
            );
          }, //model.authenticate),
        ),
      ),
    );
  }

  Widget _buildUpdateNIButton(BuildContext context) {
    return Align(
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
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => NIUpdatePage(),
              ),
            );
          }, //model.authenticate),
        ),
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
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                _icons['height'],
                width: 40,
                height: 40,
                color: Colors.white,
              ),
              SizedBox(width: 10),
              Text(
                'BMI',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
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
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                _icons['Calcium'],
                width: 40,
                height: 40,
              ),
              SizedBox(width: 10),
              Text(
                'NI',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
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
            FadeInImage(
              placeholder: AssetImage('assets/image/EmojiHeartEye.png'),
              height: 32,
              width: 32,
              fit: BoxFit.cover,
              image: AssetImage('assets/image/EmojiHeartEye.png'),
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
            SvgPicture.asset(
              _icons['crown'],
              width: 32,
              height: 32,
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
            SvgPicture.asset(
              _icons['warn'],
              width: 40,
              height: 40,
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
            _buildBodyMassWidget(context, deviceWidth, 'height', 999, 'Smile'),
            SizedBox(height: 10),
            _buildBodyMassWidget(context, deviceWidth, 'weight', 4005, 'Sad'),
            SizedBox(height: 20),
            _buildUpdateBMIButton(context),
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
            _buildPairOfNutriWidget(
                context, 'Carbohydrate', 'Fat', 'HeartEye', 'Happy'),
            _buildPairOfNutriWidget(
                context, 'Protein', 'Vitamin A', 'Happy', 'Happy'),
            _buildPairOfNutriWidget(
                context, 'Vitamin B', 'Vitamin C', 'Sad', 'Smile'),
            _buildPairOfNutriWidget(context, 'Vitamin D', 'Iron', 'Sad', 'Cry'),
            _buildPairOfNutriWidget(
                context, 'Calcium', 'Iodine', 'Cry', 'HeartEye'),
            SizedBox(height: 5),
            _buildUpdateNIButton(context),
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
