import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/module/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_babycare/module/authentication/authentication_bloc/authentication_event.dart';
import 'package:flutter_babycare/module/register/bloc/register_bloc.dart';
import 'package:flutter_babycare/module/register/bloc/register_event.dart';
import 'package:flutter_babycare/module/register/bloc/register_state.dart';
import 'package:flutter_babycare/utils/UI_components/custom_dialog.dart';
import 'package:flutter_babycare/utils/UI_components/icon_button.dart';
import 'package:flutter_babycare/utils/UI_components/loading_widget.dart';
import 'package:flutter_babycare/utils/UI_components/mini_line_button.dart';
import 'package:flutter_babycare/utils/UI_components/mini_solid_button.dart';
import 'package:flutter_babycare/utils/UI_components/title_label.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class RegisterView extends StatefulWidget {
  static const routeName = '/register';

  const RegisterView({Key key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  Map<String, String> _formData = {
    'username': null,
    'email': null,
    'password': null,
  };
  var _formKey = GlobalKey<FormState>();
  bool _obscure = true;
  var _usernameController = TextEditingController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _confirmPasswordController = TextEditingController();
  bool _isCorrectPasswordConfirm = false;

  RegisterBloc _registerBloc;

  var _icons = {
    'unobscure': 'assets/icon/unobscure.svg',
    'true': 'assets/icon/true.svg',
    'false': 'assets/icon/false.svg',
  };

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _usernameController.addListener(_onUsernameChange);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state.isFailure) {
            showDialog(
              context: context,
              builder: (_) => CustomDialog(
                title: 'Register failed',
                content: 'Your email is used',
                ok: 'Ok',
                onOk: () => Navigator.pop(context),
              ),
            );
          }

          if (state.isSuccess) {
            BlocProvider.of<AuthenticationBloc>(context).add(
              AuthenticationLoggedIn(),
            );
            Navigator.pop(context);
          }
        },
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, state) {
            if (state.isSubmitting) {
              return CustomLoadingWidget();
            }

            return SafeArea(
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
                              TitleLabel(
                                  'Sign up now to enjoy our amazing features'),
                              _buildUsernameInput(state),
                              _buildEmailInput(state),
                              _buildPasswordInput(state),
                              _buildConfirmPasswordInput(),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              _buildConfirmLable(),
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
            );
          },
        ),
      ),
    );
  }

  Widget _buildUsernameInput(RegisterState state) {
    return Container(
      margin: EdgeInsets.only(
        left: AppConstants.paddingSuperLargeW,
        right: AppConstants.paddingSuperLargeW,
        top: AppConstants.paddingLargeH,
      ),
      child: TextFormField(
        controller: _usernameController,
        style: Theme.of(context).textTheme.headline1,
        decoration: InputDecoration(
          hintText: "Username",
          hintStyle: Theme.of(context).textTheme.headline1,
          errorStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: AppColors.danger,
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
        keyboardType: TextInputType.name,
        onSaved: (String value) {
          _formData['username'] = value;
        },
        validator: (value) {
          if (value.length < 1)
            return "Required";
          else if (!state.isUsernameValid)
            return "Invalid Name";
          else
            return null;
        },
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
      ),
    );
  }

  Widget _buildEmailInput(RegisterState state) {
    return Container(
      margin: EdgeInsets.only(
        left: AppConstants.paddingSuperLargeW,
        right: AppConstants.paddingSuperLargeW,
        top: AppConstants.paddingLargeH,
      ),
      child: TextFormField(
        controller: _emailController,
        style: Theme.of(context).textTheme.headline1,
        decoration: InputDecoration(
          hintText: "Email",
          hintStyle: Theme.of(context).textTheme.headline1,
          errorStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: AppColors.danger,
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
        validator: (value) {
          if (value.length < 1)
            return "Required";
          else if (!state.isEmailValid)
            return "Invalid Email";
          else
            return null;
        },
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
      ),
    );
  }

  Widget _buildPasswordInput(RegisterState state) {
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
          hintText: "Password",
          hintStyle: Theme.of(context).textTheme.headline1,
          errorStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: AppColors.danger,
          ),
          suffixIcon: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.paddingLargeW,
            ),
            child: CircleIconButton(
              SvgPicture.asset(
                _icons['unobscure'],
              ),
              _toggleObscurePassword,
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
        obscureText: _obscure,
        onSaved: (String value) {
          _formData['password'] = value;
        },
        validator: (String value) {
          if (value.length < 6)
            return "Enter at least 6 chars";
          else if (!state.isPasswordValid)
            return "Number only";
          else
            return null;
        },
        onChanged: (String value) {
          setState(() {
            if (value != _confirmPasswordController.text) {
              _isCorrectPasswordConfirm = false;
            } else {
              _isCorrectPasswordConfirm = true;
            }
          });
        },
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
      ),
    );
  }

  Widget _buildConfirmPasswordInput() {
    return Container(
      margin: EdgeInsets.only(
        left: AppConstants.paddingSuperLargeW,
        right: AppConstants.paddingSuperLargeW,
        top: AppConstants.paddingLargeH,
      ),
      child: TextFormField(
        controller: _confirmPasswordController,
        style: Theme.of(context).textTheme.headline1,
        decoration: InputDecoration(
          hintText: "Confirm Password",
          hintStyle: Theme.of(context).textTheme.headline1,
          errorStyle: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: AppColors.danger,
          ),
          suffixIcon: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppConstants.paddingLargeW,
            ),
            child: SvgPicture.asset(
              _isCorrectPasswordConfirm == false
                  ? _icons['false']
                  : _icons['true'],
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
        obscureText: _obscure,
        validator: (String value) {
          if (value != _passwordController.text) {
            return 'Password do not match.';
          }
          return null;
        },
        onChanged: (String value) {
          setState(() {
            if (value != _passwordController.text) {
              _isCorrectPasswordConfirm = false;
            } else {
              _isCorrectPasswordConfirm = true;
            }
          });
        },
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.cornerRadius),
      ),
    );
  }

  Widget _buildConfirmLable() {
    return RichText(
      text: new TextSpan(
        style: Theme.of(context).textTheme.bodyText1,
        children: <TextSpan>[
          new TextSpan(text: 'By tapping Sign up, you agree to our '),
          new TextSpan(
            text: 'Terms, Data policy',
            style: new TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
              color: AppColors.primary,
            ),
          ),
          new TextSpan(text: ' and '),
          new TextSpan(
            text: 'Cookies policy',
            style: new TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18.sp,
              color: AppColors.primary,
            ),
          ),
          new TextSpan(text: '.'),
        ],
      ),
    );
  }

  Widget _buildMainButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MiniLineButton('Back', _onBackPressed),
        SizedBox(width: AppConstants.paddingLargeW),
        MiniSolidButton('Sign Up', _onRegisterPressed),
      ],
    );
  }

  void _toggleObscurePassword() {
    setState(() {
      _obscure = !_obscure;
    });
  }

  void _onUsernameChange() {
    _registerBloc
        .add(RegisterUsernameChanged(username: _usernameController.text));
  }

  void _onEmailChange() {
    _registerBloc.add(RegisterEmailChanged(email: _emailController.text));
  }

  void _onPasswordChange() {
    _registerBloc
        .add(RegisterPasswordChanged(password: _passwordController.text));
  }

  void _onBackPressed() {
    Navigator.pop(context);
  }

  void _onRegisterPressed() {
    setState(() {
      if (!_formKey.currentState.validate()) {
        return;
      }
      _formKey.currentState.save();

      _registerBloc.add(RegisterSubmitted(
          username: _usernameController.text,
          email: _emailController.text,
          password: _passwordController.text));
    });
  }
}
