import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:invite_only_repo/invite_only_repo.dart';
import 'package:libphonenumber/libphonenumber.dart';
import 'package:permission_handler/permission_handler.dart';

import 'members_event.dart';
import 'members_state.dart';

class MembersBloc extends Bloc<MembersEvent, MembersState> {
  final _inviteOnlyRepo = InviteOnlyRepo.instance;

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
      // Ensure permission is granted
      var permissionStatus = await Permission.contacts.status;
      if (!permissionStatus.isGranted) {
        permissionStatus = await Permission.contacts.request();
        if (!permissionStatus.isGranted) {
          yield MembersPermissionDenied();
          return;
        }
      }

      // get all contacts
      final contacts = await ContactsService.getContacts(
        withThumbnails: false,
        photoHighResolution: false,
      );

      // add self to contacts
      final self = await _inviteOnlyRepo.currentUser();
      final selfContact = Contact(
          displayName: 'You', phones: [Item(label: 'Phone', value: self)]);
      final contactsWithSelf = contacts.toList();
      contactsWithSelf.insert(0, selfContact);

      // internationalize all contacts and phone numbers
      final internationalNumbers =
          await _internationalizePhones(event.phoneNumbers);
      final internationalContacts =
          await _internationalizeContacts(contactsWithSelf);

      yield MembersReady(internationalNumbers, internationalContacts);
    } catch (e) {
      yield MembersError(
          "Sorry, an unexpected error occurred. Please try again later.");
    }
  }

  Stream<MembersState> _mapAddMemberToState(AddMember event) async* {
    final currentState = state;
    yield MembersLoading();
    if (currentState is MembersReady) {
      final internationalized = await _internationalize(event.phoneNumber);
      currentState.phoneNumbers.add(internationalized);
      yield MembersReady(currentState.phoneNumbers, currentState.contacts);
    }
  }

  Stream<MembersState> _mapRemoveMemberToState(RemoveMember event) async* {
    final currentState = state;
    yield MembersLoading();
    if (currentState is MembersReady) {
      final internationalized = await _internationalize(event.phoneNumber);
      currentState.phoneNumbers.remove(internationalized);
      yield MembersReady(currentState.phoneNumbers, currentState.contacts);
    }
  }

  // A helper method to go through all contacts and phone numbers and ensure
  // they are in international format.
  Future<Set<String>> _internationalizePhones(Set<String> phoneNumbers) async {
    final result = Set<String>();

    phoneNumbers.forEach((phone) async {
      final internationalized = await _internationalize(phone);
      result.add(internationalized);
    });

    return result;
  }

  // A helper method to go through all contacts and ensure they are in international format.
  Future<List<Contact>> _internationalizeContacts(
      List<Contact> contacts) async {
    final result = List<Contact>();

    contacts.forEach((contact) {
      final items = List<Item>();
      contact.phones.forEach((phone) async {
        final internationalized = await _internationalize(phone.value);
        items.add(Item(label: phone.label, value: internationalized));
      });
      result.add(Contact(displayName: contact.displayName, phones: items));
    });

    return result;
  }

  // Ensures a phone number conforms to international format
  Future<String> _internationalize(String phone) async {
    if (phone.startsWith('+')) return phone.replaceAll(' ', '');
    final isValid = await PhoneNumberUtil.isValidPhoneNumber(
      phoneNumber: phone,
      isoCode: 'ZA',
    );
    if (!isValid) return phone;

    final inter = await PhoneNumberUtil.normalizePhoneNumber(
      phoneNumber: phone,
      isoCode: 'ZA',
    );

    return inter;
  }

  static of(BuildContext context) => BlocProvider.of<MembersBloc>(context);
}
