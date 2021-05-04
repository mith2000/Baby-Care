import 'package:flutter/material.dart';

class CAAppBar extends PreferredSize {
  final String _text;

  CAAppBar(this._text);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      title: Container(
        margin: EdgeInsets.only(right: 40),
        child: Center(
          child: Text(
            _text,
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      shape: OutlineInputBorder(
        borderSide: BorderSide(
          width: 0.3,
        ),
      ),
    );
  }
}
