import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

import 'spaces_event.dart';
import 'spaces_state.dart';

class SpacesBloc extends Bloc<SpacesEvent, SpacesState> {
  final _inviteOnlyRepo = InviteOnlyRepo.instance;

  @override
  SpacesState get initialState => SpacesLoading();

  @override
  Stream<SpacesState> mapEventToState(
    SpacesEvent event,
  ) async* {
    if (event is LoadSpaces) {
      yield* _mapLoadSpacesToState(event);
    }
  }

  Stream<SpacesState> _mapLoadSpacesToState(LoadSpaces event) async* {
    yield SpacesLoading();

    try {
      final spaces = await _inviteOnlyRepo.fetchSpaces();
      yield SpacesLoaded(spaces);
    } catch (e) {
      yield SpacesError(
          "Sorry, an unexpected error occurred. Please try again later.");
    }
  }

  static of(BuildContext context) => BlocProvider.of<SpacesBloc>(context);
}
