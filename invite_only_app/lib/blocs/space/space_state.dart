import 'package:equatable/equatable.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

abstract class SpaceState extends Equatable {
  const SpaceState();
}

class SpaceInitial extends SpaceState {
  @override
  List<Object> get props => [];
}

class SavingSpace extends SpaceState {
  @override
  List<Object> get props => [];
}

class SpaceSaved extends SpaceState {
  final Space space;

  SpaceSaved(this.space);

  @override
  List<Object> get props => [space];
}

class ErrorSavingSpace extends SpaceState {
  final String error;

  ErrorSavingSpace(this.error);

  @override
  List<Object> get props => [error];
}
