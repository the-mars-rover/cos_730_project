import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:invite_only_app/app/app.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

import 'grant_access_event.dart';
import 'grant_access_state.dart';

class GrantAccessBloc extends Bloc<GrantAccessEvent, GrantAccessState> {
  final _inviteOnlyRepo = InviteOnlyRepo.instance;

  @override
  GrantAccessState get initialState => GrantingAccess();

  @override
  Stream<GrantAccessState> mapEventToState(
    GrantAccessEvent event,
  ) async* {
    if (event is GrantAccess) {
      yield* _mapGrantAccessToState(event);
    }

    if (event is GrantVisitorAccess) {
      yield* _mapGrantVisitorAccessToState(event);
    }
  }

  Stream<GrantAccessState> _mapGrantAccessToState(GrantAccess event) async* {
    yield GrantingAccess();

    try {
      await _inviteOnlyRepo.grantAccess(
        event.space,
        rsaToDocs(event.scannedIdDocument),
      );

      yield AccessGranted();
    } on AccessDenied {
      yield RequireCode();
    }
  }

  Stream<GrantAccessState> _mapGrantVisitorAccessToState(
      GrantVisitorAccess event) async* {
    yield GrantingAccess();

    try {
      await _inviteOnlyRepo.grantAccess(
        event.space,
        rsaToDocs(event.scannedIdDocument),
        event.code,
      );

      yield AccessGranted();
    } on AccessDenied {
      yield DeniedAccess();
    }
  }
}
