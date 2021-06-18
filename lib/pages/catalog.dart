import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:hexcolor/hexcolor.dart';

import 'carriage/baby-health/baby-health.dart';

class CatalogPage extends StatelessWidget {
  Widget _buildTipLabel(double deviceWidth) {
    return Container(
      child: GlassContainer(
        height: 80,
        width: deviceWidth * 0.8,
        color: Colors.white.withOpacity(0.33),
        blur: 12,
        borderColor: Colors.white,
        borderRadius: BorderRadius.circular(32.0),
        borderWidth: 1.5,
        elevation: 10.0,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Center(
            child: Text(
              'Tips: ...',
              overflow: TextOverflow.fade,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCatalogBody(double deviceWidth, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, top: 10),
          child: Text(
            'Hi Username!',
            style: TextStyle(
              fontSize: 14.0,
              color: HexColor('#505050'),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(
            'Hope your angels are well',
            style: TextStyle(
              fontSize: 14.0,
              color: HexColor('#505050'),
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(),
            _buildOption(
                'Baby Health', 'Checking the health status of your baby', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) => BabyHealthPage(),
                ),
              );
            }, AssetImage('assets/image/baby_default.jpg'), [
              HexColor('#7ed1f2'),
              HexColor('#bd88f2'),
            ]),
            _buildOption('Menu Suggestions',
                'Get to know what your baby needs for the coming week', () {
              print('Menu Suggestions');
            }, AssetImage('assets/image/baby_default.jpg'), [
              HexColor('#ffda8f'),
              HexColor('#fc9495'),
            ]),
            _buildOption('Vaccine Reminder',
                'The following vaccination suggestions are very important for your kid',
                () {
              print('Vaccine Reminder');
            }, AssetImage('assets/image/baby_default.jpg'), [
              HexColor('#7ed1f2'),
              HexColor('#bd88f2'),
            ]),
            _buildOption('Vaccination history',
                'Store vaccination information for your baby', () {
              print('Vaccination history');
            }, AssetImage('assets/image/baby_default.jpg'), [
              HexColor('#ffda8f'),
              HexColor('#fc9495'),
            ]),
            SizedBox(height: 20),
          ],
        ),
      ],
    );
  }

  Widget _buildOption(String headerText, String bodyText, Function todo,
      ImageProvider<Object> imageDes, List<Color> bgColor) {
    return GestureDetector(
      child: Container(
        height: 138,
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: bgColor,
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter),
          borderRadius: BorderRadius.circular(32.0),
          boxShadow: [
            BoxShadow(
              color: HexColor('#bd88f2').withOpacity(0.5),
              spreadRadius: 4,
              blurRadius: 8,
              offset: Offset(-4, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 148,
              margin: EdgeInsets.only(left: 20, top: 5),
              child: Text(
                headerText,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color.fromRGBO(255, 255, 255, 1),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(child: Container()),
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/image/baby_default.jpg'),
                height: 128,
                width: 128,
                fit: BoxFit.cover,
                image: imageDes,
              ),
            ),
            SizedBox(width: 26),
          ],
        ),
      ),
      onTap: todo,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final Map<String, double> heights = {
      '1children': 722,
      '2children': 880,
      '3children': 1038,
    };

    return Container(
      child: GlassContainer(
        height: 1038,
        width: deviceWidth,
        color: Colors.white.withOpacity(.7),
        blur: 12,
        borderColor: Colors.white,
        borderWidth: 0,
        elevation: 10.0,
        child: Container(
          margin: EdgeInsets.only(top: 20, left: 10, right: 10),
          child: SafeArea(
            child: ListView(
              children: [
                _buildTipLabel(deviceWidth),
                SizedBox(height: 20),
                _buildCatalogBody(deviceWidth, context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
