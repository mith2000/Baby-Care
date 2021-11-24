import 'package:flutter_babycare/data/source/user_repository.dart';
import 'package:flutter_babycare/module/register/bloc/register_event.dart';
import 'package:flutter_babycare/module/register/bloc/register_state.dart';
import 'package:flutter_babycare/utils/validators.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final UserRepository _userRepository;

  RegisterBloc({UserRepository userRepository})
      : _userRepository = userRepository,
        super(RegisterState.initial());

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    if (event is RegisterUsernameChanged) {
      yield* _mapRegisterUsernameChangeToState(event.username);
    } else if (event is RegisterEmailChanged) {
      yield* _mapRegisterEmailChangeToState(event.email);
    } else if (event is RegisterPasswordChanged) {
      yield* _mapRegisterPasswordChangeToState(event.password);
    } else if (event is RegisterSubmitted) {
      yield* _mapRegisterSubmittedToState(
          username: event.username,
          email: event.email,
          password: event.password);
    }
  }

  Stream<RegisterState> _mapRegisterUsernameChangeToState(
      String username) async* {
    yield state.update(isUsernameValid: Validators.isValidUsername(username));
  }

  Stream<RegisterState> _mapRegisterEmailChangeToState(String email) async* {
    yield state.update(isEmailValid: Validators.isValidEmail(email));
  }

  Stream<RegisterState> _mapRegisterPasswordChangeToState(
      String password) async* {
    yield state.update(isPasswordValid: Validators.isValidPassword(password));
  }

  Stream<RegisterState> _mapRegisterSubmittedToState(
      {String username, String email, String password}) async* {
    yield RegisterState.loading();
    try {
      await _userRepository.signUp(email, password, username);
      yield RegisterState.success();
    } catch (error) {
      print(error);
      yield RegisterState.failure();
    }
  }
}
