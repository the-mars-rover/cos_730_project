import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationEvent {}

class PhoneSubmitted extends AuthenticationEvent {
  final String phoneNumber;

  PhoneSubmitted(this.phoneNumber);
}

class OtpSent extends AuthenticationEvent {
  final String phoneNumber;
  final String verificationId;
  final int resendToken;

  OtpSent(this.phoneNumber, this.verificationId, this.resendToken);
}

class PhoneAuthFailed extends AuthenticationEvent {
  final AuthException authException;

  PhoneAuthFailed(this.authException);
}

class PhoneAuthSucceeded extends AuthenticationEvent {
  final AuthCredential authCredential;

  PhoneAuthSucceeded(this.authCredential);
}

class OtpSubmitted extends AuthenticationEvent {
  final String otp;

  OtpSubmitted(this.otp);
}