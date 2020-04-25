import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

import 'phone_verification_event.dart';
import 'phone_verification_state.dart';

class PhoneVerificationBloc
    extends Bloc<PhoneVerificationEvent, PhoneVerificationState> {
  final _inviteOnlyRepo = InviteOnlyRepo.instance;

  @override
  PhoneVerificationState get initialState => SendingSmsCode();

  @override
  Stream<PhoneVerificationState> mapEventToState(
    PhoneVerificationEvent event,
  ) async* {
    if (event is SendSmsCode) {
      yield* _mapSendSmsCodeToState(event);
    }

    if (event is SubmitSmsCode) {
      yield* _mapSubmitSmsCodeToState(event);
    }

    if (event is CompleteVerification) {
      yield* _mapCompleteVerificationToState(event);
    }

    if (event is FailVerification) {
      yield* _mapFailVerificationToState(event);
    }

    if (event is NotifyCodeSent) {
      yield* _mapNotifyCodeSentToState(event);
    }
  }

  Stream<PhoneVerificationState> _mapSendSmsCodeToState(
      SendSmsCode event) async* {
    yield SendingSmsCode();

    await _inviteOnlyRepo.verifyPhoneNumber(
      phoneNumber: event.phoneNumber,
      retrievalTimeout: Duration(seconds: 60),
      verificationCompleted: (authCredential) {
        this.add(CompleteVerification(authCredential));
      },
      verificationFailed: (authException) {
        this.add(FailVerification(authException));
      },
      codeSent: (verificationId, [forceResendingToken]) {
        this.add(NotifyCodeSent(verificationId));
      },
    );
  }

  Stream<PhoneVerificationState> _mapSubmitSmsCodeToState(
      SubmitSmsCode event) async* {
    var currentState = state;
    if (currentState is SmsCodeSent) {
      var authCredential = _inviteOnlyRepo.getAuthCredential(
        currentState.verificationId,
        event.smsCode,
      );

      yield PhoneNumberVerified(authCredential);
    }
  }

  Stream<PhoneVerificationState> _mapCompleteVerificationToState(
      CompleteVerification event) async* {
    yield PhoneNumberVerified(event.authCredential);
  }

  Stream<PhoneVerificationState> _mapFailVerificationToState(
      FailVerification event) async* {
    yield PhoneVerificationError(event.authFailure.reason);
  }

  Stream<PhoneVerificationState> _mapNotifyCodeSentToState(
      NotifyCodeSent event) async* {
    yield SmsCodeSent(event.verificationId);
  }
}
