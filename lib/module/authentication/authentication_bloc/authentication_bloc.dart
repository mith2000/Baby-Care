import 'package:flutter_babycare/data/source/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({UserRepository userRepository})
      : this.userRepository = userRepository,
        super(AuthenticationInitial());

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AuthenticationStarted) {
      yield* mapAuthenticationStartedToState();
    } else if (event is AuthenticationLoggedIn) {
      yield* mapAuthenticationLoggedInToState();
    } else if (event is AuthenticationLoggedOut) {
      yield* mapAuthenticationLoggedOutToState();
    }
  }

  //AuthenticationLoggedOut
  Stream<AuthenticationState> mapAuthenticationLoggedOutToState() async* {
    yield AuthenticationFailure();
    userRepository.signOut();
  }

  //AuthenticationLoggedIn
  Stream<AuthenticationState> mapAuthenticationLoggedInToState() async* {
    yield AuthenticationSuccess(await userRepository.getUser());
  }

  //AuthenticationStarted
  Stream<AuthenticationState> mapAuthenticationStartedToState() async* {
    final isSignIn = await userRepository.isSignedIn();
    if (isSignIn) {
      final firebaseUser = await userRepository.getUser();
      yield AuthenticationSuccess(firebaseUser);
    } else {
      yield AuthenticationFailure();
    }
  }
}
