import 'package:equatable/equatable.dart';

abstract class InviteState extends Equatable {
  const InviteState();
}

class CreatingInvite extends InviteState {
  @override
  List<Object> get props => [];
}

class InviteCreationError extends InviteState {
  final String error;

  InviteCreationError(this.error);

  @override
  List<Object> get props => [error];
}

class InviteCreated extends InviteState {
  final String inviteCode;

  InviteCreated(this.inviteCode);

  @override
  List<Object> get props => [inviteCode];
}
