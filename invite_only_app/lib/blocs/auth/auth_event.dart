import 'package:invite_only_repo/invite_only_repo.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthEvent {}

class InitializeAuth extends AuthEvent {}

class SendSmsCode extends AuthEvent {
  final String phoneNumber;

  SendSmsCode(this.phoneNumber);
}

class NotifyCodeSent extends AuthEvent {
  final String phoneNumber;
  final String verificationId;

  NotifyCodeSent(this.phoneNumber, this.verificationId);
}

class SubmitSmsCode extends AuthEvent {
  final String smsCode;

  SubmitSmsCode(this.smsCode);
}

class FailVerification extends AuthEvent {
  final AuthFailure authFailure;

  FailVerification(this.authFailure);
}

class SignIn extends AuthEvent {
  final authCredential;

  SignIn(this.authCredential);
}

class SignOut extends AuthEvent {}
