import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:invite_only_auth/invite_only_auth.dart';
import './bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthRepository _authRepository = AuthRepository.instance;

  @override
  AuthenticationState get initialState => AuthInitial();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is PhoneSubmitted) {
      yield* _mapPhoneSubmittedToState(event);
    } else if (event is OtpSent) {
      yield* _mapOtpSent(event);
    } else if (event is PhoneAuthFailed) {
      yield* _mapPhoneAuthFailedToState(event);
    } else if (event is PhoneAuthSucceeded) {
      yield* _mapPhoneAuthSucceededToState(event);
    } else if (event is OtpSubmitted) {
      yield* _mapOtpSubmittedToState(event);
    }
  }

  Stream<AuthenticationState> _mapPhoneSubmittedToState(
      PhoneSubmitted event) async* {
    yield AuthLoading();

    await _authRepository.verifyPhoneNumber(
      phoneNumber: event.phoneNumber,
      retrievalTimeout: Duration(seconds: 60),
      verificationCompleted: (authCredential) {
        this.add(PhoneAuthSucceeded(authCredential));
      },
      verificationFailed: (authException) {
        this.add(PhoneAuthFailed(authException));
      },
      codeSent: (verificationId, [forceResendingToken]) {
        this.add(
            OtpSent(event.phoneNumber, verificationId, forceResendingToken));
      },
    );
  }

  Stream<AuthenticationState> _mapOtpSent(OtpSent event) async* {
    yield SendOtpSuccess(
        event.phoneNumber, event.verificationId, event.resendToken);
  }

  Stream<AuthenticationState> _mapPhoneAuthFailedToState(
      PhoneAuthFailed event) async* {
    yield AuthFailure();
  }

  Stream<AuthenticationState> _mapPhoneAuthSucceededToState(
      PhoneAuthSucceeded event) async* {
    yield AuthLoading();

    try {
      User user =
          await _authRepository.signInWithCredential(event.authCredential);
      yield AuthSuccess(user);
    } catch (e) {
      yield AuthFailure();
    }
  }

  Stream<AuthenticationState> _mapOtpSubmittedToState(
      OtpSubmitted event) async* {
    yield AuthLoading();

    var currentState = this.state;

    if (currentState is SendOtpSuccess) {
      var authCredential = _authRepository.getAuthCredential(
          currentState.verificationId, event.otp);

      this.add(PhoneAuthSucceeded(authCredential));
    }
  }
}
