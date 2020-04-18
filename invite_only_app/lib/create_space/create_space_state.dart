import 'package:equatable/equatable.dart';
import 'package:invite_only_auth/invite_only_auth.dart';
import 'package:invite_only_spaces/invite_only_spaces.dart';

abstract class CreateSpaceState extends Equatable {
  const CreateSpaceState();
}

class CreateSpaceInitializing extends CreateSpaceState {
  @override
  List<Object> get props => [];
}

class CreateSpaceInitialized extends CreateSpaceState {
  final User currentUser;

  CreateSpaceInitialized(this.currentUser);

  @override
  List<Object> get props => [currentUser];
}

class CreatingSpace extends CreateSpaceState {
  @override
  List<Object> get props => [];
}

class SpaceCreated extends CreateSpaceState {
  final ControlledSpace space;

  SpaceCreated(this.space);

  @override
  List<Object> get props => [space];
}

class ErrorCreatingSpace extends CreateSpaceState {
  final String errorMessage;

  ErrorCreatingSpace(this.errorMessage);

  @override
  List<Object> get props => null;
}
