import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:invite_only_auth/invite_only_auth.dart';
import 'package:invite_only_spaces/invite_only_spaces.dart';

import 'space_details_event.dart';
import 'space_details_state.dart';

class SpaceDetailsBloc extends Bloc<SpaceDetailsEvent, SpaceDetailsState> {
  final AuthRepository _authRepository = AuthRepository.instance;

  final SpaceRepository _spaceRepository = SpaceRepository.instance;

  @override
  SpaceDetailsState get initialState => SpaceDetailsLoading();

  @override
  Stream<SpaceDetailsState> mapEventToState(
    SpaceDetailsEvent event,
  ) async* {
    if (event is LoadSpaceDetails) {
      yield* _mapLoadSpaceDetailsToState(event);
    }
  }

  Stream<SpaceDetailsState> _mapLoadSpaceDetailsToState(
      LoadSpaceDetails event) async* {
    yield SpaceDetailsLoading();

    User currentUser = await _authRepository.currentUser();
    Stream<List<Access>> accessesStream =
        _spaceRepository.accesses(event.space.id);

    yield SpaceDetailsLoaded(currentUser, accessesStream);
  }
}
