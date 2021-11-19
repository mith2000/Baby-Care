import 'package:flutter/material.dart';

class CircleIconButton extends StatelessWidget {
  final Widget icon;
  final Function action;
  CircleIconButton(this.icon, this.action, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: action,
      child: icon,
      style: TextButton.styleFrom(
        shape: CircleBorder(),
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
      ),
    );
  }
}
