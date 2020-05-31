import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    try {
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
    } catch (e) {
      yield PhoneVerificationError(
          "Sorry, an unexpected error occurred. Please try again later.");
    }
  }

  Stream<PhoneVerificationState> _mapSubmitSmsCodeToState(
      SubmitSmsCode event) async* {
    var currentState = state;
    if (currentState is SmsCodeSent) {
      try {
        var authCredential = _inviteOnlyRepo.getAuthCredential(
          currentState.verificationId,
          event.smsCode,
        );
        yield PhoneNumberVerified(authCredential);
      } catch (e) {
        yield PhoneVerificationError(
            "Sorry, an unexpected error occurred. Please try again later.");
      }
    }
  }

  Stream<PhoneVerificationState> _mapCompleteVerificationToState(
      CompleteVerification event) async* {
    yield PhoneNumberVerified(event.authCredential);
  }

  Stream<PhoneVerificationState> _mapFailVerificationToState(
      FailVerification event) async* {
    yield PhoneVerificationError(
        "The phone number could not be verified. Please try again.");
  }

  Stream<PhoneVerificationState> _mapNotifyCodeSentToState(
      NotifyCodeSent event) async* {
    yield SmsCodeSent(event.verificationId);
  }

  static of(BuildContext context) =>
      BlocProvider.of<PhoneVerificationBloc>(context);
}
