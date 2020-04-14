import 'package:equatable/equatable.dart';

abstract class PhoneVerificationState extends Equatable {
  const PhoneVerificationState();
}

class SendingSmsCode extends PhoneVerificationState {
  @override
  List<Object> get props => [];
}

class SmsCodeSent extends PhoneVerificationState {
  final String verificationId;

  SmsCodeSent(this.verificationId);

  @override
  List<Object> get props => [];
}

class ValidatingSmsCode extends PhoneVerificationState {
  @override
  List<Object> get props => [];
}

class PhoneNumberVerified extends PhoneVerificationState {
  final authCredential;

  PhoneNumberVerified(this.authCredential);

  @override
  List<Object> get props => [];
}

class PhoneVerificationError extends PhoneVerificationState {
  final String errorMessage;

  PhoneVerificationError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}