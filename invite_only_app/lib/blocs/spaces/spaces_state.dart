import 'package:equatable/equatable.dart';
import 'package:invite_only_repo/invite_only_repo.dart';

abstract class SpacesState extends Equatable {
  const SpacesState();
}

class SpacesLoading extends SpacesState {
  @override
  List<Object> get props => [];
}

class SpacesLoaded extends SpacesState {
  final List<Space> spaces;

  SpacesLoaded(this.spaces);

  @override
  List<Object> get props => [spaces];
}

class SpacesError extends SpacesState {
  final String error;

  SpacesError(this.error);

  @override
  List<Object> get props => [error];
}

class SavingSpace extends SpacesState {
  final Space space;

  SavingSpace(this.space);

  @override
  List<Object> get props => [space];
}

class SpaceSaved extends SpacesState {
  final Space space;

  SpaceSaved(this.space);

  @override
  List<Object> get props => [space];
}

class DeletingSpace extends SpacesState {
  final Space space;

  DeletingSpace(this.space);

  @override
  List<Object> get props => [space];
}

class SpaceDeleted extends SpacesState {
  final Space space;

  SpaceDeleted(this.space);

  @override
  List<Object> get props => [space];
}

class ErrorSavingSpace extends SpacesState {
  final String error;

  ErrorSavingSpace(this.error);

  @override
  List<Object> get props => [error];
}
