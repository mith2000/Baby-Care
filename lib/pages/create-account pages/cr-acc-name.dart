import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../UI widgets/gradient-bg.dart';
import '../../UI widgets/cr-acc-appbar.dart';

class CreateAccountName extends StatefulWidget {
  @override
  _CreateAccountNameState createState() => _CreateAccountNameState();
}

class _CreateAccountNameState extends State<CreateAccountName> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgets = [
      SizedBox(
        width: 500,
      ),
      SizedBox(
        height: 100,
      ),
      Container(
        width: 300,
        height: 65,
        child: ElevatedButton(
          child: Text(
            'LOGIN',
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: () {}, //model.authenticate),
        ),
      )
    ];
    final PreferredSize _appBar = PreferredSize(
      preferredSize: Size.fromHeight(65),
      child: CAAppBar('Name'),
    );

    return GradientBackground(_formKey, _widgets, context, _appBar);
  }
}
