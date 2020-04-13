import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:invite_only_auth/invite_only_auth.dart';
import './bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final _authRepository = AuthRepository.instance;

  @override
  AuthenticationState get initialState => InitialAuthenticationState();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthInit) {
      yield* _mapAuthInitToState(event);
    }

    if (event is SignIn) {
      yield* _mapSignInToState(event);
    }
  }

  Stream<AuthenticationState> _mapAuthInitToState(AuthInit event) async* {
    yield AuthenticationInProgress();

    var user = await _authRepository.currentUser();
    if (user != null) {
      yield UserAuthenticated(user);
    } else {
      yield InitialAuthenticationState();
    }
  }

  Stream<AuthenticationState> _mapSignInToState(SignIn event) async* {
    yield AuthenticationInProgress();

    try {
      var user =
          await _authRepository.signInWithCredential(event.authCredential);
      yield UserAuthenticated(user);
    } on AuthFailure catch (e) {
      yield AuthenticationFailed(e.reason);
    }
  }
}
