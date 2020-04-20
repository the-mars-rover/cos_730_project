import 'package:equatable/equatable.dart';
import 'package:invite_only_spaces/invite_only_spaces.dart';

abstract class CreateInviteEvent extends Equatable {
  const CreateInviteEvent();
}

class CreateInvite extends CreateInviteEvent {
  final ControlledSpace space;

  CreateInvite(this.space);

  @override
  List<Object> get props => [space];
}
