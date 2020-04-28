import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

import 'space_details_event.dart';
import 'space_details_state.dart';

class SpaceDetailsBloc extends Bloc<SpaceDetailsEvent, SpaceDetailsState> {
  final _inviteOnlyRepo = InviteOnlyRepo.instance;

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

    final userStream = _inviteOnlyRepo.currentUser();
    final accessesStream = _inviteOnlyRepo.accesses(event.space);

    yield SpaceDetailsLoaded(userStream, accessesStream);
  }
}
