import 'package:equatable/equatable.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

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
  final Invite invite;

  InviteCreated(this.invite);

  @override
  List<Object> get props => [invite];
}
