import 'package:equatable/equatable.dart';

abstract class MembersEvent extends Equatable {
  const MembersEvent();
}

class LoadMembers extends MembersEvent {
  final Set<String> phoneNumbers;

  LoadMembers(this.phoneNumbers);

  @override
  List<Object> get props => [phoneNumbers];
}

class AddMember extends MembersEvent {
  final String phoneNumber;

  AddMember(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class RemoveMember extends MembersEvent {
  final String phoneNumber;

  RemoveMember(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}
