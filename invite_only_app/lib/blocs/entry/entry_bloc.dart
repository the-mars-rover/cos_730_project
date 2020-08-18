import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

import 'entry_event.dart';
import 'entry_state.dart';

class EntryBloc extends Bloc<EntryEvent, EntryState> {
  final _inviteOnlyRepo = InviteOnlyRepo.instance;

  EntryBloc() : super(GrantingEntry());

  @override
  Stream<EntryState> mapEventToState(
    EntryEvent event,
  ) async* {
    if (event is GrantResidentEntry) {
      yield* _mapGrantResidentEntryToState(event);
    }

    if (event is GrantVisitorEntry) {
      yield* _mapGrantVisitorEntryToState(event);
    }
  }

  Stream<EntryState> _mapGrantResidentEntryToState(
      GrantResidentEntry event) async* {
    yield GrantingEntry();

    try {
      await _inviteOnlyRepo.addEntry(event.space, event.idDocument);

      yield EntryGranted();
    } catch (e) {
      yield ResidentEntryDenied(
          "The user with the given document does not have permission");
    }
  }

  Stream<EntryState> _mapGrantVisitorEntryToState(
      GrantVisitorEntry event) async* {
    yield GrantingEntry();

    try {
      await _inviteOnlyRepo.addEntry(event.space, event.idDocument, event.code);

      yield EntryGranted();
    } on NotFound {
      yield EntryError("This space no longer exists.");
    } on Unauthorized {
      yield EntryError("You no longer have permission to grant entry.");
    } on InvalidInvite {
      yield EntryDenied("The given invite is not valid or has expired.");
    } catch (e) {
      yield EntryError(
          "Sorry, an unexpected error occurred. Please try again later.");
    }
  }

  static of(BuildContext context) => BlocProvider.of<EntryBloc>(context);
}
