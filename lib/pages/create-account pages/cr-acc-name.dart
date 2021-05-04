import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import 'cr-acc-email.dart';
import '../../UI widgets/gradient-bg.dart';
import '../../UI widgets/cr-acc-appbar.dart';

class CreateAccountName extends StatefulWidget {
  @override
  _CreateAccountNameState createState() => _CreateAccountNameState();
}

class _CreateAccountNameState extends State<CreateAccountName> {
  final Map<String, dynamic> _formData = {
    'username': null,
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildHeading() {
    return Text(
      'What can we call you?',
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline1,
    );
  }

  Widget _buildBodyText() {
    return Container(
      height: 100,
      child: Text(
        'Enter the name we should call you.',
        style: Theme.of(context).textTheme.bodyText2,
        maxLines: 3,
      ),
    );
  }

  Widget _buildUsernameInput() {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        hintText: "Username",
        hintStyle: Theme.of(context).textTheme.bodyText1,
        prefixIcon: Container(
          width: 10,
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(.3),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(45),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
      validator: (String value) {
        if (value.isEmpty) {
          return 'Your name is not correct.';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['username'] = value;
      },
    );
  }

  Widget _buildNextButton() {
    return Container(
      width: 300,
      height: 65,
      child: ElevatedButton(
        child: Text(
          'Next',
          style: Theme.of(context).textTheme.button,
        ),
        onPressed: () => _submitForm(), //model.authenticate),
      ),
    );
  }

  void _submitForm() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => CreateAccountEmail(),
      ),
    );
  }

  Widget _buildBodyWidget() {
    final List<Widget> _widgets = [
      SizedBox(height: 20),
      _buildHeading(),
      SizedBox(height: 10),
      _buildBodyText(),
      SizedBox(height: 10),
      _buildUsernameInput(),
      SizedBox(height: 20),
      _buildNextButton(),
    ];
    return Form(
      key: _formKey,
      child: Container(
        margin: EdgeInsets.fromLTRB(57, 0, 57, 0),
        child: ListView(
          children: _widgets,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PreferredSize _appBar = PreferredSize(
      preferredSize: Size.fromHeight(65),
      child: CAAppBar('Name'),
    );

    return GradientBackground(_buildBodyWidget(), context, _appBar);
  }
}
