import 'package:equatable/equatable.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

abstract class PhoneVerificationEvent extends Equatable {
  const PhoneVerificationEvent();
}

class SendSmsCode extends PhoneVerificationEvent {
  final String phoneNumber;

  SendSmsCode(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class SubmitSmsCode extends PhoneVerificationEvent {
  final String smsCode;

  SubmitSmsCode(this.smsCode);

  @override
  List<Object> get props => [smsCode];
}

class CompleteVerification extends PhoneVerificationEvent {
  final authCredential;

  CompleteVerification(this.authCredential);

  @override
  List<Object> get props => [authCredential];
}

class FailVerification extends PhoneVerificationEvent {
  final AuthFailure authFailure;

  FailVerification(this.authFailure);

  @override
  List<Object> get props => [authFailure];
}

class NotifyCodeSent extends PhoneVerificationEvent {
  final String verificationId;

  NotifyCodeSent(this.verificationId);

  @override
  List<Object> get props => [verificationId];
}
