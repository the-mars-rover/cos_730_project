import 'package:equatable/equatable.dart';
import 'package:invite_only_spaces/invite_only_spaces.dart';

abstract class CreateInviteState extends Equatable {
  const CreateInviteState();
}

class CreatingInvite extends CreateInviteState {
  @override
  List<Object> get props => [];
}

class InviteCreated extends CreateInviteState {
  final Invite invite;

  InviteCreated(this.invite);

  @override
  List<Object> get props => [invite];
}

class InviteCreationError extends CreateInviteState {
  final String errorMessage;

  InviteCreationError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}
