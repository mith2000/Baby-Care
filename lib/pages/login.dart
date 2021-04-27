import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:form_field_validator/form_field_validator.dart';

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

  final Map<String, String> _icons = {
    'user': 'assets/icon/user.svg',
    'password': 'assets/icon/password.svg',
    'facebook': 'assets/icon/facebook.svg',
    'google': 'assets/icon/google.svg',
  };

  final usernameValidator = MultiValidator([
    RequiredValidator(errorText: 'Required'),
    PatternValidator(r'^[a-zA-Z0-9.]+$', errorText: 'Character only')
  ]);

  final passwordValidator = MultiValidator([
    RequiredValidator(errorText: 'Required'),
    MinLengthValidator(6, errorText: 'At least 6 digits long'),
    PatternValidator(r'^[0-9]*$', errorText: 'Number only')
  ]);

  Widget _buildUsernameInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
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
          fillColor: Colors.white.withOpacity(.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
            borderSide: BorderSide(
              width: 0,
              style: BorderStyle.none,
            ),
          ),
        ),
        validator: usernameValidator,
        onSaved: (String value) {
          _formData['username'] = value;
        },
      ),
    );
  }

  Widget _buildPasswordInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: TextFormField(
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
          fillColor: Colors.white.withOpacity(.3),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(32),
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
        validator: passwordValidator,
        onSaved: (String value) {
          _formData['password'] = value;
        },
      ),
    );
  }

  void _authenticationLogin(//Function authenticate
      ) async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    Navigator.pushReplacementNamed(context, '/home');
  }

  Widget _buildLoginButton() {
    return Container(
      width: 300,
      height: 65,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: ElevatedButton(
        child: Text(
          'LOGIN',
          style: Theme.of(context).textTheme.button,
        ),
        onPressed: () => _authenticationLogin(), //model.authenticate),
      ),
    );
  }

  Widget _buildForgetPasswordButton() {
    return Container(
      width: 200,
      height: 45,
      child: TextButton(
        child: Text(
          'Forget Password?',
          style: Theme.of(context).textTheme.headline2,
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

  Widget _buildOtherAccountButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ClipOval(
          child: TextButton(
            child: SvgPicture.asset(
              _icons['facebook'],
            ),
            onPressed: () {},
          ),
        ),
        ClipOval(
          child: TextButton(
            child: SvgPicture.asset(
              _icons['google'],
            ),
            onPressed: () {},
          ),
        ),
      ],
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
            Color.fromRGBO(255, 255, 255, .5),
          ),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32),
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
    final double inputFieldWidth = deviceWidth * 0.9;
    final List<Widget> _inGlassWidgets = [
      _buildUsernameInput(),
      SizedBox(height: 20),
      _buildPasswordInput(),
      SizedBox(height: 40),
      _buildLoginButton(),
      SizedBox(height: 20),
      _buildForgetPasswordButton(),
    ];

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: GestureDetector(
          onTap: () {
            //tap out of container will close the keyboard
            FocusScope.of(context).requestFocus(FocusNode());
          },
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
              child: Stack(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    margin: EdgeInsets.only(left: 280),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          HexColor('#EEBCCB'),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 50,
                    height: 50,
                    margin: EdgeInsets.only(top: 10, left: 75),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          HexColor('#EEBCCB'),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 130,
                    height: 130,
                    margin: EdgeInsets.only(top: 250),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          HexColor('#EEBCCB'),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(47, 30, 47, 0),
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 430,
                      child: GlassContainer(
                        height: 430,
                        width: inputFieldWidth,
                        gradient: new RadialGradient(
                          colors: [
                            Colors.white.withOpacity(.42),
                            Colors.white.withOpacity(.06),
                          ],
                          radius: 1,
                          center: Alignment(-0.66, -0.66),
                        ),
                        blur: 12,
                        borderColor: Colors.white.withOpacity(.3),
                        borderRadius: BorderRadius.circular(32.0),
                        borderWidth: 1.0,
                        elevation: 10.0,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: _inGlassWidgets,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: 80,
                    height: 80,
                    margin: EdgeInsets.only(top: 320, left: 300),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.white,
                          HexColor('#EEBCCB'),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildOtherAccountButtons(),
                      SizedBox(height: 20),
                      _buildCreateAccountButton(),
                      SizedBox(height: 20),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
