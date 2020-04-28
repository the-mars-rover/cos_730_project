import 'package:equatable/equatable.dart';

abstract class CreateInviteState extends Equatable {
  const CreateInviteState();
}

class CreatingInvite extends CreateInviteState {
  @override
  List<Object> get props => [];
}

class InviteCreated extends CreateInviteState {
  final String inviteCode;

  InviteCreated(this.inviteCode);

  @override
  List<Object> get props => [inviteCode];
}
