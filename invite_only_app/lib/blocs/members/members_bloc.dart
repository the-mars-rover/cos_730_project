import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'members_event.dart';
import 'members_state.dart';

class MembersBloc extends Bloc<MembersEvent, MembersState> {
  @override
  MembersState get initialState => MembersLoading();

  @override
  Stream<MembersState> mapEventToState(
    MembersEvent event,
  ) async* {
    if (event is LoadMembers) {
      yield* _mapLoadMembersToState(event);
    }

    if (event is AddMember) {
      yield* _mapAddMemberToState(event);
    }

    if (event is RemoveMember) {
      yield* _mapRemoveMemberToState(event);
    }
  }

  Stream<MembersState> _mapLoadMembersToState(LoadMembers event) async* {
    yield MembersLoading();

    try {
      var permissionStatus = await Permission.contacts.status;
      if (!permissionStatus.isGranted) {
        permissionStatus = await Permission.contacts.request();
        if (!permissionStatus.isGranted) {
          yield MembersPermissionDenied();
          return;
        }
      }

      final contacts = await ContactsService.getContacts(
        withThumbnails: false,
        photoHighResolution: false,
      );
      yield MembersReady(event.phoneNumbers, contacts.toList());
    } catch (e) {
      yield MembersError(
          "Sorry, an unexpected error occurred. Please try again later.");
    }
  }

  Stream<MembersState> _mapAddMemberToState(AddMember event) async* {
    final currentState = state;
    yield MembersLoading();
    if (currentState is MembersReady) {
      currentState.phoneNumbers.add(event.phoneNumber);
      yield MembersReady(currentState.phoneNumbers, currentState.contacts);
    }
  }

  Stream<MembersState> _mapRemoveMemberToState(RemoveMember event) async* {
    final currentState = state;
    yield MembersLoading();
    if (currentState is MembersReady) {
      currentState.phoneNumbers.remove(event.phoneNumber);
      yield MembersReady(currentState.phoneNumbers, currentState.contacts);
    }
  }

  static of(BuildContext context) => BlocProvider.of<MembersBloc>(context);
}
