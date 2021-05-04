import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import '../../UI widgets/gradient-bg.dart';
import '../../UI widgets/cr-acc-appbar.dart';

class CreateAccountTerm extends StatefulWidget {
  @override
  _CreateAccountTermState createState() => _CreateAccountTermState();
}

class _CreateAccountTermState extends State<CreateAccountTerm> {
  Widget _buildHeading() {
    return Text(
      'Finish Signing Up',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline1,
    );
  }

  Widget _buildBodyText() {
    return Container(
      height: 120,
      child: Text(
        'By tapping Sign Up, you agree to our Terms, Data Policy and Cookies Policy. You may receive SMS notifications from us and can opt out any time.',
        style: Theme.of(context).textTheme.bodyText2,
        maxLines: 5,
      ),
    );
  }

  Widget _buildNextButton() {
    return Container(
      width: 300,
      height: 65,
      child: ElevatedButton(
        child: Text(
          'Sign Up',
          style: Theme.of(context).textTheme.button,
        ),
        onPressed: () => _submitForm(), //model.authenticate),
      ),
    );
  }

  void _submitForm() async {
    Navigator.pushReplacementNamed(context, '/home');
  }

  Widget _buildBodyWidget() {
    final List<Widget> _widgets = [
      SizedBox(height: 20),
      _buildHeading(),
      SizedBox(height: 10),
      _buildBodyText(),
      SizedBox(height: 20),
      _buildNextButton(),
    ];
    return Container(
      margin: EdgeInsets.fromLTRB(57, 0, 57, 0),
      child: ListView(
        children: _widgets,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSize _appBar = PreferredSize(
      preferredSize: Size.fromHeight(65),
      child: CAAppBar('Terms & Policy'),
    );

    return GradientBackground(_buildBodyWidget(), context, _appBar);
  }
}
