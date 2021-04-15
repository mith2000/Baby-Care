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
          // indicatorColor: HexColor('#f2b3e1'),

          backgroundColor: HexColor('#b3ecf2'),
          cardColor: HexColor('#f2bdcb')),

      //routes as shortcuts for Navigator
      routes: {
        '/': (BuildContext context) => LoginPage(),
      },
    );
  }
}
