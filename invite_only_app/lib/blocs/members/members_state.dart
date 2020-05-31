import 'package:contacts_service/contacts_service.dart';
import 'package:equatable/equatable.dart';

abstract class MembersState extends Equatable {
  const MembersState();
}

class MembersLoading extends MembersState {
  @override
  List<Object> get props => [];
}

class MembersReady extends MembersState {
  final List<Contact> contacts;
  final Set<String> phoneNumbers;

  MembersReady(this.phoneNumbers, this.contacts);

  @override
  List<Object> get props => [phoneNumbers, contacts];
}

class MembersPermissionDenied extends MembersState {
  @override
  List<Object> get props => [];
}

class MembersError extends MembersState {
  final String error;

  MembersError(this.error);

  @override
  List<Object> get props => [this.error];
}
