import 'package:contacts_service/contacts_service.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ContactsState {}

class ContactsLoading extends ContactsState {}

class ContactsLoaded extends ContactsState {
  final List<Contact> contacts;

  ContactsLoaded(this.contacts);
}

class UserAuthenticated extends ContactsState {
  final String phoneNumber;

  UserAuthenticated(this.phoneNumber);
}

class ContactsPermissionDenied extends ContactsState {}

class ContactsError extends ContactsState {
  final String error;

  ContactsError(this.error);
}
