import 'package:equatable/equatable.dart';

abstract class CreateSpaceState extends Equatable {
  const CreateSpaceState();
}

class CreateSpaceInitial extends CreateSpaceState {
  @override
  List<Object> get props => [];
}

class CreatingSpace extends CreateSpaceState {
  @override
  List<Object> get props => [];
}

class SpaceCreated extends CreateSpaceState {
  @override
  List<Object> get props => [];
}

class ErrorCreatingSpace extends CreateSpaceState {
  final Exception exception;

  ErrorCreatingSpace(this.exception);

  @override
  List<Object> get props => [exception];
}
