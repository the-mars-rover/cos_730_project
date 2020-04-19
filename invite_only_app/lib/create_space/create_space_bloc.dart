import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:invite_only_auth/invite_only_auth.dart';
import 'package:invite_only_spaces/invite_only_spaces.dart';
import 'package:uuid/uuid.dart';

import 'create_space_event.dart';
import 'create_space_state.dart';

class CreateSpaceBloc extends Bloc<CreateSpaceEvent, CreateSpaceState> {
  final _authRepository = AuthRepository.instance;

  final _spaceRepository = SpaceRepository.instance;

  @override
  CreateSpaceState get initialState => CreateSpaceInitializing();

  @override
  Stream<CreateSpaceState> mapEventToState(
    CreateSpaceEvent event,
  ) async* {
    if (event is InitializeCreateSpace) {
      yield* _mapInitializeCreateSpaceToState(event);
    }

    if (event is CreateSpace) {
      yield* _mapCreateSpaceToState(event);
    }
  }

  Stream<CreateSpaceState> _mapInitializeCreateSpaceToState(
      InitializeCreateSpace event) async* {
    yield CreateSpaceInitializing();

    final currentUser = await _authRepository.currentUser();

    yield CreateSpaceInitialized(currentUser);
  }

  Stream<CreateSpaceState> _mapCreateSpaceToState(CreateSpace event) async* {
    final currentState = state;
    if (currentState is CreateSpaceInitialized) {
      yield CreatingSpace();

      final managerPhones = event.managerPhones;
      managerPhones.add(currentState.currentUser.phoneNumber);
      final newSpace = ControlledSpace(
        id: Uuid().v4(),
        title: event.title,
        imageUrl: event.imageUrl,
        managerPhones: event.managerPhones,
        guardPhones: event.guardPhones,
        inviterPhones: event.inviterPhones,
        locationLatitude: event.locationLatitude,
        locationLongitude: event.locationLongitude,
        maxCapacity: event.maxCapacity,
        minAge: event.minAge,
      );

      try {
        await _spaceRepository.createSpace(newSpace);
        yield SpaceCreated(newSpace);
      } catch (e) {
        yield ErrorCreatingSpace(
            'Something went wrong while trying to create the space.');
      }
    }
  }
}
