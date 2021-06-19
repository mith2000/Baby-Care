import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:hexcolor/hexcolor.dart';

import 'create-baby/cr-baby-gender.dart';

class CarriagePage extends StatelessWidget {
  Widget _buildBabyButton(BuildContext context, String headerText,
      String bodyText, Function todo, ImageProvider<Object> imageDes) {
    return GestureDetector(
      child: Container(
        height: 178,
        margin: EdgeInsets.only(top: 20, left: 10, right: 10),
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
        child: Row(
          children: [
            SizedBox(width: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(32.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/image/baby_default.jpg'),
                height: 168,
                width: 168,
                fit: BoxFit.cover,
                image: imageDes,
              ),
            ),
            Expanded(child: Container()),
            Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 10),
                  height: 60,
                  width: 170,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Text(
                          headerText,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Color.fromRGBO(255, 255, 255, 1),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      VerticalDivider(
                        width: 10,
                        thickness: 0.3,
                        indent: 10,
                        endIndent: 10,
                      ),
                      Container(
                        width: 32,
                        height: 32,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Theme.of(context).buttonColor,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Text(
                          bodyText,
                          style: Theme.of(context).textTheme.button,
                        ),
                      ),
                      Text(
                        ' month',
                        style: TextStyle(
                          fontSize: 9.0,
                          color: Color.fromRGBO(255, 255, 255, 1),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 60,
                  width: 170,
                )
              ],
            )
          ],
        ),
      ),
      onTap: todo,
    );
  }

  Widget _buildCreateBabyButton(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.add_circle,
        size: 56,
        color: Theme.of(context).buttonColor,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => CreateBabyGender(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;

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
                SizedBox(height: 35),
                _buildBabyButton(context, 'Name', '15', () {
                  print('Baby Health');
                }, AssetImage('assets/image/baby_default.jpg')),
                _buildBabyButton(context, 'Name', '15', () {
                  print('Baby Health');
                }, AssetImage('assets/image/baby_default.jpg')),
                SizedBox(height: 20),
                _buildCreateBabyButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
