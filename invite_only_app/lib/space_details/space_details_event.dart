import 'package:equatable/equatable.dart';
import 'package:invite_only_spaces/invite_only_spaces.dart';

abstract class SpaceDetailsEvent extends Equatable {
  const SpaceDetailsEvent();
}

class LoadSpaceDetails extends SpaceDetailsEvent {
  final ControlledSpace space;

  LoadSpaceDetails(this.space);

  @override
  List<Object> get props => [space];
}
