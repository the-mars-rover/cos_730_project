import 'package:equatable/equatable.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

abstract class SpaceDetailsEvent extends Equatable {
  const SpaceDetailsEvent();
}

class LoadSpaceDetails extends SpaceDetailsEvent {
  final Space space;

  LoadSpaceDetails(this.space);

  @override
  List<Object> get props => [space];
}
