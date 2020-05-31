import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

import 'invite_event.dart';
import 'invite_state.dart';

class InviteBloc extends Bloc<InviteEvent, InviteState> {
  final InviteOnlyRepo _inviteOnlyRepo = InviteOnlyRepo.instance;

  @override
  InviteState get initialState => CreatingInvite();

  @override
  Stream<InviteState> mapEventToState(
    InviteEvent event,
  ) async* {
    if (event is CreateInvite) {
      yield* _mapCreateInviteToState(event);
    }
  }

  Stream<InviteState> _mapCreateInviteToState(CreateInvite event) async* {
    try {
      yield CreatingInvite();
      final invite = await _inviteOnlyRepo.createInvite(event.space);
      yield InviteCreated(invite.code);
    } on NotFound {
      yield InviteCreationError("This space no longer exists.");
    } on Unauthorized {
      yield InviteCreationError(
          "You no longer have permission to create invites.");
    } catch (e) {
      yield InviteCreationError(
          "Sorry, an unexpected error occurred. Please try again later.");
    }
  }

  static of(BuildContext context) => BlocProvider.of<InviteBloc>(context);
}
