import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String title;
  final String content;
  final String ok;
  final Function onOk;
  const CustomDialog({
    Key key,
    this.title,
    this.content,
    this.ok,
    this.onOk,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headline1,
      ),
      content: Text(
        content,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      actions: [
        TextButton(
          onPressed: onOk,
          child: Text(
            ok,
            style: Theme.of(context).textTheme.bodyText1,
          ),
        ),
      ],
    );
  }
}
