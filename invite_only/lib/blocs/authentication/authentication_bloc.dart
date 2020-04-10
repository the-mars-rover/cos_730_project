import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
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

    var _firebaseAuth = FirebaseAuth.instance;

    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: event.phoneNumber,
      timeout: Duration(seconds: 60),
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
      codeAutoRetrievalTimeout: (String verificationId) {
        // Do nothing
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
      var _firebaseAuth = FirebaseAuth.instance;

      AuthResult authResult =
          await _firebaseAuth.signInWithCredential(event.authCredential);
      yield AuthSuccess(authResult.user);
    } catch (e) {
      yield AuthFailure();
    }
  }

  Stream<AuthenticationState> _mapOtpSubmittedToState(
      OtpSubmitted event) async* {
    yield AuthLoading();

    var currentState = this.state;

    if (currentState is SendOtpSuccess) {
      AuthCredential authCredential = PhoneAuthProvider.getCredential(
          verificationId: currentState.verificationId, smsCode: event.otp);

      this.add(PhoneAuthSucceeded(authCredential));
    }
  }
}
