import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only_repo/invite_only_repo.dart';
import 'package:rxdart/rxdart.dart';

import 'entries_event.dart';
import 'entries_state.dart';

class EntriesBloc extends Bloc<EntriesEvent, EntriesState> {
  final pageSize = 10;

  final _repo = InviteOnlyRepo.instance;

  @override
  EntriesState get initialState => InitialEntriesLoading();

  @override
  Stream<Transition<EntriesEvent, EntriesState>> transformEvents(
    Stream<EntriesEvent> events,
    TransitionFunction<EntriesEvent, EntriesState> transitionFn,
  ) {
    return super.transformEvents(
      events.debounceTime(const Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<EntriesState> mapEventToState(
    EntriesEvent event,
  ) async* {
    if (event is LoadInitialEntries) {
      yield* _mapLoadInitialEntriesToState(event);
    }

    if (event is LoadMoreEntries) {
      yield* _mapLoadMoreEntriesToState(event);
    }
  }

  Stream<EntriesState> _mapLoadInitialEntriesToState(
      LoadInitialEntries event) async* {
    try {
      yield InitialEntriesLoading();
      final fetched = await _repo.fetchEntries(event.space, pageSize, 0);

      yield EntriesLoaded(event.space, 0, fetched, fetched.length < pageSize);
    } on NotFound {
      yield EntriesError("This space no longer exists.");
    } catch (e) {
      yield EntriesError(
          "Sorry, an unexpected error occurred. Please try again later.");
    }
  }

  Stream<EntriesState> _mapLoadMoreEntriesToState(
      LoadMoreEntries event) async* {
    final currentState = state;
    if (currentState is EntriesLoaded) {
      try {
        final space = currentState.space;
        final page = currentState.page + 1;
        var entries = currentState.entries;

        final fetched = await _repo.fetchEntries(space, pageSize, page);

        entries.addAll(fetched);
        entries = entries.toSet().toList(); // remove duplicates
        yield EntriesLoaded(space, page, entries, fetched.length < pageSize);
      } on NotFound {
        yield EntriesError("This space no longer exists.");
      } catch (e) {
        yield EntriesError(
            "Sorry, an unexpected error occurred. Please try again later.");
      }
    }
  }

  static of(BuildContext context) => BlocProvider.of<EntriesBloc>(context);
}
