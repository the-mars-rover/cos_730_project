import 'package:equatable/equatable.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

abstract class CreateInviteEvent extends Equatable {
  const CreateInviteEvent();
}

class CreateInvite extends CreateInviteEvent {
  final Space space;

  CreateInvite(this.space);

  @override
  List<Object> get props => [space];
}
