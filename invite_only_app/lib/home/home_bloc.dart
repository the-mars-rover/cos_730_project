import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:invite_only_auth/invite_only_auth.dart';
import 'package:invite_only_spaces/invite_only_spaces.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  /// The repository to use for getting the current user.
  final _authRepository = AuthRepository.instance;

  /// The repository to use for getting the stream of spaces
  final _spaceRepository = SpaceRepository.instance;

  @override
  HomeState get initialState => HomeLoading();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is InitializeHome) {
      yield* _mapInitializeHomeToState(event);
    }
  }

  Stream<HomeState> _mapInitializeHomeToState(InitializeHome event) async* {
    yield HomeLoading();

    final currentUser = await _authRepository.currentUser();
    final managedSpacesStream =
        _spaceRepository.managerSpaces(currentUser.phoneNumber);
    final guardingSpacesStream =
        _spaceRepository.guardSpaces(currentUser.phoneNumber);
    final invitingSpacesStream =
        _spaceRepository.inviterSpaces(currentUser.phoneNumber);

    yield HomeReady(
      currentUser,
      managedSpacesStream,
      guardingSpacesStream,
      invitingSpacesStream,
    );
  }
}
