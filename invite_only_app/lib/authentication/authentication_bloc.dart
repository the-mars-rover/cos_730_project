import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

import 'authentication_event.dart';
import 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final _inviteOnlyRepo = InviteOnlyRepo.instance;

  @override
  AuthenticationState get initialState => AuthenticationInProgress();

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

    var currentUser = await _inviteOnlyRepo.currentUser();
    if (currentUser != null) {
      yield UserAuthenticated();
    } else {
      yield InitialAuthenticationState();
    }
  }

  Stream<AuthenticationState> _mapSignInToState(SignIn event) async* {
    yield AuthenticationInProgress();

    try {
      await _inviteOnlyRepo.signInWithCredential(event.authCredential);
      yield UserAuthenticated();
    } on AuthFailure {
      yield AuthenticationFailed('Sign in failed. Please try again.');
    }
  }
}
