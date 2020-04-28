import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final _inviteOnlyRepo = InviteOnlyRepo.instance;

  @override
  AuthenticationState get initialState => InitialAuthenticationState();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is SignIn) {
      yield* _mapSignInToState(event);
    }
  }

  Stream<AuthenticationState> _mapSignInToState(SignIn event) async* {
    yield AuthenticationInProgress();

    try {
      await _inviteOnlyRepo.signInWithCredential(event.authCredential);
      yield UserAuthenticated();
    } on AuthFailure catch (e) {
      yield AuthenticationFailed('Sign in failed: ${e.reason}');
    }
  }
}
