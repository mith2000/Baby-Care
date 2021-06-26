import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class BabyProfileHeaderPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(90.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/image/baby_default.jpg'),
                height: 150,
                width: 150,
                fit: BoxFit.cover,
                image: AssetImage('assets/image/baby_default.jpg'),
              ),
            ),
          ),
          Expanded(child: Container()),
          Container(
            margin: EdgeInsets.only(right: 15),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 60,
                  child: Text(
                    'Baby Name',
                    style: Theme.of(context).textTheme.headline4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Age: ',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color.fromRGBO(0, 0, 0, .5),
                        ),
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
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color.fromRGBO(0, 0, 0, .5),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Status ',
                        style: TextStyle(
                          fontSize: 12.0,
                          color: Color.fromRGBO(0, 0, 0, .5),
                        ),
                      ),
                      FadeInImage(
                        placeholder:
                            AssetImage('assets/image/EmojiHeartEye.png'),
                        height: 32,
                        width: 32,
                        fit: BoxFit.cover,
                        image: AssetImage('assets/image/EmojiHeartEye.png'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
