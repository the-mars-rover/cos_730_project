import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

import 'space_event.dart';
import 'space_state.dart';

/// Intended to be used with a single page the [SpaceBloc] provides the business
/// logic to create or edit an access-controlled space.
class SpaceBloc extends Bloc<SpaceEvent, SpaceState> {
  final _inviteOnlyRepo = InviteOnlyRepo.instance;

  @override
  SpaceState get initialState => SpaceInitial();

  @override
  Stream<SpaceState> mapEventToState(
    SpaceEvent event,
  ) async* {
    if (event is SaveSpace) {
      yield* _mapSaveSpaceToState(event);
    }
  }

  Stream<SpaceState> _mapSaveSpaceToState(SaveSpace event) async* {
    final prevState = this.state;
    yield SavingSpace();

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
    } catch (e) {
      yield ErrorSavingSpace(
          "Sorry, an unexpected error occurred. Please try again later.");
      yield prevState;
    }
  }

  static of(BuildContext context) => BlocProvider.of<SpaceBloc>(context);
}
