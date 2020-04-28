import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final _inviteOnlyRepo = InviteOnlyRepo.instance;

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

    final userStream = _inviteOnlyRepo.currentUser();
    final spacesStream = _inviteOnlyRepo.spaces();

    yield HomeReady(userStream, spacesStream);
  }
}
