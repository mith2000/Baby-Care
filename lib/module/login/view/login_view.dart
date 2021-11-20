import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_babycare/constants/app_constants.dart';
import 'package:flutter_babycare/data/source/user_repository.dart';
import 'package:flutter_babycare/module/authentication/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_babycare/module/authentication/authentication_bloc/authentication_event.dart';
import 'package:flutter_babycare/module/login/bloc/login_bloc.dart';
import 'package:flutter_babycare/module/login/bloc/login_event.dart';
import 'package:flutter_babycare/module/login/bloc/login_state.dart';
import 'package:flutter_babycare/module/register/view/testRegister.dart';
import 'package:flutter_babycare/utils/UI_components/icon_button.dart';
import 'package:flutter_babycare/utils/UI_components/mini_line_button.dart';
import 'package:flutter_babycare/utils/UI_components/mini_solid_button.dart';
import 'package:flutter_babycare/utils/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class LoginView extends StatefulWidget {
  final UserRepository _userRepository;
  const LoginView(UserRepository userRepository, {Key key})
      : _userRepository = userRepository,
        super(key: key);

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

  LoginBloc _loginBloc;

  var _icons = {
    'user': 'assets/icon/login_user.svg',
    'password': 'assets/icon/login_password.svg',
    'facebook': 'assets/icon/facebook.svg',
    'google': 'assets/icon/google.svg',
  };

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChange);
    _passwordController.addListener(_onPasswordChange);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state.isFailure) {
            Scaffold(body: Text('Login Failure'));
          }

          if (state.isSubmitting) {
            Scaffold(body: Text('Logging In...'));
          }

          if (state.isSuccess) {
            BlocProvider.of<AuthenticationBloc>(context).add(
              AuthenticationLoggedIn(),
            );
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
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
                              _buildEmailInput(state),
                              _buildPasswordInput(state),
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
            );
          },
        ),
      ),
    );
  }

  Widget _buildEmailInput(LoginState state) {
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

  Widget _buildPasswordInput(LoginState state) {
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
          else if (!state.isPasswordValid)
            return "Number only";
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
        MiniLineButton('Login', _onLoginPressed),
        SizedBox(width: AppConstants.paddingLargeW),
        MiniSolidButton('Create New Account', _onCreateAccountPressed),
      ],
    );
  }

  void _onEmailChange() {
    _loginBloc.add(LoginEmailChange(email: _emailController.text));
  }

  void _onPasswordChange() {
    _loginBloc.add(LoginPasswordChanged(password: _passwordController.text));
  }

  void _onLoginPressed() {
    setState(() {
      if (!_formKey.currentState.validate()) {
        return;
      }
      _formKey.currentState.save();

      _loginBloc.add(LoginWithCredentialsPressed(
          email: _emailController.text, password: _passwordController.text));
    });
  }

  void _onCreateAccountPressed() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegisterScreen(
          userRepository: widget._userRepository,
        ),
      ),
    );
  }
}
