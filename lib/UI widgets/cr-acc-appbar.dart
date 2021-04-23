import 'package:flutter/material.dart';

class CAAppBar extends PreferredSize {
  final String _text;

  CAAppBar(this._text);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        margin: EdgeInsets.only(right: 40),
        child: Center(
          child: Text(
            _text,
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
