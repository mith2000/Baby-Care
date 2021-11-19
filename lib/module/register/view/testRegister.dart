import 'package:flutter/material.dart';
import 'package:flutter_babycare/data/source/user_repository.dart';
import 'package:flutter_babycare/module/register/bloc/register_bloc.dart';
import 'package:flutter_babycare/module/register/view/testFormRegister.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  final UserRepository _userRepository;

  const RegisterScreen({Key key, UserRepository userRepository})
      : _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(
          color: Color(0xff6a515e),
        ),
      ),
      body: BlocProvider<RegisterBloc>(
        create: (context) => RegisterBloc(userRepository: _userRepository),
        child: SingleChildScrollView(child: RegisterForm()),
      ),
    );
  }
}
