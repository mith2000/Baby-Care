import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:hexcolor/hexcolor.dart';

import 'pages/login.dart';

void main() {
  //debugPaintSizeEnabled = true;
  //debugPaintBaselinesEnabled = true;
  //debugPaintPointersEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //brightness overwrite primarySwatch and background
        brightness: Brightness.light,
        primaryColor: HexColor('#05dbf2'),
        //if dont define what color using, automatically use this

        //backbuffer color :v just scroll out a list
        // accentColor: HexColor('#b3ecf2'),
        buttonColor: HexColor('#f2b3e1'),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(HexColor('#f2b3e1')),
            shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(45),
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
        // indicatorColor: HexColor('#f2b3e1'),

        backgroundColor: HexColor('#b3ecf2'),
        cardColor: HexColor('#f2bdcb'),

        fontFamily: 'Avo',
        textTheme: TextTheme(
          button: TextStyle(
            fontSize: 14.0,
            color: Color.fromRGBO(255, 255, 255, 1),
            fontWeight: FontWeight.bold,
          ),
          bodyText1: TextStyle(
            fontSize: 14.0,
            color: Color.fromRGBO(0, 0, 0, .5),
          ),
        ),

        dividerTheme: DividerThemeData(
          space: 30,
          thickness: 0.3,
          color: HexColor('#505050'),
        ),
      ),

      //routes as shortcuts for Navigator
      routes: {
        '/': (BuildContext context) => LoginPage(),
      },
    );
  }
}
