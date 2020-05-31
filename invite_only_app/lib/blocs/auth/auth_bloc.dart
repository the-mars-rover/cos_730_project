import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _inviteOnlyRepo = InviteOnlyRepo.instance;

  @override
  AuthState get initialState => AuthUninitialized();

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is InitializeAuth) {
      yield* _mapInitializeAuthToState(event);
    }

    if (event is SignIn) {
      yield* _mapSignInToState(event);
    }
  }

  Stream<AuthState> _mapInitializeAuthToState(InitializeAuth event) async* {
    yield AuthInProgress();

    String phone = await _inviteOnlyRepo.currentUser();
    if (phone == null) {
      yield UserUnauthenticated();
    } else {
      yield UserAuthenticated(phone);
    }
  }

  Stream<AuthState> _mapSignInToState(SignIn event) async* {
    yield AuthInProgress();

    try {
      await _inviteOnlyRepo.signInWithCredential(event.authCredential);
      String phoneNumber = await _inviteOnlyRepo.currentUser();

      yield UserAuthenticated(phoneNumber);
    } on AuthFailure catch (e) {
      yield AuthFailed('Sign in failed: ${e.reason}');
    }
  }

  static of(BuildContext context) => BlocProvider.of<AuthBloc>(context);
}
