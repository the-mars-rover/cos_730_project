import 'package:equatable/equatable.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

abstract class InviteEvent extends Equatable {
  const InviteEvent();
}

class CreateInvite extends InviteEvent {
  final Space space;

  CreateInvite(this.space);

  @override
  List<Object> get props => [space];
}
