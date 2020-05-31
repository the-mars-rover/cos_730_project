import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

import 'contacts_event.dart';
import 'contacts_state.dart';

class ContactsBloc extends Bloc<ContactsEvent, ContactsState> {
  @override
  ContactsState get initialState => ContactsLoading();

  @override
  Stream<ContactsState> mapEventToState(
    ContactsEvent event,
  ) async* {
    if (event is LoadContacts) {
      yield* _mapLoadContactsToState(event);
    }
  }

  Stream<ContactsState> _mapLoadContactsToState(LoadContacts event) async* {
    yield ContactsLoading();

    try {
      var permissionStatus = await Permission.contacts.status;
      if (!permissionStatus.isGranted) {
        permissionStatus = await Permission.contacts.request();
        if (!permissionStatus.isGranted) {
          yield ContactsPermissionDenied();
          return;
        }
      }

      final contacts = await ContactsService.getContacts(
        query: event.query,
        withThumbnails: false,
        photoHighResolution: false,
      );

      yield ContactsLoaded(contacts.toList());
    } catch (e) {
      yield ContactsError(
          'Sorry, an unexpected error occurred. Please try again later.');
    }
  }

  static of(BuildContext context) => BlocProvider.of<ContactsBloc>(context);
}
