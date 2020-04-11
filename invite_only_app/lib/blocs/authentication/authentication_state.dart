import 'package:invite_only_auth/invite_only_auth.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState {}

class AuthInitial extends AuthenticationState {}

class AuthLoading extends AuthenticationState {}

class SendOtpSuccess extends AuthenticationState {
  final String phoneNumber;
  final String verificationId;
  final int resendToken;

  SendOtpSuccess(this.phoneNumber,this.verificationId, this.resendToken);
}

class AuthFailure extends AuthenticationState {
  AuthFailure();
}

class AuthSuccess extends AuthenticationState {
  final User user;

  AuthSuccess(this.user);
}