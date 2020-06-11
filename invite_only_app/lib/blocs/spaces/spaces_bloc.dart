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

    if (event is SaveSpace) {
      yield* _mapSaveSpaceToState(event);
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

  Stream<SpacesState> _mapSaveSpaceToState(SaveSpace event) async* {
    yield SavingSpace(event.space);

    try {
      final phone = await _inviteOnlyRepo.currentUser();
      event.space.managerPhones.add(phone);

      Space space;
      if (event.space.id == null) {
        space = await _inviteOnlyRepo.addSpace(event.space);
      } else {
        space = await _inviteOnlyRepo.updateSpace(event.space);
      }

      yield SpaceSaved(space);
      this.add(LoadSpaces());
    } catch (e) {
      yield ErrorSavingSpace(
          "Sorry, an unexpected error occurred. Please try again later.");
      this.add(LoadSpaces());
    }
  }

  static of(BuildContext context) => BlocProvider.of<SpacesBloc>(context);
}
