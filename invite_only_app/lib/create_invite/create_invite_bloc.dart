import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:invite_only_auth/invite_only_auth.dart';
import 'package:invite_only_spaces/invite_only_spaces.dart';

import 'create_invite_event.dart';
import 'create_invite_state.dart';


class CreateInviteBloc extends Bloc<CreateInviteEvent, CreateInviteState> {
  final AuthRepository _authRepository = AuthRepository.instance;

  final SpaceRepository _spaceRepository = SpaceRepository.instance;

  @override
  CreateInviteState get initialState => CreatingInvite();

  @override
  Stream<CreateInviteState> mapEventToState(
    CreateInviteEvent event,
  ) async* {
    if (event is CreateInvite) {
      yield* _mapCreateInviteToState(event);
    }
  }

  Stream<CreateInviteState> _mapCreateInviteToState(CreateInvite event) async* {
    try {
      yield CreatingInvite();
      final currentUser = await _authRepository.currentUser();
      final invite = await _spaceRepository.createInvite(
        event.space.id,
        currentUser.phoneNumber,
      );
      yield InviteCreated(invite);
    } catch (e) {
      yield InviteCreationError('Invite could not be created.');
    }
  }
}
