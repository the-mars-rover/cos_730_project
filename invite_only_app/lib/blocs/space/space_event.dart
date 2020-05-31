import 'package:equatable/equatable.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

abstract class SpaceEvent extends Equatable {
  const SpaceEvent();
}

class SaveSpace extends SpaceEvent {
  final Space space;

  SaveSpace(this.space);

  @override
  List<Object> get props => [];
}
