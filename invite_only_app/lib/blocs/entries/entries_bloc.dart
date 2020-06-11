import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

import 'entries_event.dart';
import 'entries_state.dart';

class EntriesBloc extends Bloc<EntriesEvent, EntriesState> {
  final _inviteOnlyRepo = InviteOnlyRepo.instance;

  @override
  EntriesState get initialState => EntriesLoading();

  @override
  Stream<EntriesState> mapEventToState(
    EntriesEvent event,
  ) async* {
    if (event is LoadEntries) {
      yield* _mapLoadEntriesToState(event);
    }
  }

  Stream<EntriesState> _mapLoadEntriesToState(LoadEntries event) async* {
    yield EntriesLoading();

    try {
      final entries = await _inviteOnlyRepo.fetchEntries(event.space, 20, 0);

      yield EntriesLoaded(entries);
    } on NotFound {
      yield EntriesError("This space no longer exists.");
    } catch (e) {
      yield EntriesError(
          "Sorry, an unexpected error occurred. Please try again later.");
    }
  }

  static of(BuildContext context) => BlocProvider.of<EntriesBloc>(context);
}
