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

    if (event is SendSmsCode) {
      yield* _mapSendSmsCodeToState(event);
    }

    if (event is NotifyCodeSent) {
      yield* _mapNotifyCodeSentToState(event);
    }

    if (event is SubmitSmsCode) {
      yield* _mapSubmitSmsCodeToState(event);
    }

    if (event is FailVerification) {
      yield* _mapFailVerificationToState(event);
    }

    if (event is SignIn) {
      yield* _mapSignInToState(event);
    }

    if (event is SignOut) {
      yield* _mapSignOutToState(event);
    }
  }

  Stream<AuthState> _mapInitializeAuthToState(InitializeAuth event) async* {
    yield AuthInProgress();

    String phone = await _inviteOnlyRepo.currentUser();
    if (phone == null) {
      yield UserUnauthenticated();
    } else {
      yield UserAuthenticated(phone, false);
    }
  }

  Stream<AuthState> _mapSendSmsCodeToState(SendSmsCode event) async* {
    yield AuthInProgress();

    try {
      await _inviteOnlyRepo.verifyPhoneNumber(
        phoneNumber: event.phoneNumber,
        retrievalTimeout: Duration(seconds: 60),
        verificationCompleted: (authCredential) {
          this.add(SignIn(authCredential));
        },
        verificationFailed: (authException) {
          this.add(FailVerification(authException));
        },
        codeSent: (verificationId, [forceResendingToken]) {
          this.add(NotifyCodeSent(event.phoneNumber, verificationId));
        },
      );
    } catch (e) {
      yield AuthFailed(
          'Sorry, an unexpected error occurred. Please try again later.');
    }
  }

  Stream<AuthState> _mapSignInToState(SignIn event) async* {
    yield AuthInProgress();

    try {
      await _inviteOnlyRepo.signInWithCredential(event.authCredential);
      String phoneNumber = await _inviteOnlyRepo.currentUser();

      yield UserAuthenticated(phoneNumber, true);
    } on AuthFailure {
      yield AuthFailed(
          'The phone number could not be verified. Please try again.');
    }
  }

  Stream<AuthState> _mapFailVerificationToState(FailVerification event) async* {
    yield AuthFailed(
        'The phone number could not be verified. Please try again.');
  }

  Stream<AuthState> _mapNotifyCodeSentToState(NotifyCodeSent event) async* {
    yield SmsCodeSent(event.phoneNumber, event.verificationId);
  }

  Stream<AuthState> _mapSubmitSmsCodeToState(SubmitSmsCode event) async* {
    var currentState = state;
    if (currentState is SmsCodeSent) {
      try {
        var authCredential = _inviteOnlyRepo.getAuthCredential(
          currentState.verificationId,
          event.smsCode,
        );

        this.add(SignIn(authCredential));
      } catch (e) {
        yield AuthFailed(
            'The phone number could not be verified. Please try again.');
      }
    }
  }

  Stream<AuthState> _mapSignOutToState(SignOut event) async* {
    await _inviteOnlyRepo.signOut();
    yield UserUnauthenticated();
  }

  static of(BuildContext context) => BlocProvider.of<AuthBloc>(context);

  String get phoneNumber {
    final currState = state;
    if (currState is UserAuthenticated) {
      return currState.phoneNumber;
    }

    return null;
  }
}
