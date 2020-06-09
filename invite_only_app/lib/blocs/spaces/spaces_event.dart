import 'package:equatable/equatable.dart';
import 'package:invite_only_repo/invite_only_repo.dart';
import 'package:meta/meta.dart';

@immutable
abstract class SpacesEvent extends Equatable {
  const SpacesEvent();
}

class LoadSpaces extends SpacesEvent {
  @override
  List<Object> get props => [];
}

class SaveSpace extends SpacesEvent {
  final Space space;

  SaveSpace(this.space);

  @override
  List<Object> get props => [];
}
