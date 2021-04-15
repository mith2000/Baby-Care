import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
import 'package:scoped_model/scoped_model.dart';

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
        //brightness dart will overwrite the primarySwatch and background
        brightness: Brightness.light,
        //main color
        primaryColor: Colors.pink[100],
        //if dont define what color using, automatically use this
        primarySwatch: Colors.red,
        //backbuffer color :v just scroll out a list
        accentColor: Colors.grey[400],
        buttonColor: Colors.pinkAccent[200],
        indicatorColor: Colors.pink[100],
      ),

      //routes as shortcuts for Navigator
      routes: {
        '/': (BuildContext context) => LoginPage(),
      },
    );
  }
}
