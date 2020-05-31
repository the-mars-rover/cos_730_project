import 'package:meta/meta.dart';

@immutable
abstract class ContactsEvent {}

class LoadContacts extends ContactsEvent {
  final String query;

  LoadContacts(this.query);
}
