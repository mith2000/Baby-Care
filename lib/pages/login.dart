import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../UI widgets/gradient-bg.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final Map<String, dynamic> _formData = {
    'username': null,
    'password': null,
  };
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordTxtCtrl = TextEditingController();

  final Map<String, String> _icons = {
    'user': 'assets/icon/user.svg',
    'password': 'assets/icon/password.svg'
  };

  Widget _buildUsernameInput() {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        hintText: "Username",
        hintStyle: Theme.of(context).textTheme.bodyText1,
        prefixIcon: Container(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: SvgPicture.asset(
            _icons['user'],
            color: Color.fromRGBO(0, 0, 0, .5),
          ),
        ),
        filled: true,
        fillColor: Colors.white,
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
          return 'Phone Number is not correct.';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['username'] = value;
      },
    );
  }

  Widget _buildPasswordInput() {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyText1,
      decoration: InputDecoration(
        hintText: "●●●●●●",
        //counterText: "",
        counterStyle: TextStyle(
          fontSize: 10.0,
          color: Color.fromRGBO(0, 0, 0, .5),
        ),
        hintStyle: Theme.of(context).textTheme.bodyText1,
        prefixIcon: Container(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: SvgPicture.asset(
            _icons['password'],
            color: Color.fromRGBO(0, 0, 0, .5),
          ),
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(45),
          borderSide: BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [
        LengthLimitingTextInputFormatter(6),
      ],
      obscureText: true,
      controller: _passwordTxtCtrl,
      validator: (String value) {
        if (value.isEmpty ||
            value.trim().length < 6 ||
            //value must be a number
            !RegExp(r'^(?:[1-9]\d*|0)?$').hasMatch(value)) {
          return 'Password is not correct.';
        }
        return null;
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  void _authenticationLogin(//Function authenticate
      ) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Navigator.pushReplacementNamed(context, '/home');
    // Map<String, dynamic> successInformation = await authenticate(
    //     _formData['username'], _formData['password'], _authMode);

    // if (successInformation['success']) {
    //   Navigator.pushReplacementNamed(context, '/');
    // } else {
    //   showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return AlertDialog(
    //         title: Text('An Error Occurred'),
    //         content: Text(successInformation['MESSAGE']),
    //         actions: [
    //           FlatButton(
    //             child: Text('OK'),
    //             onPressed: () {
    //               Navigator.of(context).pop();
    //             },
    //           )
    //         ],
    //       );
    //     },
    //   );
    // }
  }

  Widget _buildLoginButton() {
    return Container(
      width: 300,
      height: 65,
      child: ElevatedButton(
        child: Text(
          'LOGIN',
          style: Theme.of(context).textTheme.button,
        ),
        onPressed: () => _authenticationLogin(), //model.authenticate),
      ),
    );
    // return ScopedModelDescendant<MainModel>(
    //     builder: (BuildContext context, Widget child, MainModel model) {
    //   return model.isLoading
    //       ? CircularProgressIndicator()
    //       : Container(
    //           width: inputFieldWidth,
    //           height: 50,
    //           child: RaisedButton(
    //             child: Text(
    //               _authMode == AuthMode.Login ? 'LOGIN' : 'SIGNUP',
    //               style: TextStyle(color: Colors.white),
    //             ),
    //             onPressed: () => _authenticationLogin(model.authenticate),
    //             shape: RoundedRectangleBorder(
    //               borderRadius: BorderRadius.circular(25),
    //               side: BorderSide(
    //                 width: 0,
    //                 style: BorderStyle.none,
    //               ),
    //             ),
    //           ),
    //         );
    // });
  }

  Widget _buildForgetPasswordButton() {
    return Container(
      width: 200,
      height: 45,
      child: TextButton(
        child: Text(
          'Forget Password?',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        onPressed: () {},
        style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(45),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCreateAccountButton() {
    return Container(
      width: 300,
      height: 65,
      child: ElevatedButton(
        child: Text(
          'Create New Account',
          style: Theme.of(context).textTheme.bodyText1,
        ),
        onPressed: () => Navigator.pushNamed(
            context, '/create_account'), //model.authenticate),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Color.fromRGBO(255, 255, 255, .50),
          ),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          elevation: MaterialStateProperty.all<double>(0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double inputFieldWidth = deviceWidth > 550 ? 450 : deviceWidth * 0.8;
    final List<Widget> _widgets = [
      SizedBox(height: 68),
      _buildUsernameInput(),
      SizedBox(height: 20),
      _buildPasswordInput(),
      SizedBox(height: 40),
      _buildLoginButton(),
      SizedBox(height: 20),
      _buildForgetPasswordButton(),
      Expanded(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: _buildCreateAccountButton(),
        ),
      ),
      SizedBox(height: 20),
    ];

    return GradientBackground(_formKey, _widgets, context);
  }
}
