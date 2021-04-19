import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:flutter_svg/avd.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    'savePassword': false
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

  Widget _buildLoginButton(double inputFieldWidth) {
    return Container(
      width: 300,
      height: 65,
      child: ElevatedButton(
          child: Text(
            'LOGIN',
            style: Theme.of(context).textTheme.button,
          ),
          onPressed: () => _authenticationLogin(), //model.authenticate),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  Theme.of(context).buttonColor),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(45),
                  side: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
              elevation: MaterialStateProperty.resolveWith<double>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return 0;
                  }
                  return 10;
                },
              ))),
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

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double inputFieldWidth = deviceWidth > 550 ? 450 : deviceWidth * 0.8;
    return Scaffold(
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Theme.of(context).cardColor,
                Theme.of(context).backgroundColor,
              ],
            ),
          ),
          child: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.fromLTRB(57, 68, 57, 0),
              child: ListView(
                children: [
                  _buildUsernameInput(),
                  SizedBox(height: 20),
                  _buildPasswordInput(),
                  SizedBox(height: 40),
                  _buildLoginButton(inputFieldWidth),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
