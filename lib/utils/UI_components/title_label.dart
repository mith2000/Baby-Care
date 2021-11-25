import 'package:flutter/material.dart';

class TitleLabel extends StatelessWidget {
  final title;
  const TitleLabel(String title, {Key key})
      : this.title = title,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        title,
        style: Theme.of(context).textTheme.caption,
        textAlign: TextAlign.center,
      ),
    );
  }
}
