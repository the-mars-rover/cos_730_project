import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

import 'create_invite_event.dart';
import 'create_invite_state.dart';

class CreateInviteBloc extends Bloc<CreateInviteEvent, CreateInviteState> {
  final InviteOnlyRepo _inviteOnlyRepo = InviteOnlyRepo.instance;

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
      final inviteCode = await _inviteOnlyRepo.invite(event.space);
      yield InviteCreated(inviteCode);
    } catch (e) {
      yield InviteCreationError('Invite could not be created.');
    }
  }
}
