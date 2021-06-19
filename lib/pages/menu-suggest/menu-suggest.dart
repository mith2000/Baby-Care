import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../UI widgets/gradient-bg.dart';
import 'last-week.dart';
import 'next-week.dart';

class MenuSuggestPage extends StatelessWidget {
  Widget _buildNutriWidget(BuildContext context, String nutriName) {
    return Container(
      width: 110,
      height: 32,
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: HexColor('#A79BF2'),
        borderRadius: BorderRadius.circular(10.0),
      ),
      alignment: Alignment.center,
      child: Text(
        nutriName,
        style: Theme.of(context).textTheme.button,
      ),
    );
  }

  Widget _buildNoticeWidget(BuildContext context, double deviceWidth) {
    return Center(
      child: Container(
        width: deviceWidth * 0.85,
        height: 220,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'His vitamin B index: ',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Container(
                    width: 72,
                    height: 32,
                    decoration: BoxDecoration(
                      color: HexColor('#FF4A05'),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '50/100',
                      style: Theme.of(context).textTheme.button,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              width: 300,
              height: 30,
              decoration: BoxDecoration(
                color: HexColor('#05C7F2'),
                border: Border.all(
                  width: 1.0,
                  color: HexColor('#05C7F2'),
                ),
                borderRadius: BorderRadius.circular(32),
              ),
            ),
            SizedBox(height: 16),
            Container(
              height: 40,
              alignment: Alignment.center,
              child: Text(
                'He needs more',
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ),
            Container(
              height: 40,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.emoji_food_beverage,
                    size: 40,
                    color: Colors.pink[200],
                  ),
                  Icon(
                    Icons.emoji_food_beverage,
                    size: 40,
                    color: Colors.pink[200],
                  ),
                  Icon(
                    Icons.emoji_food_beverage,
                    size: 40,
                    color: Colors.pink[200],
                  ),
                  Icon(
                    Icons.emoji_food_beverage,
                    size: 40,
                    color: Colors.pink[200],
                  ),
                  Icon(
                    Icons.emoji_food_beverage,
                    size: 40,
                    color: Colors.pink[200],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLastWeekButton(BuildContext context, double deviceWidth) {
    return GestureDetector(
      child: Container(
        width: deviceWidth / 2,
        height: 75,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1.0,
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        child: Center(
          child: Text(
            'Last Week',
            style: TextStyle(
              fontSize: 16.0,
              color: Color.fromRGBO(0, 0, 0, .5),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => LastWeekPage(),
          ),
        );
      },
    );
  }

  Widget _buildNextWeekButton(BuildContext context, double deviceWidth) {
    return GestureDetector(
      child: Container(
        width: deviceWidth / 2,
        height: 75,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            width: 1.0,
            color: Colors.black.withOpacity(0.5),
          ),
        ),
        child: Center(
          child: Text(
            'Next Week',
            style: TextStyle(
              fontSize: 16.0,
              color: Color.fromRGBO(0, 0, 0, .5),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => NextWeekPage(),
          ),
        );
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double deviceHeigth = MediaQuery.of(context).size.height;

    final List<Widget> _widgets = [
      SizedBox(height: 20),
      Container(
        alignment: Alignment.center,
        height: 40,
        child: Text(
          'The last time you updated',
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
      Container(
        alignment: Alignment.center,
        height: 40,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Nutrition Index was ',
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
                '5',
                style: Theme.of(context).textTheme.button,
              ),
            ),
            Text(
              ' days ago',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
      SizedBox(height: 20),
      Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text(
                  'Your baby is deficient in ',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(height: 90),
              ],
            ),
            Column(
              children: [
                _buildNutriWidget(context, 'Carbs'),
                _buildNutriWidget(context, 'Protein'),
                _buildNutriWidget(context, 'Vitamin B'),
              ],
            )
          ],
        ),
      ),
      SizedBox(height: 20),
      _buildNoticeWidget(context, deviceWidth),
      SizedBox(height: 20),
      _buildNoticeWidget(context, deviceWidth),
      SizedBox(height: 20),
      _buildNoticeWidget(context, deviceWidth),
      SizedBox(height: 95),
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
              children: _widgets,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 75,
                child: Row(
                  children: [
                    _buildLastWeekButton(context, deviceWidth),
                    _buildNextWeekButton(context, deviceWidth),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final PreferredSize _appBar = PreferredSize(
    preferredSize: Size.fromHeight(65),
    child: AppBar(
      centerTitle: true,
      title: Container(
        child: Text(
          'Menu Suggestion',
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

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      _buildBody(context),
      context,
      _appBar,
      null,
    );
  }
}
