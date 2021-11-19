import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/utils/UI_components/icon_button.dart';
import 'package:flutter_babycare/utils/UI_components/mini_line_button.dart';
import 'package:flutter_babycare/utils/UI_components/mini_solid_button.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  Map<String, String> _formData = {
    'email': null,
    'password': null,
  };
  var _formKey = GlobalKey<FormState>();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  String _emailErrorNotify;
  String _passwordErrorNotify;

  var _icons = {
    'user': 'assets/icon/login_user.svg',
    'password': 'assets/icon/login_password.svg',
    'facebook': 'assets/icon/facebook.svg',
    'google': 'assets/icon/google.svg',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(FocusNode());
            },
            child: Container(
              color: AppColors.background,
              padding: EdgeInsets.symmetric(
                horizontal: AppConstants.paddingAppW,
                vertical: AppConstants.paddingAppH,
              ),
              child: Form(
                key: _formKey,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        _buildEmailInput(),
                        _buildPasswordInput(),
                        _buildForgetPasswordButton(),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildOtherAccountButtons(),
                        SizedBox(height: AppConstants.paddingLargeH),
                        _buildMainButtons(),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailInput() {
    return Container(
      margin: EdgeInsets.only(
        left: AppConstants.paddingSuperLargeW,
        right: AppConstants.paddingSuperLargeW,
        top: AppConstants.paddingSuperLargeH,
      ),
      child: TextFormField(
        controller: _emailController,
        style: Theme.of(context).textTheme.headline1,
        decoration: InputDecoration(
          hintText: "Email",
          hintStyle: Theme.of(context).textTheme.headline1,
          errorText: _emailErrorNotify,
          errorStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: AppColors.danger,
          ),
          prefixIcon: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.paddingLargeW,
              vertical: AppConstants.paddingLargeH,
            ),
            child: SvgPicture.asset(
              _icons['user'],
            ),
          ),
          filled: true,
          fillColor: AppColors.whiteBackground,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
            borderSide: BorderSide(
              width: 1.w,
              color: AppColors.primary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
            borderSide: BorderSide(
              width: 1.w,
              color: AppColors.stroke,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
            borderSide: BorderSide(
              width: 1.w,
              color: AppColors.danger,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
            borderSide: BorderSide(
              width: 1.w,
              color: AppColors.danger,
            ),
          ),
        ),
        keyboardType: TextInputType.emailAddress,
        onSaved: (String value) {
          _formData['email'] = value;
        },
        validator: (String value) {
          if (value.length < 1)
            return "Required";
          else if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value))
            return "Must be an email";
          else
            return null;
        },
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
      ),
    );
  }

  Widget _buildPasswordInput() {
    return Container(
      margin: EdgeInsets.only(
        left: AppConstants.paddingSuperLargeW,
        right: AppConstants.paddingSuperLargeW,
        top: AppConstants.paddingLargeH,
      ),
      child: TextFormField(
        controller: _passwordController,
        style: Theme.of(context).textTheme.headline1,
        decoration: InputDecoration(
          hintText: "●●●●●●",
          hintStyle: Theme.of(context).textTheme.headline1,
          errorText: _passwordErrorNotify,
          errorStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: AppColors.danger,
          ),
          prefixIcon: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.paddingLargeW,
              vertical: AppConstants.paddingLargeH,
            ),
            child: SvgPicture.asset(
              _icons['password'],
            ),
          ),
          filled: true,
          fillColor: AppColors.whiteBackground,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
            borderSide: BorderSide(
              width: 1.w,
              color: AppColors.primary,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
            borderSide: BorderSide(
              width: 1.w,
              color: AppColors.stroke,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
            borderSide: BorderSide(
              width: 1.w,
              color: AppColors.danger,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
            borderSide: BorderSide(
              width: 1.w,
              color: AppColors.danger,
            ),
          ),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: [
          LengthLimitingTextInputFormatter(6),
        ],
        obscureText: true,
        onSaved: (String value) {
          _formData['password'] = value;
        },
        validator: (String value) {
          if (value.length < 6)
            return "Enter at least 6 chars";
          else
            return null;
        },
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
      ),
    );
  }

  Widget _buildForgetPasswordButton() {
    return Container(
      margin: EdgeInsets.only(
        top: AppConstants.paddingLargeH,
      ),
      child: TextButton(
        onPressed: () {},
        child: Text(
          'Forget password?',
          style: Theme.of(context).textTheme.headline1,
        ),
      ),
    );
  }

  Widget _buildOtherAccountButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleIconButton(
            SvgPicture.asset(
              _icons['facebook'],
            ), () {
          print('success');
        }),
        SizedBox(width: AppConstants.paddingLargeW),
        CircleIconButton(
            SvgPicture.asset(
              _icons['google'],
            ), () {
          print('success');
        }),
      ],
    );
  }

  Widget _buildMainButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MiniLineButton('Login', _login),
        SizedBox(width: AppConstants.paddingLargeW),
        MiniSolidButton('Create New Account', () {
          print('success');
        }),
      ],
    );
  }

  void _login() {
    setState(() {
      if (!_formKey.currentState.validate()) {
        return;
      }
      _formKey.currentState.save();
      print('Email: ' + _formData['email']);
      print('Password: ' + _formData['password']);
      // Call LoginAPI and navigate home if success
    });
  }
}
