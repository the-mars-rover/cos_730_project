import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

import 'create_space_event.dart';
import 'create_space_state.dart';

class CreateSpaceBloc extends Bloc<CreateSpaceEvent, CreateSpaceState> {
  final _inviteOnlyRepo = InviteOnlyRepo.instance;

  @override
  CreateSpaceState get initialState => CreateSpaceInitial();

  @override
  Stream<CreateSpaceState> mapEventToState(
    CreateSpaceEvent event,
  ) async* {
    if (event is CreateSpace) {
      yield* _mapCreateSpaceToState(event);
    }
  }

  Stream<CreateSpaceState> _mapCreateSpaceToState(CreateSpace event) async* {
    final currentState = state;
    if (currentState is CreateSpaceInitial) {
      yield CreatingSpace();

      try {
        await _inviteOnlyRepo.createSpace(
          inviteOnly: true,
          title: event.title,
          image: null,
          managerPhones: event.managerPhones,
          guardPhones: event.guardPhones,
          inviterPhones: event.inviterPhones,
          locationLatitude: event.locationLatitude,
          locationLongitude: event.locationLongitude,
          minAge: event.minAge,
        );
        yield SpaceCreated();
      } catch (e) {
        yield ErrorCreatingSpace(e);
      }
    }
  }
}
